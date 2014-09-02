//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "HomeVC.h"
#import "LMenuVC.h"
#import "LoginVC.h"
#import "Models.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (id)init
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:1];
    if (self) {
        // Custom initialization
        [Shop syncShops]; //同步店铺信息
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"主 页";    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu1"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(showMenu:)];
}

- (void) showMenu:(id)sender
{
    // used to push a new controller, but we preloaded it !
//    LeftViewController *left = [[LeftViewController alloc] initWithStyle:UITableViewStylePlain];
//    [self.revealSideViewController pushViewController:left onDirection:PPRevealSideDirectionLeft animated:YES];
    
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    LMenuVC *menu = [[LMenuVC alloc] init];
    [self.revealSideViewController preloadViewController:menu forSide:PPRevealSideDirectionLeft];
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
    LoginVC *vc = [[LoginVC alloc] init];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:vc];
    if (PPSystemVersionGreaterOrEqualThan(5.0))
        [self presentModalViewController:n animated:YES];
    else
        [self.revealSideViewController presentModalViewController:n animated:YES];
}





@end
