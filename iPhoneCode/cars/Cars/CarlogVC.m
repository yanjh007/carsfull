//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "CarlogVC.h"
#import "Models.h"
#import "JY_Request.h"

#pragma mark - 行车日志
@interface CarlogVC ()<UITableViewDataSource,UITableViewDelegate,JY_STD_Delegate>

@property (retain, nonatomic) IBOutlet UITableView *tb_content;
@property (retain, nonatomic) NSArray *ary_logs,*ary_cars;
@property (retain, nonatomic) Car *mCar;

@property (assign) int showMode;
@property (nonatomic) id<JY_STD_Delegate> mDelegate;
@end

@implementation CarlogVC

- (id)init
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:11];
    if (self) {
        self.title = @"行车日志";

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu3"]
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(do_back:)];
        
        self.ary_cars = [Car getCars];
        if (self.ary_cars.count>0) {
            
            self.ary_logs= [(Car*)self.ary_cars[0] getLogs];
            
            
            [self.tb_content reloadData];
            [self.tb_content selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                         animated:YES
                                   scrollPosition:UITableViewScrollPositionTop];
        }
        
        
    }
    return self;
}


- (IBAction) do_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) do_addlog:(id)sender
{
    
}

#pragma mark - Table and Custom Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2; // 1 Car check
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section==0) {
        return [self.ary_cars count];
        
    } else {
        return [self.ary_logs count]+1;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    if (section==0) {
        return @"车辆列表";
    } else {
        if (self.mCar) {
            return [NSString stringWithFormat:@"行车日志: %@",self.mCar.carnumber];
        } else {
            return  @"行车日志";
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_Carlog";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSString *title,*subtitle;
    if (indexPath.section==0) { //车辆列表
        Car *car = self.ary_cars[indexPath.row];
        title    = car.carnumber;
        subtitle = car.carnumber;
    } else {
        if (indexPath.row==0) {
            title    = @"新记录";
            subtitle = @"";
        } else {
            Carlog *carlog= self.ary_logs[indexPath.row-1];
            title    = [NSString stringWithFormat:@"%i",carlog.lmiles];
            subtitle = carlog.ltimestr;
        }
    }
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = subtitle;
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            if (self.mCar) {
                Carlog *cl=[Carlog new];
                [cl setTime];
                cl.lmiles = cl.ltime;
                
                [self.mCar addLog:cl];
                
                self.ary_logs = [self.mCar getLogs];
                [self.tb_content reloadSections:[NSIndexSet indexSetWithIndex:1]
                               withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
    } else if (indexPath.section==0) {
        self.mCar = self.ary_cars[indexPath.row];
        self.ary_logs = [self.mCar getLogs];
        [self.tb_content reloadSections:[NSIndexSet indexSetWithIndex:1]
                       withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


-(int)action:(int)act withTag:(NSObject *)tag
{
    if (act==DELE_ACTION_CARSERIE_CHOOSE_BACK) {

    }
    
    return DELE_RESULT_VOID;
}

@end

#pragma mark - 行车日志编辑
@interface CarlogEditVC() <UITableViewDataSource,UITableViewDelegate,JY_STD_Delegate>
@property (strong, nonatomic) IBOutlet UICollectionView *tb_chars;

@property (strong, nonatomic) IBOutlet UITableView *tb_series;
@property (strong, nonatomic) IBOutlet UIView *v_chars;

@property (nonatomic) id<JY_STD_Delegate> mDelegate;
@property (retain,nonatomic) NSArray *ary_tag_result;

@end

@implementation CarlogEditVC

- (id)initWithData:(NSArray*)adata; //0-car 1-delegate
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:10];
    if (self) {
        self.title = @"车系设置";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"]
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(do_back:)];
        if (adata) self.mDelegate = adata[0];
        
        [self addCharButtons];

    }
    return self;
}

static NSString *const LIST_CHARS=@"#ABCDEFGHIJKLMNOPQRSTUVWXYZ";
-(void) addCharButtons
{
    UIButton *btn;
    int count=LIST_CHARS.length;
    for (int i=0; i<count; i++) {
        float x = 16+i%9*32;
        float y = i/9*32;
        btn =[[UIButton alloc] initWithFrame:CGRectMake(x, y, 32, 32)];
        [btn setTitle:[LIST_CHARS substringWithRange:NSMakeRange(i, 1)] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(do_char:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.v_chars addSubview:btn];
        
    }
}

- (IBAction) do_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) do_char:(UIButton*)sender
{
    
    [JY_Request post:@{@"M":@"carseries",
                       @"K":sender.titleLabel.text}
             withURL:URL_BASE_URL
          completion:^(int status, NSString *result){
              if (status==JY_STATUS_OK) {
                  NSDictionary *json=[result jsonObject];
                  if (json && [JVAL_RESULT_OK isEqualToString:json[JKEY_RESULT]]) {
                      self.ary_tag_result = json[JKEY_CONTENT] ;
                      [self.tb_series reloadData];
                      return;
                  }
                  
              }
              NSLog(@"Error:%@",result);
          }];
    
}


- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.destructiveButtonIndex) {

        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) go_back:(int)row
{
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(action:withTag:)]) {
        [self.mDelegate action:DELE_ACTION_CARSERIE_CHOOSE_BACK
                       withTag:[self.ary_tag_result[row] copy]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - System Delegate
static const NSArray *ary_menu;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ary_tag_result?[self.ary_tag_result count]:0;
}
static NSArray *ary_titles;


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_Menu";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@-%@",
                             self.ary_tag_result[indexPath.row][@"manufacturer"],self.ary_tag_result[indexPath.row][@"brand"]]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self go_back:indexPath.row];
    
}

@end

