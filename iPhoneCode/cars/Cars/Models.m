//
//  Car.m
//  Cars
//
//  Created by john yan on 14/8/26.
//
//

#import "User.h"
#import "Models.h"


#pragma mark - 预约模型
@interface Appointment ()

@end

@implementation Appointment

+(instancetype) newItem;
{
    return [[Appointment alloc]init];
}

- (id)initWithDbRow:(FMResultSet*) rs
{
    self = [super init];
    if (self) {
        self.acode  = [rs stringForColumn:@"acode"];
        self.car    = [rs stringForColumn:@"car"];
        self.shop   = [rs stringForColumn:@"shop"];
        self.shopName = [Shop nameOf:self.shop];
        
        self.edit_at  = [[rs stringForColumn:@"edit_at"] dateValue:STRING_DATE_YMDHMS];
        self.plan_at  = [[rs stringForColumn:@"plan_at"] dateValue:STRING_DATE_YMDHMS];
        
        self.status  = [rs intForColumn:@"status"];
    }
    return self;
}

-(NSString*) statusString
{
    switch (self.status) {
        case AppointmentStatusEdit      : return @"<编辑>";
        case AppointmentStatusForSubmit : return @"<待申请>";
        case AppointmentStatusSubmited  : return @"<已申请>";
        case AppointmentStatusConfirm   : return @"<已确认>";
        case AppointmentStatusCanceled  : return @"<已取消>";
        case AppointmentStatusCanceledByService : return @"<已拒绝>";
        case AppointmentStatusFinished  : return @"<已完成>";
            
        default: return @"<其他>";
    }

}

+(NSArray*) getList:(int) imode;
{
    FMDatabase  *db=[JY_DBHelper openDB];
    NSString *sql= [@"SELECT acode,car,shop,edit_at,plan_at,status FROM %@ " withTable:TB_APPOINTMENTS];
    if (imode==1) { //计划中，已确认
        sql = [NSString stringWithFormat:@"%@ where status=%i ",
               sql,AppointmentStatusConfirm];
    } else if (imode==2) { //待确认和在编辑
        sql = [NSString stringWithFormat:@"%@ where status in (%i,%i,%i)",
               sql,AppointmentStatusEdit,AppointmentStatusForSubmit,AppointmentStatusSubmited];
    } else if (imode==3) { // 已取消和已完成
        sql = [NSString stringWithFormat:@"%@ where status in (%i,%i,%i)",
               sql,AppointmentStatusCanceled,AppointmentStatusCanceledByService,AppointmentStatusFinished];
    } else if (imode==4) { //
        sql = [NSString stringWithFormat:@"%@ where status=%i ",
               sql,AppointmentStatusEdit];
    }
    
    FMResultSet *s = [db executeQuery:sql];
    NSMutableArray *ary = [NSMutableArray array];
    if (s) {
        while ([s next]) {
            Appointment *item=[[Appointment alloc] initWithDbRow:s];
            [ary addObject:item];
        }
        [s close];
    }
    [db close];
    
    return [ary copy];
}

+(NSString *) getForSubmit
{
    FMDatabase  *db=[JY_DBHelper openDB];
   
    NSString *sql=[@"SELECT acode,car,shop,edit_at,plan_at FROM %@ where status=?" withTable:TB_APPOINTMENTS];
    FMResultSet *s = [db executeQuery:sql,@(AppointmentStatusForSubmit)];

    NSMutableArray *ary=[NSMutableArray array];
    if (s) {
        while ([s next]) {
            NSDictionary *dic=@{
                                @"acode"    :[s stringForColumnIndex:0],
                                @"car"      :[s stringForColumnIndex:1]?:@"",
                                @"shop"     :[s stringForColumnIndex:2]?:@"",
                                @"plan_at"  :[s stringForColumnIndex:4]?:@""
                                };
            [ary addObject:dic];
        }
        [s close];
    }
    [db close];
    if ([ary count] ==0) {
        return @"";
    } else {
        return [[ary copy] jsonString];
    }
    
}

