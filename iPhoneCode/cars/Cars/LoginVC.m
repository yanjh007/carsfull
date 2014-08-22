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
    NSString *post =@"hello zhongwi"; //{'method':'login'}";
    //NSString *post = [@{@"method":@"login",@"login":self.tv_user.text,@"passwd":self.tv_code.text} jsonString];
    NSString *key  = [[[NSDate stringNow:@"YYYYMMdd"] sha1] substringToIndex:32];
//    NSString *content =[AESCrypt encrypt:post password:key];
    
    post = [post stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *content = [post AES256EncryptWithKey: key];
    
    NSLog(@"key:%@,encode:%@,编码:%@",key,content,[content AES256DecryptWithKey:key]);
    
    [JY_Request post:@{@"C": content}
             withURL:URL_BASE_URL
          completion:^(int status, NSString *result){
              if (status==JY_STATUS_OK) {
                  [self handleResult:result];
              } else {
                  [self handleError:result];
              }
          }];
}

- (void) handleResult:(NSString*)result {
    NSLog(@"result:%@",result);
    NSDictionary *json=[result jsonObject];
    if (json) {
        if ([@"OK" isEqualToString:json[@"R"]]) {
            [self.lb_info setText:@"已成功绑定"];
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
