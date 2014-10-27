//
//  JY_Lesson.h
//  slearning
//
//  Created by john yan on 14/10/14.
//  Copyright (c) 2014年 info.zhuami. All rights reserved.
//

#import <Foundation/Foundation.h>

static int QTYPE_SECTION  = 10;
static int QTYPE_SINGLE_SELECT  = 11;
static int QTYPE_MULTI_SELECT  = 12;
static int QTYPE_FILL_BLANK  = 13;
static int QTYPE_SIMPLE_ANSWER  = 19;

static NSString *const ANSWER_MARKER_RIGHT = @"✓"; //正确答案标记
static NSString *const QSPLIT_OPTION = @"\n\n\n"; //内容和选项分隔符号
static NSString *const QSPLIT_OPTION_CONTENT = @"\n"; //答案选项分隔副
static NSString *const QSPLIT_MULTI_ANSWER = @","; //填空正确多答案
static NSString *const QSPLIT_MULTI_BLANK = @",,"; //填空正确多答案

@interface JY_Lesson : NSObject

@property (assign) int lid,mid,mtype,stime,etime,status,lstatus;
@property (strong,nonatomic) NSString *content,*name,*course_name,*answer;
//@property (assign) int carid,status,year;

+(NSArray*) getLessons;

-(NSDictionary*) getAnswer;
-(void) saveFeedback:(NSArray*)feedback ;

// 从后台获取课程信息
+(void) fetchLessons:(void (^)(int status))completion;

// 提交课程答案
+(void) submit:(int)stype
    completion:(void (^)(int status))completion;


@end
