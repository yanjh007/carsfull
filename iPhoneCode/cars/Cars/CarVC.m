//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "CarVC.h"
#import "Models.h"
#import "JY_Request.h"

static NSString *const LIST_CHARS=@"#ABCDEFGHIJKLMNOPQRSTUVWXYZ";


#pragma mark - 车辆列表
@interface CarVC ()<UIActionSheetDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,JY_STD_Delegate>

@property (weak, nonatomic) IBOutlet UITextField *tv_cnumber;
@property (weak, nonatomic) IBOutlet UITextField *tv_fnumber;
@property (weak, nonatomic) IBOutlet UILabel *lb_brand;
@property (weak, nonatomic) IBOutlet UIButton *bt_delete;
@property (strong, nonatomic) Car *mCar;
@property (strong, nonatomic) NSDictionary *mCarserie;


@property (assign) int showMode;
@property (nonatomic) id<JY_STD_Delegate> mDelegate;

@property (weak, nonatomic) IBOutlet UIPickerView *pv_config;
@property (strong, nonatomic) IBOutlet UIButton *bt_config;
@property (strong, nonatomic) IBOutlet UIButton *bt_year;
@property (strong, nonatomic) IBOutlet UIButton *bt_engine;

@property (strong, nonatomic) IBOutlet UIButton *bt_trans;
@property (strong, nonatomic) IBOutlet UIButton *bt_color;
@property (strong, nonatomic) IBOutlet UIButton *bt_brand;

@property (retain, nonatomic) UIActionSheet *as_edit;
@end

@implementation CarVC

- (id)init
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:5];
    if (self) {
        self.title = @"车辆编辑";

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu3"]
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(do_showmenu:)];
    }
    return self;
}

-(void) setData:(NSObject*)data //0-car 1-delegate
{
    if ([data isKindOfClass:[NSArray class]]) {
        NSArray *adata=(NSArray*)data;
        
        self.mCar       = adata[0];
        self.mDelegate  = adata[1];
        if (self.mCar.carid>-1) {
            self.showMode=1;
            [self.bt_delete setHidden:NO];
            
            self.tv_cnumber.text= self.mCar.carnumber;
            self.tv_fnumber.text= self.mCar.framenumber;
            [self.bt_brand setTitle:[NSString stringWithFormat:@" %@-%@",self.mCar.manufacturer,self.mCar.brand] forState:UIControlStateNormal];
            
        } else { //新建 -1
            self.showMode=0;
            [self.bt_delete setHidden:YES];
            
            self.tv_cnumber.text= @"";
            self.tv_fnumber.text=@"";
            [self.bt_brand setTitle:@"请选择厂商品牌.." forState:UIControlStateNormal];
        }
        
        self.mCar.cfgList   =@[@"高",@"中",@"低"];
        self.mCar.colorList =@[@"白",@"黑",@"红",@"蓝",@"银",@"黄",@"绿"];
        
        int iyear=[[NSDate stringNow:@"YYYY"] integerValue];
        NSMutableArray *ary_years=[NSMutableArray array];
        for (int i=0; i<10; i++) {
            [ary_years addObject:@(iyear-i)];
        }
        self.mCar.yearList=[ary_years copy];
    }
    
}

- (IBAction) do_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)do_seires:(UIButton *)sender {
    UIViewController *vc=[[CarseriesVC alloc] initWithData:@[self]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)do_config:(UIButton *)sender {
    if (sender.tag==self.pv_config.tag) {
        self.pv_config.hidden=!self.pv_config.hidden;
        return;
    }
    
    switch (sender.tag) {
        case 51: //年份
            
            break;
        case 52: //配置
            
            break;
        case 53: //发动机
            
            break;
        case 54: //变速箱
            
            break;
        case 55: //颜色
            
            break;
   
        default:
            return;
    }
    
    self.pv_config.tag=sender.tag;
    [self.pv_config setHidden:NO];
    
    [self.pv_config reloadAllComponents];
}

- (IBAction) do_save:(id)sender
{
    if (self.mCar) [self.mCar save];
    
    [self go_back:YES];
}

- (IBAction)do_delete:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确认删除当前车辆记录?"
                                                             delegate:self
                                                    cancelButtonTitle:@"取 消"
                                               destructiveButtonTitle:@"删 除"
                                                    otherButtonTitles:nil];

    [actionSheet showInView:self.view];
}


