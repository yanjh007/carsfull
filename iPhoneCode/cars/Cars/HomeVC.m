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
        self.title = @"主 页";
        [Shop sync]; //同步店铺信息
        [Car sync:^(int status){ }]; //同步车辆
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
