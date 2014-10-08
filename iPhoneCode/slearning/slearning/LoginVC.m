//
//  LoginVC.m
//  slearning
//
//  Created by YanJH on 14-10-1.
//  Copyright (c) 2014年 cn.yanjh. All rights reserved.
//

#import "LoginVC.h"
#import "AppController.h"

@interface LoginVC ()
@property (strong, nonatomic) IBOutlet UILabel *lb_status;
@property (strong, nonatomic) IBOutlet UITextField *tv_user;
@property (strong, nonatomic) IBOutlet UITextField *tv_passwd;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)do_login:(UIButton *)sender {
    [User login:self.tv_user.text
   withPassword:self.tv_passwd.text
         stauts:^(int status){
        switch (status) {
            case USER_STATUS_IN_LOGIN:
                [self.lb_status setText:@"正在登录，请稍侯..."];
                
                break;
            case USER_STATUS_LOGIN_ERROR:
                [self.lb_status setText:@"登录失败，请检查网络或登录名和密码！"];
                break;
            case USER_STATUS_LOGIN:
                [self dismissViewControllerAnimated:YES completion:nil];
                break;
            default:
                break;
        }
    }];
    
}

@end


#pragma mark - LoginView
@interface LoginView ()
@property (strong, nonatomic) IBOutlet UILabel *lb_status;
@property (strong, nonatomic) IBOutlet UITextField *tv_user;
@property (strong, nonatomic) IBOutlet UITextField *tv_passwd;
@property (nonatomic,strong) UIView *mParent;

@end



@implementation LoginView

static LoginView *instance;

+(instancetype) shared;
{
    @synchronized(self) {
        if (instance == nil) {
            instance =[[NSBundle mainBundle] loadNibNamed:@"Login" owner:self options:nil][0]; // assignment not done here
        }
    }
    return instance;
}

+(void) showIn:(UIView*)view
            At:(CGPoint) pt
{
    LoginView *lv=[LoginView shared];
    if (![view.subviews containsObject:lv]) {
        [view addSubview:lv];
        [view bringSubviewToFront:lv];
        
    }
    
    [lv setHidden:NO];
    [lv setCenter:pt];
}

- (IBAction)do_login:(id)sender {
    [User login:self.tv_user.text
   withPassword:self.tv_passwd.text
         stauts:^(int status){
             switch (status) {
                 case USER_STATUS_IN_LOGIN:
                     [self.lb_status setText:@"正在登录，请稍侯..."];
                     break;
                 case USER_STATUS_LOGIN_ERROR:
                     [self.lb_status setText:@"登录失败，请检查网络或登录名和密码！"];
                     break;
                 case USER_STATUS_LOGIN:
                     [self setHidden:YES];
                     //[self dismissViewControllerAnimated:YES completion:nil];
                     break;
                 default:
                     break;
             }
         }];
}

@end
