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


@interface AppointmentListVC ()<UIActionSheetDelegate,UITextFieldDelegate,JY_STD_Delegate>
@property (retain,nonatomic) NSMutableArray *ary_apmts1,*ary_apmts2,*ary_apmts3;
@property (strong, nonatomic) IBOutlet UITableView *tb_appointments;

@end

@implementation AppointmentListVC

- (id)init //0-car 1-delegate
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:7];
    if (self) {
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
    
    [self refreshData];
    [self submitAppoints];
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
    ary_titles=@[@"已确认",@"待确认",@"已取消"];
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

    [cell.textLabel setText:item.car];
    [cell.detailTextLabel setText:item.acode];
    
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

-(int) action:(int)act withIndex:(int)index
{
    if (act==DELE_LIST_RELOAD) {
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

- (void) submitAppoints
{
    NSString *token =[JY_Default getString:PKEY_TOKEN];
    NSString *user  =[JY_Default getString:PKEY_TOKEN_USERID];
    
    NSString *apmts= [Appointment getForSubmit];
    
    if (apmts) {
        [JY_Request post:@{@"M":@"apmts",
                           @"I":[JY_Helper fakeIMEI],
                           @"S":token?token:@"",
                           @"U":user?user:@"",
                           @"C":apmts?apmts:@""
                           }
                 withURL:URL_BASE_URL
              completion:^(int status, NSString *result){
                  if (status==JY_STATUS_OK) {
                      [self handleResult:result];
                  } else {
                      NSLog(@"数据错误");
                  }
                  
              }];
    }
    
    
}

-(void) handleResult:(NSString*) result
{
    NSLog(@"result:%@",result);
    NSDictionary *json=[result jsonObject];
    if (json) {
        NSDictionary *content=json[JKEY_CONTENT] ;
        if ([JVAL_RESULT_OK isEqualToString:json[JKEY_RESULT]]) {

            
        } else {
            NSLog(@"内容错误%@",content[JKEY_CONTENT]);
        }
    } else {
        NSLog(@"格式错误");
    }
}

@end

