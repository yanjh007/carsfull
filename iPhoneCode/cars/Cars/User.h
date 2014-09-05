//
//  Car.h
//  Cars
//
//  Created by john yan on 14/8/26.
//
//

#import <Foundation/Foundation.h>


#pragma mark - 用户模型
static const NSString* PKEY_USER=@"user_key";

@interface User : NSObject
@property (copy,nonatomic) NSString *name,*login,*token,*address,*password,*geoaddress,*contact;
@property (assign) int userid,version,usertype,status;

+(NSArray*) getToken;
+(instancetype) currentUser;
-(void) save;
+(void) save:(int)uid token:(NSString*)token;

@end

