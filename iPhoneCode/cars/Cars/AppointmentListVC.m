//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "Models.h"
#import "JY_Request.h"
#import "LMenuVC.h"
#import "AppointmentListVC.h"
#import "AppointmentVC.h"


@interface AppointmentListVC ()<UIActionSheetDelegate,UITextFieldDelegate>
@property (retain,nonatomic) NSMutableArray *ary_apmts1,*ary_apmts2,*ary_apmts3;

@end

@implementation AppointmentListVC

- (id)init //0-car 1-delegate
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:7];
    if (self) {
        self.ary_apmts1=[[Appointment getList:0] copy];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"预约管理";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu1"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(showMenu:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新预约"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                             action:@selector(do_add:)];
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
    } else {
        return 0;
    }
    
}
static NSArray *ary_titles;

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    ary_titles=@[@"计划中",@"未计划",@"已取消"];
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
        cell.textLabel.text=item.acode;
        
    } else if (indexPath.section==1) {
        item=self.ary_apmts2[indexPath.row];
        cell.textLabel.text=item.acode;

    } else {
        item=self.ary_apmts3[indexPath.row];
        cell.textLabel.text=item.acode;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {

        
    }
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


- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        
    }
}



@end

