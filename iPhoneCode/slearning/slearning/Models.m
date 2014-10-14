//
//  JY_Lesson.m
//  slearning
//
//  Created by john yan on 14/10/14.
//  Copyright (c) 2014年 info.zhuami. All rights reserved.
//

#import "Models.h"
#import "JY_DBHelper.h"

@implementation JY_Lesson

- (id)initWithDbRow:(FMResultSet*) rs
{
    self = [super init];
    if (self) {
        self.lid  = [rs intForColumn:@"lid"]?:0;
        self.name      = [rs stringForColumn:@"name"];
        self.content   = [rs stringForColumn:@"content"];
    }
    return self;
}

+(void) save:(NSDictionary*)dic;
{
    
}

+(void) saveList:(NSArray*)ary;
{
    NSString *sql;
    FMDatabase *db=[JY_DBHelper openDB];
    for (NSDictionary *item in ary) {
        sql=@"insert into tb_lessons (id,course_id,course_name,name,content,status,stime,etime) values (?,?,?,?,?)";
        
        [JY_DBHelper execSQLWithData:sql,item[@"lesson_id"],item[@"name"],item[@"content"]];
    }
    
    [db close];
}


+(NSArray*) getLessons;
{
    NSString *sql=@"select from tb_lessons order by course, morder";
    FMDatabase *db=[JY_DBHelper openDB];
    
    FMResultSet *s = [db executeQuery:sql];
    NSMutableArray *ary=[NSMutableArray array];
    while ([s next]) {
        JY_Lesson *item=[[JY_Lesson alloc] initWithDbRow:s];
        [ary addObject:item];
    }
    
    [db close];
    return [ary copy];
}


@end
