//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "AppointmentVC.h"
#import "LMenuVC.h"
#import "Models.h"
#import "JY_Request.h"

#pragma mark - 预约列表

@interface AppointmentListVC ()<UIActionSheetDelegate,UITextFieldDelegate,JY_STD_Delegate>

@property (retain,nonatomic) NSMutableArray *ary_apmts1,*ary_apmts2,*ary_apmts3;
@property (strong, nonatomic) IBOutlet UITableView *tb_appointments;

@property (retain, nonatomic) UIActionSheet *as_list1,*as_list2,*as_list3;

@end


@implementation AppointmentListVC

- (id)init //0-car 1-delegate
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:7];
    if (self) {
        self.title = @"预约管理";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新预约"
                                                                                  style:UIBarButtonItemStyleBordered
                                                                                 target:self
                                                                                 action:@selector(do_add:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self action:DELE_ACTION_APMT_SAVE_BACK withIndex:1];
    [self refreshData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section==0) {
        return [self.ary_apmts1 count];
    } else if (section==1) {
        return [self.ary_apmts2 count];
    } else if (section==2) {
        return [self.ary_apmts3 count];
    } else {
        return 0;
    }
}
static NSArray *ary_titles;

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    ary_titles=@[@"已确认",@"待确认",@"取消和完成"];
    return ary_titles[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_Info";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Appointment *item;
    
    if (indexPath.section==0) {
        item=self.ary_apmts1[indexPath.row];
    } else if (indexPath.section==1) {
        item=self.ary_apmts2[indexPath.row];
    } else {
        item=self.ary_apmts3[indexPath.row];
    }
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@(%@)",item.acode,item.statusString]];
    [cell.detailTextLabel setText: [NSString stringWithFormat:@"%@-%@-%@",
                                    item.car,item.shopName,[item.plan_at stringValue:STRING_DATE_YMDHM]]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        
    } else if (indexPath.section==1){
        Appointment *item = self.ary_apmts2[indexPath.row];
        AppointmentVC *vc = [[AppointmentVC alloc] initWithData:@[@(1),self,item]];
        
        // We don't want to be able to pan on nav bar to see the left side when we pushed a controller
        [self.revealSideViewController unloadViewControllerForSide:PPRevealSideDirectionLeft];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(void) showCellAction:(int)index
{
    if (!self.as_list1) {
        self.as_list1 = [[UIActionSheet alloc] initWithTitle:@"预约管理"
                                                      delegate:self
                                             cancelButtonTitle:@"取 消"
                                        destructiveButtonTitle:@"编 辑"
                                             otherButtonTitles:@"维护预约",@"维护记录",nil];
        
    }
    [self.as_list1 setTag:index];
    
//    [self.as_list1 setTitle:[NSString stringWithFormat:@"车辆管理:%@",[(Car*)self.info_cars[index] carnumber]]];
    [self.as_list1 showInView:self.view];
    
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (actionSheet==self.as_carcell) {
//        int index=self.as_carcell.tag;
//        if (buttonIndex == actionSheet.destructiveButtonIndex) {
//            [self go_edit:self.info_cars[index]];
//        } else if (buttonIndex == 1) { //预约
//            [self go_appointment:self.info_cars[index]];
//        } else { //维护历史
//            
//        }
//    }
}

#pragma mark - Custom Delegate and Method

- (IBAction) do_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) do_add:(id)sender
{
    AppointmentVC *vc = [[AppointmentVC alloc] initWithData:@[@(0),self,[Appointment newItem]]];
    
    // We don't want to be able to pan on nav bar to see the left side when we pushed a controller
    [self.revealSideViewController unloadViewControllerForSide:PPRevealSideDirectionLeft];
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(int) action:(int)act withIndex:(int)index
{
    if (act==DELE_LIST_RELOAD) {
        [self refreshData];
    } else if (act==DELE_ACTION_APMT_SAVE_BACK) {
        if (index==1) { //yes to commit
            [Appointment submit:^(int status) {
                if (status>0) [self refreshData];
            }];
        }
        [self refreshData];
    }
    return DELE_RESULT_VOID;
}

- (void) refreshData
{
    self.ary_apmts1=[[Appointment getList:1] copy];
    self.ary_apmts2=[[Appointment getList:2] copy];
    self.ary_apmts3=[[Appointment getList:3] copy];
    
    [self.tb_appointments reloadData];
    
}

@end


#pragma mark - 预约编辑

@interface AppointmentVC ()<UIActionSheetDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIButton *bt_car;
@property (strong, nonatomic) IBOutlet UIButton *bt_date;
@property (strong, nonatomic) IBOutlet UIButton *bt_shop;
@property (strong, nonatomic) IBOutlet UILabel *lb_acode;
@property (strong, nonatomic) IBOutlet UILabel *lb_status;
@property (strong, nonatomic) IBOutlet UIPickerView *pv_items;
@property (retain, nonatomic) IBOutlet UIDatePicker *pv_ptime;

@property (retain, nonatomic) IBOutlet UIButton *bt_delete;

@property (retain, nonatomic) UIActionSheet *ac_cars;
@property (retain, nonatomic) NSArray *ary_cars,*ary_shops;

@property (nonatomic) id<JY_STD_Delegate> mDelegate;

@property (assign) int showMode;
@property (retain, nonatomic) Car *mCar; //验证码和临时密码
@property (retain, nonatomic) Appointment *mAppointment; //验证码和临时密码

@property (retain,nonatomic) NSDate *time_plan;

@end

@implementation AppointmentVC

- (id)initWithData:(NSArray*)adata; //0-car 1-delegate
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:6];
    if (self) {
        self.showMode    = [adata[0] intValue] ;
        self.mDelegate   = adata[1];
        self.mAppointment=adata[2];

        if (self.showMode==0) { //新建
            self.title = @"新建预约";
            
        } else { //修改
            self.title = @"预约编辑";
            
            self.lb_acode.text=self.mAppointment.acode;
        }
        
        
        [self.lb_acode  setText :[NSString isEmpty:self.mAppointment.acode]?@"<新预约>":self.mAppointment.acode];
        [self.bt_car    setTitle: self.mAppointment.car  forState:UIControlStateNormal];
        [self.bt_shop   setTitle: self.mAppointment.shopName forState:UIControlStateNormal];
        [self.bt_date   setTitle: [self.mAppointment.plan_at stringValue:STRING_DATE_YMDHM] forState:UIControlStateNormal];
        [self.lb_status setText:  [self.mAppointment statusString]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.pv_items setHidden:YES];
    self.pv_items.tag=0;
    
    self.ary_cars  = [Car getCars];
    self.ary_shops = [Shop getList];

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


- (IBAction) do_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) do_save:(id)sender
{
    [self save:NO];
}

- (IBAction) do_save_commit:(id)sender
{
    [self save:YES];
}

- (void) save:(BOOL)bCommit
{
    self.mAppointment.status=bCommit?AppointmentStatusForSubmit:AppointmentStatusEdit;
    [self.mAppointment save];
    
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(action:withIndex:)])
        [self.mDelegate action:DELE_ACTION_APMT_SAVE_BACK withIndex:bCommit?1:2];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)do_delete:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"确认取消当前预约?"
                                                             delegate:self
                                                    cancelButtonTitle:@"关 闭"
                                               destructiveButtonTitle:@"取消预约"
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
    if (bNotify && self.mDelegate && [self.mDelegate respondsToSelector:@selector(action:withIndex:)])
        [self.mDelegate action:DELE_ACTION_APMT_SAVE_BACK withIndex:1];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)do_select_car:(id)sender {
    [self showPicker:1];

}
- (IBAction)do_select_shop:(UIButton *)sender {
    [self showPicker:2];
}

