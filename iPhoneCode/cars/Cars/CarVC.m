//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "CarVC.h"
#import "JY_Request.h"


@interface CarVC ()
@property (weak, nonatomic) IBOutlet UITextField *tv_carnumber;
@property (weak, nonatomic) IBOutlet UITextField *tv_brand;
@property (weak, nonatomic) IBOutlet UILabel *lb_brand;
@property (strong, nonatomic) NSString *verify_code,*pass_code; //验证码和临时密码
@property (assign) int showMode;
@end

@implementation CarVC

- (id)initWithData:(NSArray*)adata;
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:5];
    if (self) {
        if (adata) {
            self.showMode=1;
            self.tv_carnumber.text=adata[0];
        } else { //新建
            self.showMode=0;
        }
        // Custom initialization
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

- (void) do_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) do_save:(id)sender
{
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

