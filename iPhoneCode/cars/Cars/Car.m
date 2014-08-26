//
//  Car.m
//  Cars
//
//  Created by john yan on 14/8/26.
//
//

#import "Car.h"

#import "JY_DBHelper.h"

@interface Car ()

@end

@implementation Car

- (id)initWithNumber:(NSString*) carnumber
{
    self = [super init];
    if (self) {
        self.carnumber=carnumber;
    }
    return self;
}

- (id)initWithDbRow:(FMResultSet*) rs
{
    self = [super init];
    if (self) {
        self.carnumber= [rs stringForColumn:@"carnumber"];
    }
    return self;
}

+(NSArray*) getCars;
{
    FMDatabase  *db=[JY_DBHelper openDB];
    FMResultSet *s = [db executeQuery:@"SELECT carnumber FROM cars"];
    NSMutableArray *ary_cars=[NSMutableArray array];
    while ([s next]) {
        Car *item=[[Car alloc] initWithDbRow:s];
        [ary_cars addObject:item];
    }
    return [ary_cars copy];
}


@end