-(void) showPicker:(int)ipick
{
    if (self.pv_items.tag!=ipick) {
        self.pv_items.tag=ipick;
        
        [self.pv_items reloadAllComponents];
        [self.pv_items setHidden:NO];
    } else {
        [self.pv_items setHidden:!self.pv_items.hidden];
    }
    
    if (!self.pv_items.hidden) {
        [self.pv_ptime setHidden:YES];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *) pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    if (pickerView.tag==1) {
        return self.ary_cars.count;
    } else if (pickerView.tag==2) {
        return self.ary_shops.count;
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if (pickerView.tag==1) {
        Car *item=self.ary_cars[row];
        return item.carnumber;
    } else if (pickerView.tag==2) {
        Shop *item=self.ary_shops[row];
        return [NSString stringWithFormat:@"%@(%@)",item.name,item.scode];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag==1) {
        Car *item=self.ary_cars[row];
        [self.bt_car setTitle:item.carnumber forState:UIControlStateNormal];
        self.mAppointment.car=item.carnumber;
    } else if (pickerView.tag==2) {
        Shop *item=self.ary_shops[row];
        
        [self.bt_shop setTitle:item.name forState:UIControlStateNormal];
        self.mAppointment.shop=item.scode;
    }
    
}

- (IBAction)do_date:(UIButton *)sender {
    [self.pv_ptime setHidden:!self.pv_ptime.hidden];
    if (!self.pv_ptime.hidden) {
        [self.pv_items setHidden:YES];
    }
}

- (IBAction)do_ptime_change:(UIDatePicker *)sender {
    self.mAppointment.plan_at=sender.date;

    [self.bt_date setTitle:[self.mAppointment.plan_at stringValue:STRING_DATE_YMDHM] forState:UIControlStateNormal];
}

@end

