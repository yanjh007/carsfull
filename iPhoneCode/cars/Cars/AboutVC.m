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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"关 于";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStyleBordered
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
//    LMenuVC *menu = [[LMenuVC alloc] init];
//    [self.revealSideViewController preloadViewController:menu forSide:PPRevealSideDirectionLeft];
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
