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

@interface JY_Lesson : NSObject

@property (assign) int cid,lid,mtype,stime,etime,status;
@property (strong,nonatomic) NSString *content,*name,*course_name;
//@property (assign) int carid,status,year;
//@property (strong,nonatomic) NSArray *colorList,*cfgList,*engineList,*transList,*yearList;

+(void) save:(NSDictionary*)dic;
+(void) saveList:(NSArray*)ary;
+(void ) saveFeedback:(NSDictionary*)feedback forLesson:(int)lid;

+(NSArray*) getLessons;
+(NSArray*) getFeedback:(int)lesson id:(int)sid;
@end
