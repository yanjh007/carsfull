
#import <UIKit/UIKit.h>
#import "FMDatabase.h"

//Database
static NSString *const TB_META     = @"_meta";
static NSString *const TB_LESSONS  = @"lessons";

static NSString *const DBMKEY_LESSON_VERSION  = @"lesson_update_version";

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