+(BOOL) isNeedRequest //是否需要请求
{
    BOOL bRequest=NO;
    FMDatabase  *db=[JY_DBHelper openDB];
    NSString *sql=[@"SELECT 1 FROM %@ where status=? or status =?" withTable:TB_APPOINTMENTS];
    FMResultSet *s = [db executeQuery:sql,@(AppointmentStatusForSubmit),@(AppointmentStatusSubmited)];
    
    if (s) {
        if ([s next]) bRequest=YES;
        [s close];
    }
    [db close];
        
    return bRequest;
}

-(BOOL) save
{
    FMDatabase  *db=[JY_DBHelper openDB];
    if (self.acode==nil || [self.acode length]==0) {
        self.acode = [NSString stringWithFormat:@"A%@",[NSDate rstringNow]];
        
        [db executeUpdate:@"INSERT INTO appointments (edit_at,plan_at,car,shop,status,acode) values (?,?,?,?,?,?)",
         [NSDate stringNow:STRING_DATE_YMDHMS],[self.plan_at stdString],self.car,self.shop,@(self.status),self.acode];
    } else {
        [db executeUpdate:@"UPDATE appointments set plan_at=?, car=?, shop=?, status=? where acode=?",
         [self.plan_at stdString],self.car,self.shop,@(self.status),self.acode] ;
    }
    
    [db close];
    return YES;
}

-(BOOL) cancel
{
    FMDatabase  *db=[JY_DBHelper openDB];
    [db executeUpdate:@"UPDATE appointments set status=?, edit_at=? where acode=?",@(AppointmentStatusCanceled), [NSDate stringNow:nil],self.acode] ;
    [db close];
    return YES;
}

- (void) clear
{
    FMDatabase  *db=[JY_DBHelper openDB];
    
    [db executeUpdate: [NSString stringWithFormat:@"Delete from appointments where edit_at < date('now','-7 day') and status in (%i,%i,%i))",
                        AppointmentStatusCanceled,AppointmentStatusCanceledByService,AppointmentStatusFinished]] ;
    [db close];
}

+(void) submit:(void (^)(int status)) completion
{
    if (![Appointment isNeedRequest]) {
        completion(0);
        return;
    }
    
    [JY_Request post:@{@"M":@"apmts",
                       @"I":[JY_Helper fakeIMEI],
                       @"S":[User currentUser].token,
                       @"U":@([User currentUser].userid),
                       @"C":[Appointment getForSubmit]
                       }
             withURL:URL_BASE_URL
          completion:^(int status, NSString *result){
              if (status==JY_STATUS_OK) {
                  NSDictionary *json= [result jsonObject];
                  if ([JVAL_RESULT_OK isEqualToString:json[JKEY_RESULT]]) {
                      NSDictionary *content=json[JKEY_CONTENT];
                      FMDatabase  *db=[JY_DBHelper openDB];
                      NSString *sql=@"Update %@ set status=%i, descp='%@', edit_at=date('now') where acode ='%@'";
                      NSArray *ary;
                      NSString *list=content[@"received"]; //接受的预约
                      if (list && list.length) {
                          list=[NSString stringWithFormat:@"'%@'",[list stringByReplacingOccurrencesOfString:@"," withString:@"','"]];
                          [db executeUpdate: [NSString stringWithFormat:sql,TB_APPOINTMENTS,AppointmentStatusSubmited,list]];
                      }
                      
                      list=content[@"approved"]; // 确认的预约
                      if (list && list.length) {
                          ary = [list componentsSeparatedByString:@"#"];
                          for (int i=0,count=ary.count; i<count; i++) {
                              [db executeUpdate: [NSString stringWithFormat:sql,TB_APPOINTMENTS,AppointmentStatusConfirm,ary[i+1],ary[i]]];
                              i++;
                          }
                      }
                      
                      list=content[@"refused"]; // 拒绝的预约
                      if (list && list.length) {
                          ary = [list componentsSeparatedByString:@"#"];
                          for (int i=0,count=ary.count; i<count; i++) {
                              [db executeUpdate: [NSString stringWithFormat:sql,TB_APPOINTMENTS,AppointmentStatusCanceledByService,ary[i+1],ary[i]]];
                              i++;
                          }
                      }
                      
                      [db close];
                  }
                  completion(1);
              }
              
              completion(0);
          }];
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
    FMResultSet *s = [db executeQuery:@"SELECT scode,name,address FROM shops order by scode"];
    NSMutableArray *ary=[NSMutableArray array];
    if (s) {
        while ([s next]) {
            Shop *item=[[Shop alloc] initWithDbRow:s];
            [ary addObject:item];
        }
        [s close];
    }
    [db close];
    return [ary copy];
}

