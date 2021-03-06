
#import <UIKit/UIKit.h>
#import "FMDatabase.h"

//Database
static NSString *const TB_APPOINTMENTS   = @"appointments";
static NSString *const TB_CARS     = @"cars";
static NSString *const TB_SHOPS    = @"shops";
static NSString *const TB_BRANDS   = @"brands";
static NSString *const TB_META     = @"_meta";

static NSString *const DBMKEY_SHOP_VERSION  = @"shops_update_version";
static NSString *const DBMKEY_CARS_VERSION  = @"cars_update_version";
static NSString *const DBMKEY_BRAND_TIME    = @"brands_update_time";

@interface JY_DBHelper : NSObject 
+(void) initDB;
+(FMDatabase*) openDB;

+(void) setMeta:(NSString*)k value:(NSString*)v;
+(NSString*) metaValue:(NSString*)k;

// SQLHelper
+ (int)  execSQL:(NSString*)sql;
+ (BOOL) execSQLWithData:(NSString*)sql, ...;

// 数据维护
+(void) maintain;

@end

@interface NSString(Database)
-(NSString*) withTable:(NSString*)table;
@end