- (IBAction) do_showmenu:(id)sender
{
    if (!self.as_edit) {
        if (self.mCar.carid==-1) {
            self.as_edit = [[UIActionSheet alloc] initWithTitle:@"添加新车辆"
                                                       delegate:self
                                              cancelButtonTitle:@"取 消"
                                         destructiveButtonTitle:@"添 加"
                                              otherButtonTitles:nil];
            
        } else {
            self.as_edit = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"车辆编辑:%@",self.mCar.carnumber]
                                                       delegate:self
                                              cancelButtonTitle:@"取 消"
                                         destructiveButtonTitle:@"保 存"
                                              otherButtonTitles:@"删 除",nil];
        }
    }
    [self.as_edit showInView:self.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        if (actionSheet==self.as_edit) {
            if (self.mCar.carid==-1) {
                self.mCar.carnumber= self.tv_cnumber.text;
            }
            self.mCar.framenumber  = self.tv_fnumber.text;
            [self do_save:nil];
        }
    } else if (buttonIndex == actionSheet.firstOtherButtonIndex) { //删除
        if (actionSheet==self.as_edit) {
            if (self.mCar) [self.mCar remove];
            [self go_back:YES];
        }
    }
}

- (void) go_back:(BOOL)bNotify
{
    if (bNotify
        && self.mDelegate
        && [self.mDelegate respondsToSelector:@selector(action:withIndex:)]) {
        [self.mDelegate action:DELE_ACTION_CAR_SAVE_BACK withIndex:1];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    if (pickerView.tag==51) { //年份
        return [self.mCar.yearList count];
    } else if (pickerView.tag==52) { //配置
        return [self.mCar.cfgList count];
    } else if (pickerView.tag==53) { //引擎
        return self.mCar.engineList?[self.mCar.engineList count]:0;
    } else if (pickerView.tag==54) { //变速
        return self.mCar.transList?[self.mCar.transList count]:0;
    } else if (pickerView.tag==55) { //颜色
        return [self.mCar.colorList count];
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if (pickerView.tag==51) {
        return [NSString stringWithFormat:@"%@",self.mCar.yearList[row]];
    } else if (pickerView.tag==52) {
        return self.mCar.cfgList[row];
    } else if (pickerView.tag==53) {
        return self.mCar.engineList[row];
    } else if (pickerView.tag==54) {
        return self.mCar.transList[row];
    } else if (pickerView.tag==55) {
        return self.mCar.colorList[row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag==51) { //年份
        self.mCar.year = [self.mCar.yearList[row] intValue];
        [self.bt_year setTitle:[NSString stringWithFormat:@"%@",self.mCar.yearList[row]] forState:UIControlStateNormal];
    } else if (pickerView.tag==52) { //配置
        self.mCar.cfglevel=self.mCar.cfgList[row];
        [self.bt_config setTitle:self.mCar.cfgList[row] forState:UIControlStateNormal];
    } else if (pickerView.tag==53) { //引擎
        self.mCar.engine=self.mCar.engineList[row];
        [self.bt_config setTitle:self.mCar.engineList[row] forState:UIControlStateNormal];
    } else if (pickerView.tag==54) { //传动
        self.mCar.trans=self.mCar.transList[row];
        [self.bt_config setTitle:self.mCar.transList[row] forState:UIControlStateNormal];
    } else if (pickerView.tag==55) { //颜色
        self.mCar.color=self.mCar.colorList[row];
        [self.bt_color setTitle:self.mCar.colorList[row] forState:UIControlStateNormal];
    }
}

-(int)action:(int)act withTag:(NSObject *)tag
{
    if (act==DELE_ACTION_CARSERIE_CHOOSE_BACK) {
        self.mCarserie=(NSDictionary*)tag;
        NSString *list= self.mCarserie[@"engine_list"];
        if (![NSString isEmpty:list] ) {
            self.mCar.engineList =[list componentsSeparatedByString:@","];
        }
        
        list=self.mCarserie[@"trans_list"];
        if (![NSString isEmpty:list]) {
            self.mCar.transList = [list componentsSeparatedByString:@","];
        }
        
        [self.bt_brand setTitle:[NSString stringWithFormat:@"%@-%@",self.mCarserie[@"manufacturer"],self.mCarserie[@"brand"]]
                       forState:UIControlStateNormal];
        self.mCar.manufacturer=self.mCarserie[@"manufacturer"];
        self.mCar.brand =self.mCarserie[@"brand"];
    }
    
    return DELE_RESULT_VOID;
}

@end

#pragma mark - 车系选择
@interface CarseriesVC() <UITableViewDataSource,UITableViewDelegate,JY_STD_Delegate>
@property (strong, nonatomic) IBOutlet UICollectionView *tb_chars;

@property (strong, nonatomic) IBOutlet UITableView *tb_series;
@property (strong, nonatomic) IBOutlet UIView *v_chars;

@property (nonatomic) id<JY_STD_Delegate> mDelegate;
@property (retain,nonatomic) NSArray *ary_tag_result;

@end

@implementation CarseriesVC

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