+(void) saveDic:(NSArray*)shops {
    if (!shops || [shops count]==0) return;

    FMDatabase  *db=[JY_DBHelper openDB];
    [db executeUpdate:@"DELETE from shops"] ;

    for (int i=0,count=shops.count;i<count;i++) {
        NSDictionary *item=shops[i];
        [db executeUpdate:@"INSERT INTO shops (scode,name,address) values (?,?,?)",item[@"scode"],item[@"name"],item[@"address"]];
    }
    
    [db close];
    
}

+(void) sync
{
    NSString *version  =[JY_DBHelper metaValue:DBMKEY_SHOP_VERSION]?:@"0";
    
    [JY_Request post:@{
                       MKEY_METHOD  :@"shops",
                       MKEY_VERSION :version
                       }
             withURL:URL_BASE_URL
          completion:^(int status, NSString *result){
              if (status==JY_STATUS_OK) {
                  NSDictionary *json=[result jsonObject];
                  if (json) {
                      if ([JVAL_RESULT_OK isEqualToString:json[JKEY_RESULT]]) {
                          NSDictionary *content=json[JKEY_CONTENT] ;
                          
                          [Shop saveDic:(NSArray*)content[@"shops"]];
                          [JY_DBHelper setMeta:DBMKEY_SHOP_VERSION value:content[@"version"]];
                          return;
                      } else if ([JVAL_RESULT_NULL isEqualToString:json[JKEY_RESULT]]) {
                          return;
                      }
                  }
              }
              NSLog(@"数据错误");
          }];
}

+(NSString*) nameOf:(NSString*)shop
{
    FMDatabase  *db=[JY_DBHelper openDB];
    
    NSString *sql=[@"SELECT name FROM %@ where scode=?" withTable:TB_SHOPS];
    FMResultSet *s = [db executeQuery:sql,shop];

    NSString *name=nil;
    if (s) {
        if ([s next]) name= [s stringForColumnIndex:0];
        [s close];
    }
    [db close];
    return name;
}

@end


#pragma mark - 车辆模型
@interface Car ()

@end

@implementation Car

- (id)initWithDbRow:(FMResultSet*) rs
{
    self = [super init];
    if (self) {
        self.carid= [rs intForColumn:@"carid"]?:0;
        self.carnumber  = [rs stringForColumn:@"carnumber"];
        self.framenumber= [rs stringForColumn:@"framenumber"];
        self.manufacturer  = [rs stringForColumn:@"manufacturer"];
        self.brand= [rs stringForColumn:@"brand"];
    }
    return self;
}

-(NSString*) manufacturer
{
    if (!_manufacturer) {
        _manufacturer=@"";
    }
    return _manufacturer;
}

-(NSString*) brand
{
    if (!_brand) _brand=@"";
    return _brand;
}

-(NSString*) framenumber
{
    if (!_framenumber) {
        _framenumber=@"";
    }
    return _framenumber;
}
-(NSString*) carnumber
{
    if (!_carnumber) {
        _carnumber=@"";
    }
    return _carnumber;
}

