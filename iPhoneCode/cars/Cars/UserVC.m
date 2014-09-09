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

@property (weak,nonatomic) id<JY_STD_Delegate> mDelegate;
@end

@implementation UserVC

- (id)initWithData:(NSDictionary*)dicData
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:9];
    if (self) {
        self.title = @"用户设置";

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_save"]
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(do_close:)];
        
        if (dicData && dicData[@"delegate"]) self.mDelegate=dicData[@"delegate"];
        [self loadData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark -  Standard and System Delegate
- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
{
    [textView resignFirstResponder];
    return YES;
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
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
    
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(action:withIndex:)])
        [self.mDelegate action:DELE_ACTION_USER_SAVE_BACK withIndex:1];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) loadData
{
    self.tv_name.text = [User currentUser].name    ;
    self.tv_contact.text = [User currentUser].contact ;
    self.tv_address.text = [User currentUser].address ;
}


@end
