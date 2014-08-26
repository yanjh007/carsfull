//
//  Car.h
//  Cars
//
//  Created by john yan on 14/8/26.
//
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
@property (strong,nonatomic) NSString *carnumber;
+(NSArray*) getCars;

@end
