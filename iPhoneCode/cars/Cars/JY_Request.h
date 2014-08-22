//
//  ZM_Request.h
//  StockDiagnose
//
//  Created by yanjh on 14-4-14.
//  Copyright (c) 2014年 港澳资讯集团－成都抓米信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

static int const JY_STATUS_OK     = 200;
static int const JY_STATUS_ERROR  = 0;


@protocol JY_Request_Delegate<NSObject>
- (int) onCallback:(int)status withData:(NSString*)result;
@optional
@end

@interface JY_Request:NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

+ (void) post:(NSDictionary*)params
      withURL:(NSString*)urlstr
   completion:(void (^)(int status, NSString *result)) completion;

+ (void) spost:(NSDictionary*)params
       withURL:(NSString*)urlstr
    completion:(void (^)(int status, NSString *result)) completion;

+ (JY_Request *) post:(NSDictionary*)params
              withUrl:(NSString*)curl
          andDelegate:(id<JY_Request_Delegate>)delegate;

+(NSObject*) jsonValue:(NSString*) string;

@end

