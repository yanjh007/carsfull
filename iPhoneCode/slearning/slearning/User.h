//
//  User.h
//  slearning
//
//  Created by YanJH on 14-10-1.
//  Copyright (c) 2014年 cn.yanjh. All rights reserved.
//

#import <Foundation/Foundation.h>

static int const USER_STATUS_IN_LOGIN  = 1;
static int const USER_STATUS_LOGIN     = 2;
static int const USER_STATUS_LOGOUT    = 3;
static int const USER_STATUS_LOGIN_ERROR   = 4;
static int const USER_STATUS_NETWORK   = 5;

@interface User : NSObject
+(instancetype) shared;

+(BOOL) isLogin;
+(void) login:(NSString*) user
 withPassword:(NSString*) passwd
       stauts:(void (^)(int status))status;
@end
