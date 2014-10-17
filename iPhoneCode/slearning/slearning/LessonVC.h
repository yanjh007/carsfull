//
//  ContentVC.h
//  slearning
//
//  Created by YanJH on 14-9-30.
//  Copyright (c) 2014年 cn.yanjh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models.h"

@interface LessonVC : UIViewController
-(void) setLesson:(JY_Lesson*)lesson;
@end


@interface LessonPageVC : UIViewController
-(void) setMData:(id)data;
@end


@interface LessonPage : UIView
-(instancetype) initWithData:(NSDictionary*) data;
-(void) show:(BOOL)bShow;
@end

@interface LessonItem : UIView
-(instancetype) initWithData:(NSDictionary*) data andWidth:(float)width;
-(NSDictionary*) getResult;
@end

@interface ExamGroup : UIView
-(instancetype) initWithConfig:(NSDictionary*)cfg;
-(NSDictionary*) getResult;
@end

