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
        self.lid       = [rs intForColumn:@"id"]?:0;
        self.name      = [rs stringForColumn:@"name"];
        self.mtype     = [rs intForColumn:@"mtype"];
        self.content   = [rs stringForColumn:@"content"];
        self.status    = [rs intForColumn:@"status"]; //课程状态
        self.stime     = [rs intForColumn:@"stime"];
        self.etime     = [rs intForColumn:@"etime"];
    }
    return self;
}

+(void) saveList:(NSArray*)ary;
{
    NSString
    *sqlDel = @"delete from lessons where id=?",
    *sql    = @"insert into lessons (id,name,mtype,content,status,stime,etime) values (?,?,?,?,?,?,?)";
    
    //        sql=@"insert into lessons (id,course_id,course_name,name,content,status,stime,etime) values (?,?,?,?,?)";
    
    int update_at=0;
    
    FMDatabase *db=[JY_DBHelper openDB];
    for (NSDictionary *item in ary) {
        if (update_at<[item[@"update_at"] intValue]) {
            update_at=[item[@"update_at"] intValue];
        }
        [db executeUpdate:[NSString stringWithFormat:sqlDel,item[@"lesson_id"]]];
        [db executeUpdate:sql
     withArgumentsInArray:@[item[@"lesson_id"],
                            item[@"name"],
                            item[@"mtype"],
                            item[@"content"],
                            item[@"status"],
                            item[@"stime"],
                            item[@"etime"]
                            ]];
    }
    
    if (update_at>0) {
        [JY_DBHelper setMeta:DBMKEY_LESSON_VERSION
                       value:[NSString stringWithFormat:@"%i",update_at]];
    }
    
    [db close];
}


+(NSArray*) getLessons;
{
    NSString *sql=@"select id,name,mtype,content,status,stime,etime from lessons order by course_id, morder";
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


+(void ) saveFeedback:(NSDictionary*)feedback forLesson:(int)lid;
{
//    NSString *sql=@"select id,name,mtype,content,status,stime,etime from lessons order by course_id, morder";
//    FMDatabase *db=[JY_DBHelper openDB];
//    
//    FMResultSet *s = [db executeQuery:sql];
//    NSMutableArray *ary=[NSMutableArray array];
//    while ([s next]) {
//        JY_Lesson *item=[[JY_Lesson alloc] initWithDbRow:s];
//        [ary addObject:item];
//    }
//    
//    [db close];
    
    NSLog(@"lesson:%i \n result:%@",lid,feedback);
}

@end
