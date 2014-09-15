//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "LoginVC.h"
#import "LMenuVC.h"
#import "JY_Request.h"
//#import "AESCrypt.h"
#import "NSString+AESCrypt.h"
#import "User.h"

@interface LoginVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tv_user;
@property (weak, nonatomic) IBOutlet UITextField *tv_code;
@property (weak, nonatomic) IBOutlet UILabel *lb_info;
@property (strong, nonatomic) NSString *verify_code,*pass_code; //验证码和临时密码

@end

@implementation LoginVC

- (id)init
{
    self = [JY_Helper loadNib:NIB_MAIN atIndex:4];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"用户绑定";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_exit"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(do_close:)];
}

- (void) do_close:(id)sender
{
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

- (IBAction)do_login:(UIButton *)sender {
    if ([self.tv_user.text length]==0 || [self.tv_code.text length]==0) {
        [self.lb_info setText:@"用户名或密码/验证码不能为空"];
        return;
    }
    
    [User currentUser].login=[self.tv_user.text copy];

    if  (self.verify_code) { //验证恢复模式
        int l=self.tv_code.text.length;
        
        self.pass_code   = [self.tv_code.text substringToIndex:l-6];
        [User currentUser].password=self.pass_code;
        
        self.verify_code = [self.tv_code.text substringFromIndex:l-6];
        
        [JY_Request post:@{MKEY_METHOD      :@"recover",
                           MKEY_DEVICE_ID   :[JY_Helper fakeIMEI],
                           MKEY_HASH        :[NSString stringWithFormat:@"%@%@%@",[self.pass_code sha1],self.verify_code,self.tv_user.text]
                           }
                 withURL:URL_BASE_URL
              completion:^(int status, NSString *result){
                  if (status==JY_STATUS_OK) {
                      [self handleRecover:result];
                  } else {
                      [self handleError:result];
                  }
              }];
        
    } else { //新建和登录模式
        self.pass_code=self.tv_code.text;
        [User currentUser].password=self.pass_code;
        
        [JY_Request post:@{
                           MKEY_METHOD      :@"login",
                           MKEY_DEVICE_ID   :[JY_Helper fakeIMEI],
                           MKEY_HASH        :[NSString stringWithFormat:@"%@%@",[self.tv_code.text sha1],self.tv_user.text]
                           }
                 withURL:URL_BASE_URL
              completion:^(int status, NSString *result){
                  if (status==JY_STATUS_OK) {
                      [self handleLogin:result];
                  } else {
                      [self handleError:result];
                  }
              }];
    }
    
}

- (IBAction)do_getcode:(id)sender {
    if ([self.tv_user.text length]==0 ) {
        [self.lb_info setText:@"用户名不能为空"];
        return;
    }

    [JY_Request post:@{MKEY_METHOD:@"getcode",
                       @"login":self.tv_user.text}
             withURL:URL_BASE_URL
          completion:^(int status, NSString *result){
              if (status==JY_STATUS_OK) {
                  NSDictionary *json=[result jsonObject];
                  if (json && [@"OK" isEqualToString:json[@"R"]]) {
                      NSDictionary *content=json[@"C"] ;
                      if ([content[@"status"] intValue]==11) { //可能是新用户
                          self.pass_code = [NSString randomString:6];
                          
                          [self.lb_info setText:[NSString stringWithFormat:@"您可能是新用户，系统已经为您生成密码: %@,可以用于下次绑定，请予以记录，当然您也可以自行设定密码",self.pass_code]];
                          [self.tv_code setText:self.pass_code];
                          self.verify_code =nil;
                          
                      } else {
                          NSString *vcode = [content[@"vcode"] stringValue];
                          self.verify_code = vcode;
                          self.pass_code=[NSString randomString:6];
                          [self.tv_code setText:self.pass_code];
                          [self.lb_info setText:[NSString stringWithFormat:@"系统已为您生成验证码 %@ 并通过短信发送给你，同时为您生成了新密码 %@ ,请在新密码后追加验证码并提交来绑定账户",vcode,self.pass_code]];
                          
                      }
                  }
                  return;
              }
              [self.lb_info setText:@"网络或数据错误"];
          }];
}

- (void) handleLogin:(NSString*)result {
    NSLog(@"result:%@",result);
    NSDictionary *json=[result jsonObject];
    if (json) {
        NSDictionary *content=json[@"C"] ;
        if ([@"OK" isEqualToString:json[@"R"]]) {
            User *user=[User currentUser];
            if ([content[@"status"] intValue]==1) { //创建成功
                [self.lb_info setText:[NSString stringWithFormat:@"用户已成功创建并绑定，密码为:%@",self.pass_code]];
                
                
            } else { //登录成功 status 2
                [self.lb_info setText:[NSString stringWithFormat:@"用户已成功再次绑定"]];
                NSDictionary *info=content[@"info"];
                if (info) {
                    if (info[@"name"])      user.name    = info[@"name"];
                    if (info[@"contact"])   user.contact = info[@"contact"];
                    if (info[@"address"])   user.address = info[@"address"];
                }
                
            }
            
            user.userid = [content[@"cid"] intValue];
            user.token  = content[@"token"];
            [user save];
            
            
            [[LMenuVC sharedVC] showVC:@"InfoVC"];
            [self do_close:nil];
            
        } else {
            [self.lb_info setText:[NSString stringWithFormat:@"绑定失败:%@",content[@"error"]]];
        }
    } else {
        [self.lb_info setText:@"数据通讯格式错误"];
    }
}

- (void) handleRecover:(NSString*)result {
    NSLog(@"result:%@",result);
    NSDictionary *json=[result jsonObject];
    if (json) {
        NSDictionary *content=json[@"C"] ;
        if ([@"OK" isEqualToString:json[@"R"]]) {
            if ([content[@"status"] intValue]==3) { //创建成功
                [self.lb_info setText:[NSString stringWithFormat:@"用户验证并成功绑定，且密码修改为:%@",self.pass_code]];
                
                [User save:[content[@"cid"] intValue] token:content[@"token"]];
            } else {
                [self.lb_info setText:@"绑定验证失败，未知错误"];
            }
        } else {
            [self.lb_info setText:[NSString stringWithFormat:@"绑定验证失败:%@",content[@"error"]]];
        }
    } else {
        [self.lb_info setText:@"格式错误"];
    }
}

- (void) handleError:(NSString*)result {
    [self.lb_info setText:[NSString stringWithFormat:@"请求失败: %@",result]];
}

@end


