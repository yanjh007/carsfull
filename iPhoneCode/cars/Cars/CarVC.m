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

#pragma mark - 车辆列表
@interface CarVC ()<UIActionSheetDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tv_cnumber;
@property (weak, nonatomic) IBOutlet UITextField *tv_fnumber;
@property (weak, nonatomic) IBOutlet UILabel *lb_brand;
@property (weak, nonatomic) IBOutlet UIButton *bt_delete;
@property (strong, nonatomic) NSString *verify_code,*pass_code; //验证码和临时密码
@property (strong, nonatomic) Car *mCar; //验证码和临时密码
@property (assign) int showMode;
@property (nonatomic) id<JY_STD_Delegate> mDelegate;

@end

@implementation CarVC

- (id)initWithData:(NSArray*)adata; //0-car 1-delegate
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:5];
    if (self) {
        self.mCar       = adata[0];
        self.mDelegate  = adata[1];
        if (self.mCar.carnumber) {
            self.showMode=1;
            [self.bt_delete setHidden:NO];

            self.tv_cnumber.text= self.mCar.carnumber;
            self.tv_fnumber.text= self.mCar.framenumber;
            
        } else { //新建
            self.showMode=0;
            [self.bt_delete setHidden:YES];
            
            self.tv_cnumber.text= @"";
            self.tv_fnumber.text=@"";
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"车辆编辑";
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(do_back:)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                             action:@selector(do_save:)];
}

- (IBAction) do_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) do_save:(id)sender
{
    if (self.mCar.carnumber) {
        [self.mCar update:self.tv_fnumber.text];
    } else {
        [Car add:self.tv_cnumber.text
     framenumber:self.tv_fnumber.text];
    }

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

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        if (self.mCar.carnumber) {
            [self.mCar remove];
            [self go_back:YES];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) go_back:(BOOL)bNotify
{
    if (bNotify
        && self.mDelegate
        && [self.mDelegate respondsToSelector:@selector(action:withIndex:)]) {
        [self.mDelegate action:DELE_LIST_RELOAD withIndex:1];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end

#pragma mark - 车系选择
@interface CarseriesVC() <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate,JY_STD_Delegate>
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
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu1"]
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(showMenu:)];
        
        [self addCharButtons];

    }
    return self;
}

- (void) showMenu:(id)sender
{
    // used to push a new controller, but we preloaded it !
    //    LeftViewController *left = [[LeftViewController alloc] initWithStyle:UITableViewStylePlain];
    //    [self.revealSideViewController pushViewController:left onDirection:PPRevealSideDirectionLeft animated:YES];
    
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

static NSString *const LIST_CHARS=@"#ABCDEFGHIJKLMNOPQRSTUVWXYZ";
-(void) addCharButtons
{
    UILabel *lb; UIButton *btn;
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

- (IBAction)do_delete:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确认删除当前车辆记录?"
                                                             delegate:self
                                                    cancelButtonTitle:@"取 消"
                                               destructiveButtonTitle:@"删 除"
                                                    otherButtonTitles:nil];
    
    [actionSheet showInView:self.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.destructiveButtonIndex) {

        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) go_back:(BOOL)bNotify
{
    if (bNotify
        && self.mDelegate
        && [self.mDelegate respondsToSelector:@selector(action:withIndex:)]) {
        [self.mDelegate action:DELE_LIST_RELOAD withIndex:1];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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
 
    
}

@end

