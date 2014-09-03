//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "InfoVC.h"
#import "LMenuVC.h"
#import "CarVC.h"
#import "AppointmentVC.h"
#import "Models.h"

@interface InfoVC ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,JY_STD_Delegate>
@property (retain, nonatomic) IBOutlet UITableView *tb_info;
@property (retain,nonatomic) NSMutableArray *info_base,*info_cars;
@property (retain, nonatomic) UIActionSheet *as_carcell;
@end

@implementation InfoVC

- (id)init
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:3];
    if (self) {
        self.info_base=[@[@{
                             @"title":@"用户标示(手机号)",
                             @"value":@"13808077424",
                             @"descp":@"用户手机号，用于登录"
                             },
                         @{
                             @"title":@"用户姓名",
                             @"value":@"颜建华",
                             @"descp":@"用户姓名，显示"
                             },
                         @{
                             @"title":@"客户地址",
                             @"value":@"天府软件园",
                             @"descp":@"用户姓名，显示"
                             }
                        ] copy];
        self.info_cars =  [[Car getCars] copy];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"用户设置";

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section==0) {
        return [self.info_base count];
    } else {
        return [self.info_cars count]+1;
    }

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    if (section==0) {
        return @"基本信息";
    } else {
        return @"车辆信息";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_Info";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section==0) {
        NSDictionary *item=self.info_base[indexPath.row];
        
        cell.textLabel.text = item[@"title"];
        cell.detailTextLabel.text = item[@"value"];
    } else {
        if (indexPath.row == [self.info_cars count]) {
            cell.textLabel.text = @"[新车辆]";
            cell.detailTextLabel.text = @"点击添加管理新车辆记录";
        } else {
            Car *item=self.info_cars[indexPath.row];
            
            cell.textLabel.text = item.carnumber;
            cell.detailTextLabel.text =item.framenumber;
        }
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        Car *item;
        if (indexPath.row < [self.info_cars count]) {
            [self showCellAction:indexPath.row];
            item = self.info_cars[indexPath.row];
        } else {
            [self go_edit:[[Car alloc]init]];
        }
    }
}


-(void) showCellAction:(int)index
{
    if (!self.as_carcell) {
        self.as_carcell = [[UIActionSheet alloc] initWithTitle:@"车辆管理"
                                      delegate:self
                             cancelButtonTitle:@"取 消"
                        destructiveButtonTitle:@"编 辑"
                             otherButtonTitles:@"维护预约",@"维护记录",nil];
 
    }
    [self.as_carcell setTag:index];
    
    [self.as_carcell setTitle:[NSString stringWithFormat:@"车辆管理:%@",[(Car*)self.info_cars[index] carnumber]]];
    [self.as_carcell showInView:self.view];
    
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet==self.as_carcell) {
        int index=self.as_carcell.tag;
        if (buttonIndex == actionSheet.destructiveButtonIndex) {
            [self go_edit:self.info_cars[index]];
        } else if (buttonIndex == 1) { //预约
            [self go_appointment:self.info_cars[index]];
        } else { //维护历史
            
        }
    }
}

// 编辑车辆
-(void) go_edit:(Car*) car
{
    CarVC *vc = [[CarVC alloc] initWithData:@[car,self]];
    
    // We don't want to be able to pan on nav bar to see the left side when we pushed a controller
    [self.revealSideViewController unloadViewControllerForSide:PPRevealSideDirectionLeft];
    [self.navigationController pushViewController:vc animated:YES];
}

// 车辆预约
-(void) go_appointment:(Car*) car
{
    Appointment *item = [Appointment newItem];
    item.car= car.carnumber;
    AppointmentVC *vc = [[AppointmentVC alloc] initWithData:@[@(0),self,item]];

    // We don't want to be able to pan on nav bar to see the left side when we pushed a controller
    [self.revealSideViewController unloadViewControllerForSide:PPRevealSideDirectionLeft];
    [self.navigationController pushViewController:vc animated:YES];
}


-(int) action:(int)act withIndex:(int)index
{
    if (act==DELE_LIST_RELOAD) {
        if (index==1) { //call from CarVC
            self.info_cars =  [[Car getCars] copy];
            [self.tb_info reloadData];
        }
        
    }
    return DELE_RESULT_VOID;
}

@end
