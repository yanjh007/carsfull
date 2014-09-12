//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "HomeVC.h"
#import "JY_StdVC.h"
#import "LMenuVC.h"

@interface JY_StdMainVC ()

@end

@implementation JY_StdMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu2"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(showMenu:)];
//    LMenuVC *menu = [[LMenuVC alloc] init];
//    [self.revealSideViewController preloadViewController:menu forSide:PPRevealSideDirectionLeft];
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

    [self.revealSideViewController preloadViewController:[LMenuVC sharedVC] forSide:PPRevealSideDirectionLeft];
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

@end


@interface JY_StdPushVC ()

@end

@implementation JY_StdPushVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(_go_back:)];
}

- (void) _go_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