+(NSArray*) getCars;
{
    FMDatabase  *db=[JY_DBHelper openDB];
    FMResultSet *s = [db executeQuery:@"SELECT carid,carnumber,framenumber,manufacturer,brand FROM cars"];
    NSMutableArray *ary_cars=[NSMutableArray array];
    while ([s next]) {
        Car *item=[[Car alloc] initWithDbRow:s];
        [ary_cars addObject:item];
    }
    [db close];
    return [ary_cars copy];
}


// resetlist
+(void) resetCars:(NSArray*)cars;
{
    FMDatabase  *db=[JY_DBHelper openDB];
    [db executeUpdate:@"Delete from cars"];
    
    NSString *sql=@"INSERT INTO cars (framenumber,manufacturer,brand,carid,carnumber) values (?,?,?,?,?)";
    
    for (int i=0; i<[cars count]; i++) {
        NSDictionary *dic=cars[i];
        [db executeUpdate:sql,
            dic[@"framenumber"],dic[@"manufacturer"],dic[@"brand"],dic[@"cid"],dic[@"carnumber"]];
    }
    
    [db close];
}


-(BOOL) save
{
    NSString *sql = (self.carid==-1)
                ? @"INSERT INTO cars (framenumber,manufacturer,brand,carid,carnumber) values (?,?,?,?,?)"
                : @"UPDATE cars set framenumber=?, manufacturer=?, brand=?, carid=? where carnumber=?";
    
    [JY_DBHelper execSQLWithData:sql,self.framenumber,self.manufacturer,self.brand,@(self.carid),self.carnumber];
    [Car version_update];
    return YES;
}

+(void) version_update
{
    NSString *v=[JY_DBHelper metaValue:DBMKEY_CARS_VERSION];
    NSString *v2;
    if (!v) {
        v2=@"1";
    } else {
        int iv=[v intValue]+1;
        v2=[NSString stringWithFormat:@"%i",iv];
    }
    
    [JY_DBHelper setMeta:DBMKEY_CARS_VERSION value:v2];
}


-(BOOL) remove
{
//   @"DELETE from cars where carnumber ISNULL"] ;
    [JY_DBHelper execSQLWithData:@"DELETE from cars where carnumber=?",self.carnumber];
    [Car version_update];
    return YES;
}

+(void) updateCloud:(void (^)(int status)) completion
{
    FMDatabase  *db=[JY_DBHelper openDB];
    FMResultSet *s = [db executeQuery:@"SELECT carnumber,framenumber,manufacturer,brand FROM cars"];
    NSMutableArray *ary_cars=[NSMutableArray array];
    while ([s next]) {
        [ary_cars addObject:@{
                              @"carnumber"      :[s stringForColumn:@"carnumber"],
                              @"framenumber"    :[s stringForColumn:@"framenumber"]?:@"",
                              @"manufacturer"   :[s stringForColumn:@"manufacturer"]?:@"",
                              @"brand"          :[s stringForColumn:@"brand"]?:@""
                              } ];
    }
    [db close];
    
    NSString *content;
    if ([ary_cars count]==0){
        content = @"";
    } else {
        content = [ary_cars jsonString];
    }

    NSString *version  =[JY_DBHelper metaValue:DBMKEY_CARS_VERSION]?:@"1";
    
    [JY_Request post:@{MKEY_METHOD      :@"cars_update",
                       MKEY_DEVICE_ID   :[JY_Helper fakeIMEI],
                       MKEY_TOKEN       :[User currentUser].token,
                       MKEY_USER        :@([User currentUser].userid),
                       MKEY_CONTENT     :content,
                       MKEY_VERSION     :version
                       }
             withURL:URL_BASE_URL
          completion:^(int status, NSString *result){
              if (status==JY_STATUS_OK) {
                  NSDictionary *json= [result jsonObject];
                  if ([JVAL_RESULT_OK isEqualToString:json[JKEY_RESULT]]) {
                      NSDictionary *content=json[JKEY_CONTENT];
                      if (content) {
                          NSString *version=[content[@"version"] stringValue];
                          [JY_DBHelper setMeta:DBMKEY_CARS_VERSION value:version];
                      }
                      completion(1);
                      return;
                  }
              }
              completion(0);
          }];
}

