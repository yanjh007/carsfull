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
    AppointmentStatusSubmited, //已提交
    AppointmentStatusConfirm, //已确认
    AppointmentStatusCanceled, //已取消
    AppointmentStatusCanceledByService, //已被服务方取消
    AppointmentStatusFinished, //已完成
};

@interface Appointment : NSObject
@property (strong,nonatomic) NSString *acode,*car,*shop,*descp;
@property (assign) int aid,status;


+(NSArray*) getList:(int)imode; //各种预约列表
+(NSString *) getForSubmit; //用于提交

+(instancetype) newItem;
-(instancetype) initWithCar:(NSString*)car andShop:(NSString*)shop;

-(BOOL) save:(NSString*)plan_at car:(NSString*)car andShop:(NSString*)shop;
-(BOOL) remove;

@end

#pragma mark - 店铺模型
@interface Shop : NSObject
@property (strong,nonatomic) NSString *scode,*name,*address;

+(NSArray*) getList;
+(void) save:(NSDictionary*)dic at:(NSString*)dtime; //保存同步数据

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




#pragma mark - 车辆型号
