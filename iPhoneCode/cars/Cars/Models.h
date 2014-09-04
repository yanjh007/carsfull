//
//  Car.h
//  Cars
//
//  Created by john yan on 14/8/26.
//
//

#import <Foundation/Foundation.h>


#pragma mark - 预约模型
typedef NS_ENUM(NSInteger, AppointmentStatus) {
    AppointmentStatusEdit, //编辑中
    AppointmentStatusForSubmit, //编辑准备提交
    AppointmentStatusSubmited, //已提交
    AppointmentStatusWait,  //待确认
    AppointmentStatusConfirm,  //已确认
    AppointmentStatusCanceled, //已取消
    AppointmentStatusCanceledByService, //已被服务方取消
    AppointmentStatusFinished //已完成
};

@interface Appointment : NSObject
@property (assign) AppointmentStatus status;
@property (strong,nonatomic) NSString *acode,*car,*shop,*shopName,*descp;
@property (strong,nonatomic) NSDate   *plan_at,*edit_at;

+(instancetype) newItem;

-(NSString*) statusString;
+(NSArray*) getList:(int)imode; //各种预约列表
+(NSString *) getForSubmit; //用于提交
+(BOOL) isNeedRequest;


-(BOOL) save;
-(BOOL) cancel;
-(void) clear; //清除一个月以前取消(包括服务取消)和完成的预约

//提交预约
+(void) submit:(void (^)(int status)) completion;
@end

#pragma mark - 店铺模型
@interface Shop : NSObject
@property (strong,nonatomic) NSString *scode,*name,*address;

+(NSString*) nameOf:(NSString*)shop;

+(NSArray*) getList;
+(void) syncShops;

@end


#pragma mark - 车辆模型

@interface Car : NSObject
@property (strong,nonatomic) NSString *carnumber,*framenumber;
@property (assign) int carid;

+(NSArray*) getCars;

+(BOOL) add:(NSString*)cnumber framenumber:(NSString*)fnumber;

-(BOOL) update:(NSString*)fnumber;
-(BOOL) remove;

@end


#pragma mark - 车系
@interface Carserie : NSObject
@property (strong,nonatomic) NSString *manufactor,*brand;
@property (assign) int csid;

+(NSArray*) getCarseries;

@end

