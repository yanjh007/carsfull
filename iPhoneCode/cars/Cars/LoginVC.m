//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "LoginVC.h"
#import "LMenuVC.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *tv_user;
@property (weak, nonatomic) IBOutlet UITextField *tv_code;

@end

@implementation LoginVC

- (id)init
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:4];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"系统绑定";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                             action:@selector(do_close:)];
}

- (void) do_close:(id)sender
{
    [self.parentViewController dismissModalViewControllerAnimated:YES];
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

- (IBAction)do_login:(UIButton *)sender {
    
    
}




@end