+(void) sync:(void (^)(int status)) completion
{
    if ([User currentUser].userid==0) {
        NSLog(@"用户未登录");
        completion(1);
        return;
    }

    NSString *version  =[JY_DBHelper metaValue:DBMKEY_CARS_VERSION]?:@"0";
    
    [JY_Request post:@{
                       MKEY_METHOD      :@"cars",
                       MKEY_DEVICE_ID   :[JY_Helper fakeIMEI],
                       MKEY_TOKEN       :[User currentUser].token,
                       MKEY_USER        :@([User currentUser].userid),
                       MKEY_VERSION     :version
                       }
             withURL:URL_BASE_URL
          completion:^(int status, NSString *result){
              if (status==JY_STATUS_OK) {
                  NSDictionary *json=[result jsonObject];
                  if (json) {
                      if ([JVAL_RESULT_OK isEqualToString:json[JKEY_RESULT]]) {
                          NSDictionary *content=json[JKEY_CONTENT] ;
                          [Car resetCars:content[@"cars"]];
                          
                          // 版本
                          NSString *version=content[@"version"];
                          if (version) [JY_DBHelper setMeta:DBMKEY_CARS_VERSION value:version];
                          completion(10);
                          return;
                      } else if ([JVAL_RESULT_NULL isEqualToString:json[JKEY_RESULT]]) {
                           NSLog(@"无更新车辆信息");
                          completion(11);
                          return;
                      }
                  }
              }
              completion(0);
              NSLog(@"数据错误");
          }];
}

// 车志

-(NSArray*) getLogs;
{
    FMDatabase  *db= [JY_DBHelper openDB];
    FMResultSet *s = [db executeQuery:@"SELECT ltime,location,miles,descp FROM carlogs where ltype=0 and carnumber=? order by ltime desc",self.carnumber];
    NSMutableArray *ary_logs=[NSMutableArray array];
    while ([s next]) {
        Carlog *item=[[Carlog alloc] initWithDbRow:s];
        [ary_logs addObject:item];
    }
    [db close];
    return [ary_logs copy];
}

-(BOOL) addLog:(Carlog*)log
{
    FMDatabase  *db=[JY_DBHelper openDB];
    [db executeUpdate:@"INSERT INTO carlogs (ltype,carnumber,ltime,miles,location,descp) VALUES (0,?,?,?,?,?)",
     self.carnumber,@(log.ltime),@(log.lmiles),log.location?:@"",log.descp?:@""] ;
    [db close];
    return YES;
}

@end

#pragma mark - 车系模型
@interface Carserie ()

@end

@implementation Carserie

@end

#pragma mark - 行车日志
@interface Carlog ()

@end

@implementation Carlog

+(instancetype) newItem
{
    Carlog *log=[[Carlog alloc] init];
    
    return log;
}

- (void) setTime
{
    int itime=[NSDate timeIntervalSinceReferenceDate]/60;
    self.ltime=itime;
    self.ltimestr=[NSDate stringNow:STRING_DATE_YMDHM];
}

- (id)initWithDbRow:(FMResultSet*) rs
{
    self = [super init];
    if (self) {
        self.ltime    = [rs intForColumn:@"ltime"];
        NSDate *t= [NSDate dateWithTimeIntervalSinceReferenceDate:self.ltime*60];
        self.ltimestr = [t stringValue:STRING_DATE_YMDHM];
        self.lmiles   = [rs intForColumn:@"miles"];
        self.descp    = [rs stringForColumn:@"descp"];
        self.location = [rs stringForColumn:@"location"];
    }
    
    return self;
}


@end




