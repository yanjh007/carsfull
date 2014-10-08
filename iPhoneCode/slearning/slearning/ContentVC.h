//
//  ContentVC.h
//  slearning
//
//  Created by YanJH on 14-9-30.
//  Copyright (c) 2014年 cn.yanjh. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContentVC : UIViewController
-(void) setMData:(id)data;
@end


@interface ContentPageView : UIView
-(instancetype) initWithData:(NSDictionary*) data;
-(void) show:(BOOL)bShow;
@end
