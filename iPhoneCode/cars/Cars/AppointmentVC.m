//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "AppointmentVC.h"

#import "Models.h"
#import "JY_Request.h"

@interface AppointmentVC ()<UIActionSheetDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIButton *bt_car;
@property (strong, nonatomic) IBOutlet UIButton *bt_date;
@property (strong, nonatomic) IBOutlet UIButton *bt_shop;
@property (strong, nonatomic) IBOutlet UILabel *lb_acode;
@property (strong, nonatomic) IBOutlet UILabel *lb_status;
@property (strong, nonatomic) IBOutlet UIPickerView *pv_items;

@property (retain, nonatomic) IBOutlet UIButton *bt_delete;

@property (retain, nonatomic) UIActionSheet *ac_cars;
@property (retain, nonatomic) NSArray *ary_cars;


@property (nonatomic) id<JY_STD_Delegate> mDelegate;

@property (assign) int showMode;
@property (retain, nonatomic) Car *mCar; //验证码和临时密码
@property (retain, nonatomic) Appointment *mAppointment; //验证码和临时密码

@end

@implementation AppointmentVC

- (id)initWithData:(NSArray*)adata; //0-car 1-delegate
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:6];
    if (self) {
        self.showMode   = [adata[0] intValue] ;
        self.mDelegate  = adata[1];
        self.mAppointment=adata[2];

        if (self.showMode==0) { //新建
            self.title = @"新建预约";
            
        } else { //修改
            self.title = @"预约编辑";
            self.lb_acode.text=self.mAppointment.acode;
        }
        
        [self.bt_car   setTitle:self.mAppointment.car  forState:UIControlStateNormal];
        [self.bt_shop  setTitle:self.mAppointment.shop forState:UIControlStateNormal];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(do_back:)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                             action:@selector(do_save:)];
    
    self.ary_cars = [Car getCars];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.pv_items setHidden:YES];
    self.pv_items.tag=0;
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
    NSString *stime=[NSDate stringNow:STRING_DATE_YMDHMS];
    
    [self.mAppointment save:stime car:self.mAppointment.car andShop:self.mAppointment.shop];

    [self go_back:YES];
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
    if (bNotify &&
        self.mDelegate &&
        [self.mDelegate respondsToSelector:@selector(action:withIndex:)]) {
            [self.mDelegate action:DELE_LIST_RELOAD withIndex:1];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)do_select_car:(id)sender {
    [self showPicker:1];

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

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *) pickerView
{
    if (pickerView.tag==1) {
        return 1;
    } else {
        return 2;
    }
    return 0;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    if (pickerView.tag==1) {
        return [self.ary_cars count];
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if (pickerView.tag==1) {
        Car *item=self.ary_cars[row];
        return item.carnumber;
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag==1) {
        Car *item=self.ary_cars[row];
        [self.bt_car setTitle:item.carnumber forState:UIControlStateNormal];
    }
    
}

@end

