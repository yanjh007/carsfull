//
//  Car.h
//  Cars
//
//  Created by john yan on 14/8/26.
//
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
@property (strong,nonatomic) NSString *carnumber,*framenumber;
@property (assign) int carid;

+(NSArray*) getCars;

+(BOOL) add:(NSString*)cnumber framenumber:(NSString*)fnumber;

-(BOOL) update:(NSString*)fnumber;
-(BOOL) remove;

@end
