
#import "JY_DBHelper.h"

//Database
static NSString *const DB_NAME   = @"appdata.db";
static int const DB_VERSION = 2;


@interface JY_DBHelper ()

@end

@implementation JY_DBHelper

+(void) initDB
{
    NSArray  *paths  =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) ;
    
    NSString *dbpath = [paths[0] stringByAppendingPathComponent:DB_NAME] ;
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbpath];
    
    if (![dataBase open]) {
        NSLog(@"OPEN FAIL");
    } else {
        FMResultSet *s = [dataBase executeQuery:@"SELECT count(1) FROM sqlite_master WHERE type='table' AND name='_meta'"];
        int version=0;
        if(s && [s next]) {
            if ([s intForColumnIndex:0]>0) {
                FMResultSet *s1= [dataBase executeQuery:@"SELECT mvalue FROM _meta WHERE mname='dbversion'"];
                if (s1 && [s1 next]) {
                    version=[s1 intForColumnIndex:0];
                    [s1 close];
                }
            }
            [s close];
        }
        
        if (DB_VERSION > version) { //升级
            if (version==0) { //从0升级
                [dataBase executeUpdate:@"CREATE TABLE _meta(mname string PRIMARY KEY, mvalue text)"]; //meta表
                [dataBase executeUpdate:@"insert into _meta values('dbversion','1')"];
                
                [dataBase executeUpdate:@"CREATE TABLE brands(brand string, brand_sn string PRIMARY KEY, edit_at datetime)"]; //品牌型号列表
                
                version++;
            }
            
            if (version==1) { //从1升级
                [dataBase executeUpdate:@"CREATE TABLE cars(carid int, carnumber string PRIMARY KEY, framenumber string, enginenumber string, brand string, brand_sn string)"];
                version++;
            }
            
            [dataBase executeUpdate:[NSString stringWithFormat:@"update _meta set mvalue=%i where mname='dbversion'",DB_VERSION]];
            
        }

    }
    
}

+(FMDatabase*) openDB
{
    NSArray  *paths  =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) ;
    
    NSString *dbpath = [paths[0] stringByAppendingPathComponent:DB_NAME] ;
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbpath];
    
    if (![dataBase open]) {
        NSLog(@"OPEN FAIL");
        return nil;
    } else {
        return dataBase;
    }
}

@end
