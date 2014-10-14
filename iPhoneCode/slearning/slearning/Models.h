//
//  JY_Lesson.h
//  slearning
//
//  Created by john yan on 14/10/14.
//  Copyright (c) 2014年 info.zhuami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JY_Lesson : NSObject

@property (assign) int cid,lid,stime,etime,status;
@property (strong,nonatomic) NSString *content,*name,*course_name;
//@property (assign) int carid,status,year;
//@property (strong,nonatomic) NSArray *colorList,*cfgList,*engineList,*transList,*yearList;

+(void) save:(NSDictionary*)dic;
+(void) saveList:(NSArray*)ary;
+(NSArray*) getLessons;
@end
