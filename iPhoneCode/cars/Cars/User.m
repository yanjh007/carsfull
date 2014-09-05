//
//  Car.m
//  Cars
//
//  Created by john yan on 14/8/26.
//
//

#import "User.h"

#pragma mark - 用户模型
@interface User ()

@end

@implementation User

+(NSArray*) getToken;
{
    NSDictionary *user=(NSDictionary*)[JY_Default get:PKEY_USER] ;
    return user[@"token"];
}

+(instancetype) currentUser
{
    static User *currentUser;
    
    @synchronized(self) {
        if (!currentUser) {
            NSDictionary *duser=(NSDictionary*)[JY_Default get:PKEY_USER] ;
            currentUser = [[User alloc] init];
            
            currentUser.login  = duser[@"login"] ?:@"";
            currentUser.userid = duser[@"userid"]?:0;
            currentUser.version  = duser[@"version"] ?:0;
            currentUser.token  = duser[@"token"] ?:@"";

            currentUser.name  = duser[@"name"] ?:@"";
            currentUser.address  = duser[@"address"] ?:@"";
            currentUser.contact  = duser[@"contact"] ?:@"";
        }
        
        return currentUser;
    }
}

-(void) save
{
    NSDictionary *duser=@{ @"login"    :self.login,
                           @"userid"   :@(self.userid),
                           @"passwd"   :self.password?self.password:@"",
                           @"name"     :self.name?self.name:@"",
                           @"address"  :self.address?self.address:@"",
                           @"token"    :self.token?self.token:@"",
                           @"version"  :@(self.version)
                        };
    
    [JY_Default save:duser forKey:PKEY_USER];
}

+(void) save:(int)uid token:(NSString*)token;
{
    User *cuser = [User currentUser];
    
    cuser.userid = uid;
    cuser.token  = token;
    
    [cuser save];
}

@end


