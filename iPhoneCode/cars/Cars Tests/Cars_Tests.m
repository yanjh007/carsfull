//
//  Cars_Tests.m
//  Cars Tests
//
//  Created by YanJH on 14-8-23.
//
//

#import <XCTest/XCTest.h>
#import "JY_FundationAdditions.h"
#import "JY_Request.h"
#import "Models.h"

@interface Cars_Tests : XCTestCase

@end

@implementation Cars_Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)ttestNetwork
{
    NSLog(@"begin request...");
    
    // Set the flag to YES
    __block BOOL waitingForBlock = YES;
    
    [JY_Request post:@{@"M":@"login",@"login":@"yanjh",@"passwd":[@"hello1" sha1]}
             withURL:URL_BASE_URL
          completion:^(int status, NSString *result){
              XCTAssertFalse(status!=JY_STATUS_OK, @"result status error");
              if (status==JY_STATUS_OK) {
                  NSDictionary *json=[result jsonObject];
                  if (json) {
                      if ([@"OK" isEqualToString:json[@"R"]]) {
                          XCTAssertTrue(json[@"C"], @"result is ok and have content");
                      } else {
                          XCTAssertFalse(json[@"E"], @"result is false and error:%@",json[@"E"]);
                      }
                  } else {
                      XCTAssertFalse(!json, "json ");
                  }
              }
              
              NSLog(@"request finished");
              waitingForBlock = NO;
          }];
    
    
    // Run the loop
    while(waitingForBlock) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    
}

- (void)testModel
{
    Appointment *item=[Appointment newItem];
    [item save:[NSDate stringNow:STRING_DATE_YMDHMS] car:@"Car-1" andShop:@"Shop-1"];
    //[Car add:@"Name1" framenumber:@"123-4"];
    
}



@end
