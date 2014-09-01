//
//  Car.m
//  Cars
//
//  Created by john yan on 14/8/26.
//
//

#import "Models.h"
#import "JY_DBHelper.h"


#pragma mark - 预约模型
@interface Appointment ()

@end

@implementation Appointment

+(instancetype) newItem;
{
    return [[Appointment alloc]init];
}

-(instancetype) initWithCar:(NSString*)car andShop:(NSString*)shop;
{
    self = [super init];
    if (self) {
        self.car = car;
        self.shop= shop;
    }
    return self;
}

- (id)initWithDbRow:(FMResultSet*) rs
{
    self = [super init];
    if (self) {
        self.acode  = [rs stringForColumn:@"acode"];
        self.car    = [rs stringForColumn:@"car"];
        self.shop   = [rs stringForColumn:@"shop"];
    }
    return self;
}

+(NSArray*) getList:(int) imode;
{
    FMDatabase  *db=[JY_DBHelper openDB];
    NSString *sql= @"SELECT acode,car,shop,create_at,plan_at,status FROM appointments ";
    if (imode==1) { //计划中，已确认
        sql = [NSString stringWithFormat:@"%@ where status=%i ",
               sql,AppointmentStatusConfirm];
    } else if (imode==2) { //待确认和在编辑
        sql = [NSString stringWithFormat:@"%@ where status=%i or status=%i ",
               sql,AppointmentStatusEdit,AppointmentStatusSubmited];
    } else if (imode==3) { // 已取消和已完成
        sql = [NSString stringWithFormat:@"%@ where status=%i or status=%i or status=%i ",
               sql,AppointmentStatusCanceled,AppointmentStatusCanceledByService,AppointmentStatusFinished];
    } else if (imode==4) { //
        sql = [NSString stringWithFormat:@"%@ where status=%i ",
               sql,AppointmentStatusEdit];
    }
    
    FMResultSet *s = [db executeQuery:sql];
    NSMutableArray *ary = [NSMutableArray array];
    while ([s next]) {
        Appointment *item=[[Appointment alloc] initWithDbRow:s];
        [ary addObject:item];
    }
    [db close];
    return [ary copy];
}

+(NSString *) getForSubmit
{
    FMDatabase  *db=[JY_DBHelper openDB];
    NSString *sql= [NSString stringWithFormat:@"SELECT acode,car,shop,create_at,plan_at FROM appointments where status=%i",AppointmentStatusEdit];
    
    FMResultSet *s = [db executeQuery:sql];

    NSMutableArray *ary=[NSMutableArray array];
    while ([s next]) {
        NSDictionary *dic=@{
                            @"acode":[s stringForColumnIndex:0],
                            @"car":[s stringForColumnIndex:1],
                            @"plan_at":[s stringForColumnIndex:4]
                            };
        [ary addObject:dic];
    }
    [db close];
    if ([ary count] ==0) {
        return nil;
    } else {
        return [[ary copy] jsonString];
//        return [NSString stringWithFormat:@"[%@]",submit];
    }
    
}

-(BOOL) save:(NSString*)plan_at car:(NSString*)car andShop:(NSString*)shop
{
    FMDatabase  *db=[JY_DBHelper openDB];
    if (self.acode==nil || [self.acode length]==0) {
        NSString *code=[NSString stringWithFormat:@"A%@",[NSDate rstringNow]];
        [db executeUpdate:@"INSERT INTO appointments (acode,status,create_at,plan_at,car,shop) values (?,?,?,?,?,?)",code,@(AppointmentStatusEdit),plan_at,plan_at,car,shop];
    } else {
        [db executeUpdate:@"UPDATE ? set plan_at=?,status=? where acode=?",TB_APPOINTMENTS,plan_at,@(AppointmentStatusEdit),self.acode] ;
    }
    
    [db close];
    return YES;
}


-(BOOL) remove
{
    FMDatabase  *db=[JY_DBHelper openDB];
    [db executeUpdate:@"UPDATE ? set status=? where acode=?",TB_APPOINTMENTS, AppointmentStatusCanceled, self.acode] ;
    [db close];
    return YES;
}

@end


#pragma mark - 店铺模型
@interface Shop ()

@end

@implementation Shop

- (id)initWithNumber:(NSString*) carnumber
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithDbRow:(FMResultSet*) rs
{
    self = [super init];
    if (self) {
        self.scode  = [rs stringForColumn:@"scode"];
        self.name   = [rs stringForColumn:@"name"];
    }
    return self;
}

+(NSArray*) getList;
{
    FMDatabase  *db=[JY_DBHelper openDB];
    FMResultSet *s = [db executeQuery:@"SELECT scode,name,address FROM ? order by scode",TB_SHOPS];
    NSMutableArray *ary=[NSMutableArray array];
    while ([s next]) {
        Shop *item=[[Shop alloc] initWithDbRow:s];
        [ary addObject:item];
    }
    [db close];
    return [ary copy];
}

+(void) save:(NSDictionary*)dic at:(NSString*)dtime
{
    [JY_DBHelper updateMeta:DBMKEY_SHOP_TIME value:dtime];
}


@end


#pragma mark - 车辆模型
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

