//
//  JY_Request.m
//  StockDiagnose
//
//  Created by yanjh on 14-4-14.
//  Copyright (c) 2014年 港澳资讯集团－成都抓米信息有限公司. All rights reserved.
//

#import "JY_Request.h"

@interface JY_Request()
@property (retain, nonatomic) id<JY_Request_Delegate> mDelegate;
@property (retain, nonatomic) NSURLConnection  *mConnection;
@property (retain, nonatomic) NSMutableData *receiveData;
@end

@implementation JY_Request
@synthesize receiveData,mConnection,mDelegate;

#pragma mark - 使用 GDP
+ (void) post:(NSDictionary*)params
                  withURL:(NSString*)urlstr
               completion:(void (^)(int status, NSString *result)) completion
{
    NSURL* murl = [NSURL URLWithString:urlstr];
    
	NSMutableURLRequest * req=[NSMutableURLRequest requestWithURL:murl];
    
    if (params && params.count) {
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:[JY_Request httpEncode:params]];
    } else {
        [req setHTTPMethod:@"GET"];
    }
    [req setTimeoutInterval:10];
    
//    NSURLConnection *conn=[NSURLConnection connectionWithRequest:req delegate:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Peform the request
        NSURLResponse *response;
        NSError *err = nil;

        NSData *receivedData = [NSURLConnection sendSynchronousRequest:req
                                                     returningResponse:&response
                                                                 error:&err];
        if (err) { // Deal with your error
            NSLog(@"Error %@", err);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(JY_STATUS_ERROR ,[err description]);
            });
            return;
        }
        
        NSString *responeString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(JY_STATUS_OK,responeString);
        });
    });
}

#pragma mark - 同步Post结果处理
+ (void) spost:(NSDictionary*)params
      withURL:(NSString*)urlstr
   completion:(void (^)(int status, NSString *result)) completion
{
    NSURL* murl = [NSURL URLWithString:urlstr];
    
	NSMutableURLRequest * req=[NSMutableURLRequest requestWithURL:murl];
    
    if (params && [params count]>0) {
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:[JY_Request httpEncode:params]];
    } else {
        [req setHTTPMethod:@"GET"];
    }
    [req setTimeoutInterval:10];
    
    //    NSURLConnection *conn=[NSURLConnection connectionWithRequest:req delegate:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Peform the request
        NSURLResponse *response;
        NSError *err = nil;
        
        NSData *receivedData = [NSURLConnection sendSynchronousRequest:req
                                                     returningResponse:&response
                                                                 error:&err];
        if (err) { // Deal with your error
            NSLog(@"Error %@", err);
            completion(JY_STATUS_ERROR ,[err description]);
        } else {
            NSString *responeString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
            completion(JY_STATUS_OK,responeString);
        }
    });
}

/* 返回处理
 [JY_Request post:nil
 withURL:[NSString stringWithFormat:URL_JY_CFG,cfg]
 completion:^(int status, NSString *result){
 if (status==JY_STATUS_OK) {
 [self handleResult:result];
 }
 }];
*/

#pragma mark - 使用 NSURLConnection

+ (JY_Request *) post:(NSDictionary*)params
                   withUrl:(NSString*)curl
               andDelegate:(id<JY_Request_Delegate>)delegate
{
    JY_Request *r=[[JY_Request alloc] init];
    [r post:params  withUrl:curl andDelegate:delegate];
    return r;
}

- (void) post:(NSDictionary*)params withUrl:(NSString*)curl andDelegate:(id<JY_Request_Delegate>)dele
{
    self.mDelegate = dele;
    if (!(curl && [curl length]>0)) {
        [self.mDelegate onCallback:0 withData:@"Request Address Error"];
        return;
    }
    
	NSMutableURLRequest * req=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:curl]];
    
    if (params && [params count]>0) {
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:[JY_Request httpEncode:params]];
    } else {
        [req setHTTPMethod:@"GET"];
    }
    [req setTimeoutInterval:10];
    
    self.mConnection = [NSURLConnection connectionWithRequest:req delegate:self];
    [self.mConnection start];
}

- (void) cancelAndClear
{
    if (self.mConnection) {
        [self.mConnection cancel];
        [JY_Request cancelAndClear:self];
    }
}

+ (void) cancelAndClear:(JY_Request*) req
{
    if (req) {
        [req cancelAndClear];
        req=nil;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"%@",[res allHeaderFields]);
    self.receiveData = [NSMutableData data];
    
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receiveData appendData:data];
}

//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receiveStr = [[NSString alloc]initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",receiveStr);
    if (self.mDelegate) {
        [self.mDelegate onCallback:JY_STATUS_OK withData:receiveStr];
    }    
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)err
{
    NSLog(@"%@",[err localizedDescription]);
    if (self.mDelegate) {
        [self.mDelegate onCallback:JY_STATUS_ERROR withData:[err localizedDescription]];
    }
}


+ (NSData*) httpEncode:(NSDictionary*) params
{
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in params.allKeys) {
        id v=params[key];
        NSString *value;
        if (!v) continue;

        if ([v isKindOfClass:[NSString class]]) {
            value=v;
        } else {
            value=[v stringValue];
        }
        if (value && [value length]>0) {
            NSString *encodedValue = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
            [parts addObject:part];
        }
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}

+(NSObject*) jsonValue:(NSString*) string
{
    NSError *e;
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSObject *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&e];
    
    //    if (e) NSLog(@"JSON Error:%@",[e userInfo] );
    return [NSJSONSerialization isValidJSONObject:dict]?dict:nil;
}


@end
    
    


