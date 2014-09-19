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
#import "User.h"
#import "UserVC.h"
#import "CarVC.h"


@interface LMenuVC ()

@end

@implementation LMenuVC
static LMenuVC *instance=nil;

+(instancetype) sharedVC
{
    @synchronized(self) {
        if (!instance) {
            instance=[[LMenuVC alloc] init];
        }
        return instance;
    }
}

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


#pragma mark - Table view data source
static const NSArray *ary_menu;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ary_menu = @[@"主 页",@"我 的",@"店 铺",@"预 约",@"设 置",@"关 于",@"行车日志",@"连 线"];
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
        case 1: //我的
            if ([User currentUser].token.length>0) {
                [self showVC:VC_NAME_INFO];
            } else {
                [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
                
                LoginVC *vc = [[LoginVC alloc] init];
                UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:vc];
                if (PPSystemVersionGreaterOrEqualThan(5.0))
                    [self presentModalViewController:n animated:YES];
                else
                    [self.revealSideViewController presentModalViewController:n animated:YES];
                
            }
            return;
        case 2: //店铺
            [self showVC:VC_NAME_SHOP]; return;
        case 3: //预约
            [self showVC:VC_NAME_APPIONTMENT_LIST]; return;
        case 4: //设置
            [self showVC:VC_NAME_HOME]; return;
        case 5: //关于
            [self showVC:VC_NAME_SHOP]; return;
        case 6: //行车日志
            [self showVC:VC_NAME_CAR_LOG]; return;
        case 7: //连线游戏
            [self showVC:VC_NAME_LINK]; return;
        default:
            [self showVC:VC_NAME_HOME]; return;
            return;
    }
}

-(void) showVC:(NSString*)vcname
{
    UIViewController *vc=[NSClassFromString(vcname) new];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self.revealSideViewController popViewControllerWithNewCenterController:nvc
                                                                   animated:YES];
    
}


@end
