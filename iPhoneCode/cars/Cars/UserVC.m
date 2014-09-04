//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "UserVC.h"
#import "LMenuVC.h"
#import "CarVC.h"
#import "AppointmentVC.h"
#import "Models.h"
#import "User.h"

@interface UserVC ()<UIActionSheetDelegate,JY_STD_Delegate,UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *tv_name;
@property (strong, nonatomic) IBOutlet UITextField *tv_contact;
@property (strong, nonatomic) IBOutlet UITextView *tv_address;
@end

@implementation UserVC

- (id)init
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:9];
    if (self) {
        self.title = @"用户设置";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_menu1"]
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self
                                                                                action:@selector(showMenu:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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

#pragma mark -  Standard and System Delegate
- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
{
    
    [textView resignFirstResponder];
    
    return YES;
}


#pragma mark -  Custom Function and Delegate

-(int) action:(int)act withIndex:(int)index
{
    if (act==DELE_LIST_RELOAD) {
        if (index==1) { //call from CarVC

        }
        
    }
    return DELE_RESULT_VOID;
}

- (IBAction)do_save:(UIButton *)sender {
    [User currentUser].name     = self.tv_name.text;
    [User currentUser].contact  = self.tv_contact.text;
    [User currentUser].address  = self.tv_address.text;
    [[User currentUser] save];
    
}

@end
