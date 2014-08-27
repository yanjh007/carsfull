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

