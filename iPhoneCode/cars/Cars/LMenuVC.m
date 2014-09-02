//
//  LeftViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "LMenuVC.h"
#import "HomeVC.h"
#import "AboutVC.h"
#import "LoginVC.h"
#import "InfoVC.h"
#import "ShopVC.h"
#import "AppointmentVC.h"

@interface LMenuVC ()

@end

@implementation LMenuVC

- (id)init
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:0];
    if (self) {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (IBAction)go_content:(UIButton *)sender {

}

- (IBAction)go_about:(UIButton *)sender {
    AboutVC *vc = [[AboutVC alloc] init];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealSideViewController popViewControllerWithNewCenterController:n
                                                                   animated:YES];

}

- (IBAction)go_info:(UIButton *)sender {
    InfoVC *vc = [[InfoVC alloc] init];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealSideViewController popViewControllerWithNewCenterController:n
                                                                   animated:YES];
    
}

- (IBAction)go_appointment:(UIButton *)sender {
    AppointmentListVC *vc = [[AppointmentListVC alloc] init];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealSideViewController popViewControllerWithNewCenterController:n
                                                                   animated:YES];
}


- (IBAction)do_close:(UIButton *)sender {
    
    
}

- (IBAction)do_login:(UIButton *)sender {
    LoginVC *vc = [[LoginVC alloc] init];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:vc];
    if (PPSystemVersionGreaterOrEqualThan(5.0))
        [self presentModalViewController:n animated:YES];
    else
        [self.revealSideViewController presentModalViewController:n animated:YES];
    
}

#pragma mark - Table view data source
static const NSArray *ary_menu;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ary_menu = @[@"主页",@"我的",@"店铺",@"预约",@"设置",@"关于"];
    return ary_menu.count;
}
static NSArray *ary_titles;


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_Menu";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText: ary_menu[indexPath.row]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc;
    switch (indexPath.row) {
        case 0: //主页
            vc = [[HomeVC alloc] init];
            break;
        case 1: //我的
            vc = [[InfoVC alloc] init];
            break;
        case 2: //店铺
            vc = [[ShopVC alloc] init];
            break;
        case 3: //预约
            vc = [[AppointmentListVC alloc] init];
            break;
        case 4:
            vc = [[HomeVC alloc] init];
            break;
        case 5: //关于
            vc = [[AboutVC alloc] init];
            break;
            
        default:
            return;
            break;
    }
    
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealSideViewController popViewControllerWithNewCenterController:n
                                                                   animated:YES];

}





@end
