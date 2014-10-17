
#import "JY_DBHelper.h"

//Database
static NSString *const DB_NAME   = @"appdata.db";
static int const DB_VERSION = 1;

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
        if(s) {
            if ([s next] && [s intForColumnIndex:0]>0) {
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
                [dataBase executeUpdate:@"CREATE TABLE _meta (mname string PRIMARY KEY, mvalue text)"]; //meta表
                [dataBase executeUpdate:@"insert into _meta values('dbversion','1')"];
                
                version++;
            }
            
            if (version==1) { //从1升级
                //  课堂列表
                [dataBase executeUpdate:@"CREATE TABLE lessons (id int PRIMARY KEY, name string, course_id int, course_name string, mtype int,morder int, content text, status int, stime int, etime int,  edit_at int)"];

                //  反馈信息和答案
                [dataBase executeUpdate:@"CREATE TABLE lesson_data (id int PRIMARY KEY, name string, content text, status int, update_at int)"];

                version++;
            }
            
            [dataBase executeUpdate:@"update _meta set mvalue=? where mname='dbversion'",@(DB_VERSION)];
        }
        [dataBase close];
    }
}

// 数据维护
+(void) maintain
{
//    FMDatabase *db = [JY_DBHelper openDB];
//    // 删除已经移除的车辆信息
//    [db executeUpdate:@"Delete from cars where status = 6"];
//    
//    [db close];
    
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

+(void) setMeta:(NSString*)k value:(NSString*)v
{
    FMDatabase *db = [JY_DBHelper openDB];
    
    FMResultSet *s = [db executeQuery:@"select 1 from _meta  where mname=? limit 1",k];
    if (s) {
        NSString *sql;
        if ([s next]) {
            sql=@"UPDATE _meta set mvalue=? where mname=?";
        } else {
            sql=@"INSERT INTO _meta (mvalue,mname) values (?,?)";
        }
        [db executeUpdate:sql,v,k];
        [s close];
    }
    
    [db close];
}

+(NSString*) metaValue:(NSString*)k
{
    NSString *result=nil;
    FMDatabase *db = [JY_DBHelper openDB];
    FMResultSet *s = [db executeQuery:@"select mvalue from _meta  where mname=? limit 1",k];
    if (s) {
        if ([s next]) result=[s stringForColumnIndex:0];
        [s close];
    }
    [db close];
    return  result;
}

+(NSString*) tableSQL:(NSString*)sql table:(NSString*)table
{
    return [NSString stringWithFormat:sql,table];
}

+(int) execSQL:(NSString*)sql
{
    FMDatabase *db = [JY_DBHelper openDB];
    
    int result=[db executeStatements:sql];
    
    [db close];
    
    return  result;
}

+ (BOOL)execSQLWithData:(NSString*)sql, ... {
    va_list args;
    va_start(args, sql);
    
    FMDatabase *db = [JY_DBHelper openDB];
    
    BOOL result = [db executeUpdate:sql withVAList:args];
    
    [db close];
    va_end(args);

    return result;
}

@end

@implementation NSString(Database)
-(NSString*) withTable:(NSString*)table;
{
    return [NSString stringWithFormat:self,table];
}
@end
