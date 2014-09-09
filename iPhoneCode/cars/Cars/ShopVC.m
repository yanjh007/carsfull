//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "ShopVC.h"
#import "LMenuVC.h"
#import "CarVC.h"
#import "AppointmentVC.h"
#import "Models.h"

@interface ShopVC ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,JY_STD_Delegate>
@property (retain, nonatomic) IBOutlet UITableView *tb_shop;
@property (retain,nonatomic) NSArray *ary_shops;
@property (retain, nonatomic) UIActionSheet *as_shopcell;
@end

@implementation ShopVC

- (id)init
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:8];
    if (self) {
        self.title = @"店铺列表";
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.ary_shops = [Shop getList];
    [self.tb_shop reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.ary_shops count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell_Shop";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Shop *item=self.ary_shops[indexPath.row];

    cell.textLabel.text = item.name;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showCellAction:indexPath.row];
}


-(void) showCellAction:(int)index
{
    if (!self.as_shopcell) {
        self.as_shopcell = [[UIActionSheet alloc] initWithTitle:@"店铺管理"
                                      delegate:self
                             cancelButtonTitle:@"取 消"
                        destructiveButtonTitle:@"店铺详情"
                             otherButtonTitles:@"维护预约",nil];
 
    }
    [self.as_shopcell setTag:index];
    
    [self.as_shopcell setTitle:[NSString stringWithFormat:@"店铺操作:%@",[(Shop*)self.ary_shops[index] name]]];
    [self.as_shopcell showInView:self.view];
    
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet==self.as_shopcell) {
        int index=self.as_shopcell.tag;
        if (buttonIndex == actionSheet.destructiveButtonIndex) {
            [self go_info:self.ary_shops[index]];
        } else if (buttonIndex == 1) { //预约
            [self go_appointment:self.ary_shops[index]];
        } else { //维护历史
            
        }
    }
}

// 编辑车辆
-(void) go_info:(Shop*) shop
{
//    CarVC *vc = [[CarVC alloc] initWithData:@[car,self]];
//    
//    // We don't want to be able to pan on nav bar to see the left side when we pushed a controller
//    [self.revealSideViewController unloadViewControllerForSide:PPRevealSideDirectionLeft];
//    [self.navigationController pushViewController:vc animated:YES];
}

// 店铺预约
-(void) go_appointment:(Shop*) shop
{
    Appointment *item = [Appointment newItem];
    item.shop=shop.scode;
    item.shopName=shop.name;
    
    AppointmentVC *vc = [[AppointmentVC alloc] initWithData:@[@(0),self,item]];

    // We don't want to be able to pan on nav bar to see the left side when we pushed a controller
    [self.revealSideViewController unloadViewControllerForSide:PPRevealSideDirectionLeft];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
