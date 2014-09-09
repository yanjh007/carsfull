//
//  MainViewController.h
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JY_StdVC.h"

@interface LinkVC : JY_StdMainVC

@end

@interface LinkView :UIView
- (void)setData:(NSDictionary*) data;
- (void)setDelegate:(id<JY_STD_Delegate>) dele;
@end

@interface LinkGestureRecognizer : UIGestureRecognizer

@end

