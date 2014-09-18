//
//  MainViewController.h
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JY_StdVC.h"

@interface CarVC : JY_StdPushVC
-(void) setData:(NSObject*)data;
@end


@interface CarseriesVC : JY_StdPushVC
- (id)initWithData:(NSArray*)adata;
@end