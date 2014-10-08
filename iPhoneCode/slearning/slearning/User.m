//
//  User.m
//  slearning
//
//  Created by YanJH on 14-10-1.
//  Copyright (c) 2014年 cn.yanjh. All rights reserved.
//

#import "User.h"
#import "AppController.h"

@interface User()
@property (assign) BOOL isLogin;
@property (assign) int uid;
@property (retain,nonatomic) NSString *uname,*upwd,*token;
@end

@implementation User

static User *instance;

+(instancetype) shared;
{
    @synchronized(self) {
        if (instance == nil) {
            instance =[[self alloc] init]; // assignment not done here
            instance.isLogin=NO;
        }
    }
    return instance;
}
+(BOOL) isLogin;
{
    return instance.isLogin;
}


+(void) login:(NSString*) user
 withPassword:(NSString*) passwd
       stauts:(void (^)(int status))status
{
    status(USER_STATUS_IN_LOGIN);
    
    if ([user isEqualToString:@"yanjh"] && [passwd isEqualToString:@"hello"]) {
        instance.uid   = 1;
        instance.uname = @"yanjh";
        instance.token = @"token";
        
        [JY_Default save:instance forKey:DKEY_USER];
        status(USER_STATUS_LOGIN);
        
    } else {
        status(USER_STATUS_LOGIN_ERROR);
    }
    
}

@end
