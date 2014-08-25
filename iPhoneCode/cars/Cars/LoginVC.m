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

@interface LoginVC ()
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

    self.title = @"系统绑定";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                                             style:UIBarButtonItemStyleBordered
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
    
    if  (self.verify_code) { //验证恢复模式
        int l=self.tv_code.text.length;
        
        self.pass_code   = [self.tv_code.text substringToIndex:l-6];
        self.verify_code = [self.tv_code.text substringFromIndex:l-6];
        
        [JY_Request post:@{@"M":@"recovery",
                           @"I":[JY_Helper fakeIMEI],
                           @"H":[NSString stringWithFormat:@"%@%@",[self.pass_code sha1],[self.verify_code sha1]],
                           @"passwd":[self.pass_code sha1],
                           @"verify":[self.verify_code sha1]
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
        [JY_Request post:@{@"M":@"login",
                           @"I":[JY_Helper fakeIMEI],
                           @"H":[NSString stringWithFormat:@"%@%@",[self.tv_code.text sha1],self.tv_user.text]
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
    
    [JY_Request post:@{@"M":@"getcode",@"login":self.tv_user.text}
             withURL:URL_BASE_URL
          completion:^(int status, NSString *result){
              if (status==JY_STATUS_OK) {
                  NSDictionary *json=[result jsonObject];
                  if (json && [@"OK" isEqualToString:json[@"R"]]) {
                      NSDictionary *content=json[@"C"] ;
                      if ([content[@"status"] intValue]==1) { //可能是新用户
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
            if ([content[@"status"] intValue]==1) { //创建成功
                [self.lb_info setText:[NSString stringWithFormat:@"用户已成功创建并绑定，密码为:%@",self.pass_code]];
            } else { //登录成功
                [self.lb_info setText:[NSString stringWithFormat:@"用户已成功再次绑定"]];
            }
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
        if ([@"OK" isEqualToString:json[@"R"]]) {
            if ([@"1" isEqualToString:json[@"S"]]) { //创建成功
                [self.lb_info setText:[NSString stringWithFormat:@"用户已成功创建并绑定，密码为:%@",self.pass_code]];
            } else { //登录成功
                [self.lb_info setText:[NSString stringWithFormat:@"用户已成功再次绑定"]];
            }
            
        } else {
            [self.lb_info setText:[NSString stringWithFormat:@"绑定失败:%@",json[@"E"]]];
        }
    } else {
        [self.lb_info setText:@"格式错误"];
    }
}

- (void) handleError:(NSString*)result {
    [self.lb_info setText:[NSString stringWithFormat:@"请求失败: %@",result]];
}



@end


//    NSString *post =@"{\"method\":\"login\"}";
////    NSString *post = [@{@"method":@"login",@"login":self.tv_user.text,@"passwd":self.tv_code.text} jsonString];
//    NSString *key  = [[[NSDate stringNow:@"YYYYMMdd"] sha1] substringToIndex:32];
////    NSString *content =[AESCrypt encrypt:post password:key];
//
//    post = [post stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//
//    NSString *content = [post AES256EncryptWithKey: key];
//
//    NSLog(@"key:%@,encode:%@,编码:%@",key,content,[content AES256DecryptWithKey:key]);

