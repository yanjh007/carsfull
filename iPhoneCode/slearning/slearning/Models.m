//
//  JY_Lesson.m
//  slearning
//
//  Created by john yan on 14/10/14.
//  Copyright (c) 2014年 info.zhuami. All rights reserved.
//

#import "Models.h"
#import "JY_DBHelper.h"
#import "JY_Request.h"
#import "User.h"

@implementation JY_Lesson

- (id)initWithDbRow:(FMResultSet*) rs
{
    self = [super init];
    if (self) {
        self.lid       = [rs intForColumn:@"id"]?:0;
        self.name      = [rs stringForColumn:@"name"];
        self.mtype     = [rs intForColumn:@"mtype"];
        self.mid       = [rs intForColumn:@"module"];
        self.content   = [rs stringForColumn:@"content"];
        self.lstatus   = [rs intForColumn:@"lstatus"]; //课程状态
        self.status    = [rs intForColumn:@"status"]; //课程状态
        self.stime     = [rs intForColumn:@"stime"]; //开始时间
        self.etime     = [rs intForColumn:@"etime"]; //结束时间
        self.answer    = [rs stringForColumn:@"answer"]; //课程状态
    }
    return self;
}

+(NSArray*) getLessons;
{
    NSString *sql=@"select id,name,mtype,module,content,answer,status,lstatus,stime,etime,update_at from lessons order by course, morder";
    
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

// 答题完成，保存到数据库
-(void) saveFeedback:(NSArray*)feedback ;
{
    self.answer=[feedback jsonString];
    if (self.answer) {
        NSString
        //    *sqlDel = @"delete from lesson_data where id=?",
        //    *sqlAdd = @"insert into lesson_data (id,name,content,status,update_at) values (?,?,?,?,?)",
        *sqlUpdate = @"update lessons set answer=?,status=?,update_at=? where id=?";
        
        FMDatabase *db=[JY_DBHelper openDB];
        
        [db executeUpdate:sqlUpdate,
         self.answer,
         @(1),
         @([[NSDate new] timeIntervalSince1970]/60),
         @(self.lid)];

        [db close];
    }
}


+(void) submit:(int)stype
    completion:(void (^)(int status))completion;
{
    NSString *sql=@"select id,answer,status,lstatus,stime,etime,update_at from lessons where status =1";
    
    FMDatabase *db=[JY_DBHelper openDB];
    
    FMResultSet *s = [db executeQuery:sql];
    NSMutableArray *ary=[NSMutableArray array];
    while ([s next]) {
        [ary addObject:@{@"lid"     :[s stringForColumn:@"id"],
                         @"answer"  :[s stringForColumn:@"answer"]
                        }];
    }
    
    [db close];
    
    NSString *answer=[ary jsonString];
    
    [JY_Request post:@{
                       MKEY_USER:@"9",
                       MKEY_TOKEN :@"hello",
                       MKEY_METHOD:@"sreport",
                       @"content":answer
                       }
             withURL:URL_BASE_SERVICE
          completion:^(int status,NSString* result) {
              NSDictionary *dic=[result jsonObject];
              if (dic && [JVAL_RESULT_OK isEqualToString:dic[JKEY_RESULT]]) {
                  completion(200);
              }
              
              NSLog(@"result:%@",result);
          }];
    
}

+(void) fetchLessons:(void (^)(int status))completion;
{
    [JY_Request post:@{
                       MKEY_USER:@([User shared].uid),
                       MKEY_TOKEN :[User shared].token,
                       MKEY_METHOD:@"slesson"
                       }
             withURL:URL_BASE_SERVICE
          completion:^(int status,NSString* result) {
              NSDictionary *dic=[result jsonObject];
              if (dic && [JVAL_RESULT_OK isEqualToString:dic[JKEY_RESULT]]) {
                  NSArray *ary=dic[JKEY_CONTENT];
                  NSString
                  *sqlDel = @"delete from lessons ",
                  *sqlInsert  = @"insert into lessons (id,name,mtype,module,content,lstatus,stime,etime,status,update_at) values (?,?,?,?,?,?,?,?,?,?)",
                  *sqlUpdate  = @"insert into lessons (id,name,mtype,module,content,lstatus,stime,etime,status,update_at) values (?,?,?,?,?,?,?,?,?,?)";
                  
                  FMDatabase *db=[JY_DBHelper openDB];
                  [db executeUpdate:sqlDel];
                  
                  // 更新时间
                  int update_at=0;
                  for (NSDictionary *item in ary) {
                      if (update_at<[item[@"update_at"] intValue]) {
                          update_at=[item[@"update_at"] intValue];
                      }
                      [db executeUpdate:sqlInsert
                   withArgumentsInArray:@[item[@"lesson_id"],
                                          item[@"name"],
                                          item[@"mtype"],
                                          item[@"module"], //模块编号
                                          item[@"content"],
                                          item[@"status"], //课程状态
                                          item[@"stime"],
                                          item[@"etime"],
                                          @(0), //本地状态，插入
                                          @([[NSDate new] timeIntervalSince1970]/60)
                                          ]];
                  }
                  
                  if (update_at>0) {
                      [JY_DBHelper setMeta:DBMKEY_LESSON_VERSION
                                     value:[NSString stringWithFormat:@"%i",update_at]];
                  }
                  
                  [db close];
                  
                  completion(200);
                  return;
              }
              completion(0);
          }];
}

@end
