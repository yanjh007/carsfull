//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "HomeVC.h"
#import "AboutVC.h"

@interface AboutVC ()

@end

@implementation AboutVC

- (id)init
{
    self = [JY_Helper loadNib:@"Main" atIndex:2];
    if (self) {
        self.title = @"关 于";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


@end
