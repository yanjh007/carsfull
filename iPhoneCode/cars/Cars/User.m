//
//  Car.m
//  Cars
//
//  Created by john yan on 14/8/26.
//
//

#import "User.h"
#import "JY_DBHelper.h"

#pragma mark - 用户模型
@interface User ()

@end

@implementation User

static User *instance=nil;

+(NSArray*) getToken;
{
    NSDictionary *user=(NSDictionary*)[JY_Default get:PKEY_USER] ;
    return user[@"token"];
}

+(instancetype) currentUser
{
    
    @synchronized(self) {
        if (!instance) {
            NSDictionary *duser=(NSDictionary*)[JY_Default get:PKEY_USER] ;
            instance = [[User alloc] init];
            
            instance.login  = duser[@"login"] ?:@"";
            instance.userid = duser[@"userid"]?[duser[@"userid"] intValue]:0;
            instance.version  = duser[@"version"] ?[duser[@"version"] intValue]:0;
            instance.token  = duser[@"token"] ?:@"";

            instance.name  = duser[@"name"] ?:@"";
            instance.address  = duser[@"address"] ?:@"";
            instance.contact  = duser[@"contact"] ?:@"";
        }
        
        return instance;
    }
}

-(void) save
{
    NSDictionary *duser=@{ @"login"    :self.login,
                           @"userid"   :@(self.userid),
                           @"passwd"   :self.password?self.password:@"",
                           @"name"     :self.name?self.name:@"",
                           @"contact"  :self.contact?self.contact:@"",
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

-(void) logout
{
    [JY_Default removeOne:PKEY_USER];
    instance=nil;
}

-(NSString*) dataForUpdate
{
    NSDictionary *dic=@{
                        @"name":self.name,
                        @"address":self.contact,
                        @"contact":self.contact
                        };
    return [dic jsonString];
}

-(void) updateCloud:(void (^)(int status)) completion
{
    
    [JY_Request post:@{@"M":@"client",
                       @"I":[JY_Helper fakeIMEI],
                       @"S":[User currentUser].token,
                       @"U":@([User currentUser].userid),
                       @"C":[self dataForUpdate]
                       }
             withURL:URL_BASE_URL
          completion:^(int status, NSString *result){
              if (status==JY_STATUS_OK) {
                  NSDictionary *json= [result jsonObject];
                  if ([JVAL_RESULT_OK isEqualToString:json[JKEY_RESULT]]) {
                      completion(1);
                      return;
                  }
              }
              completion(0);
          }];
}

@end


