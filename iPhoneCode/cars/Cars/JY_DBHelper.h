
#import <UIKit/UIKit.h>
#import "FMDatabase.h"

@interface JY_DBHelper : NSObject 
+(void) initDB;
+(FMDatabase*) openDB;
@end
