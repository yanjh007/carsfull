//
//  MainViewController.h
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JY_StdVC.h"

@interface AppointmentListVC : JY_StdMainVC
@end

@interface AppointmentVC : JY_StdPushVC
- (id)initWithData:(NSArray*)adata;
@end
