//
//  ViewController.m
//  slearning
//
//  Created by YanJH on 14-9-30.
//  Copyright (c) 2014年 cn.yanjh. All rights reserved.
//

#import "HomeVC.h"
#import "ContentVC.h"
#import "AppController.h"
#import "LoginVC.h"

@interface HomeVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tb_lessons;
@property (retain, nonatomic) NSArray *ary_lesson;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ary_lesson=@[@"预习－整数",@"整数与分数"];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated
{
    //if (![User isLogin]) [LoginView showIn:self.view At:self.view.center];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.ary_lesson count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *id_cell=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:id_cell];
    if (!cell) {
        cell=[[ UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id_cell];

    }
    [cell.textLabel setText:self.ary_lesson[indexPath.row]];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ContentVC *vc=[[ContentVC alloc] init];
//    self.navigationController pu
    [self performSegueWithIdentifier:@"sg_home_content"  sender:nil];
}

- (IBAction)do_go_lesson:(UIButton *)sender {
    //UIViewController *vc=[[ContentVC alloc] init];
    //[self.navigationController pushViewController:vc animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    UIViewController *vc=[segue destinationViewController];
    
    if ([[segue identifier] isEqualToString:@"sg_home_content"]) {
        if ([vc respondsToSelector:@selector(setMData:)]) {
            NSDictionary *data= @{@"data":@[
                                          @{DKEY_ID:@(1),DKEY_TITLE:@"第一页",DKEY_TYPE:@"TP",@"content":@"两个黄鹂鸣翠柳"}, //文字加图片
                                          @{DKEY_ID:@(2),DKEY_TITLE:@"第二页",DKEY_TYPE:@"TPA",@"content":@"一行白鹭上青天"}, //文字、图片、音频
                                          @{DKEY_ID:@(3),DKEY_TITLE:@"第三页",DKEY_TYPE:@"TALI",@"content":@"三人行必有我师"}, //链接+提示信息
                                          @{DKEY_ID:@(4),DKEY_TITLE:@"第四页",DKEY_TYPE:@"W",DKEY_CONTENT:@"baidu.com"} //Web内容
                                          ]};
            
            [vc performSelector:@selector(setMData:)withObject:data];
        }
        return;
    }
    
//    if ([[segue identifier] isEqualToString:SEGUE_IDENTIFIER_HISTORY]) {
//        // ...
//        return;
//    }
//    
//    if ([[segue identifier] isEqualToString:SEGUE_IDENTIFIER_FAVORITE]) {
//        // ...
//        return;
//    }
}



@end
