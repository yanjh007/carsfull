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
        self.carnumber  = [rs stringForColumn:@"carnumber"];
        self.framenumber= [rs stringForColumn:@"framenumber"];
    }
    return self;
}

+(NSArray*) getCars;
{
    FMDatabase  *db=[JY_DBHelper openDB];
    FMResultSet *s = [db executeQuery:@"SELECT carid,carnumber,framenumber FROM cars"];
    NSMutableArray *ary_cars=[NSMutableArray array];
    while ([s next]) {
        Car *item=[[Car alloc] initWithDbRow:s];
        [ary_cars addObject:item];
    }
    [db close];
    return [ary_cars copy];
}

+(BOOL) add:(NSString*)cnumber framenumber:(NSString*)fnumber
{
    FMDatabase  *db=[JY_DBHelper openDB];
    [db executeUpdate:@"INSERT INTO cars (carnumber,framenumber) VALUES (?,?)",cnumber,fnumber] ;
    [db close];
    return YES;
}

-(BOOL) update:(NSString*)fnumber
{
    FMDatabase  *db=[JY_DBHelper openDB];
    [db executeUpdate:@"UPDATE cars set framenumber=? where carnumber=?",fnumber,self.carnumber] ;
    [db close];
    return YES;
}


-(BOOL) remove
{
    FMDatabase  *db=[JY_DBHelper openDB];
    [db executeUpdate:@"DELETE from cars where carnumber=?",self.carnumber] ;
    [db close];
    return YES;
}

@end
