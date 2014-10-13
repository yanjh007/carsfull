//
//  AppController.h
//  slearning
//
//  Created by YanJH on 14-10-1.
//  Copyright (c) 2014年 cn.yanjh. All rights reserved.
//


#import "User.h"
#import "JY_FundationAdditions.h"



#pragma mark - 背景和图片
static NSString *const BG_IMG_TITLE_BAR    = @"bg_nav";
static NSString *const BG_IMG_NORMAL_PAGE  = @"bg_main";

static NSString *const BG_BUTTON_BACK1 = @"bt_back1";
static NSString *const BG_BUTTON_BACK2 = @"bt_back2";

static NSString *const BG_BUTTON_REFRESH1 = @"bt_refresh1";
static NSString *const BG_BUTTON_REFRESH2 = @"bt_refresh2";

static NSString *const BG_BUTTON_MORE1 = @"bt_diag_more1";
static NSString *const BG_BUTTON_MORE2 = @"bt_diag_more2";

#define ZMCOLOR_MAIN_FOREGROUND [UIColor redColor]
#define ZMCOLOR_MAIN_BACKGROUND [UIColor whiteColor]

#pragma mark - 标准常用设置和字典键值
static NSString *const SD_UUID_DEVICE =@"sd_uuid_device";
static NSString *const SD_UUID_APP =@"sd_uuid_app";
static NSString *const SD_UUID_USER =@"sd_uuid_user";

static NSString *const PKEY_APP_START_COUNT    = @"pkey_app_start_count";
static NSString *const PKEY_APP_CACHED_VERSION = @"pkey_app_cached_version";
static NSString *const PKEY_APP_END_TIME        = @"application_close_time";
static NSString *const PKEY_TIME_MARGIN        = @"application_time_margin_key";

static NSString *const DKEY_ID=@"id";
static NSString *const DKEY_TITLE=@"title";
static NSString *const DKEY_CONTENT=@"content";
static NSString *const DKEY_TYPE=@"type";
static NSString *const DKEY_USER=@"user";
static NSString *const DKEY_TAG =@"tag";

#pragma mark - 通用网络参数和常量
static NSString *const UKEY_REQUEST=@"req_type";
static NSString *const UKEY_PAGE_SIZE=@"pageSize";
static NSString *const UVAL_PAGE_SIZE=@"40";
static NSString *const UKEY_PAGE_NO=@"pageNo";
static NSString *const UVAL_PAGE_NO=@"1";
static NSString *const UKEY_ID=@"id";
static NSString *const UKEY_END=@"end";
static NSString *const UVAL_END=@"20";

static NSString *const UVAL_APPID=@"1005";

static NSString *const MKEY_METHOD      = @"M";
static NSString *const MKEY_DEVICE_ID   = @"I";
static NSString *const MKEY_USER        = @"U";
static NSString *const MKEY_CONTENT     = @"C";
static NSString *const MKEY_TOKEN       = @"S";
static NSString *const MKEY_VERSION     = @"V";
static NSString *const MKEY_HASH        = @"H";

static NSString *const JKEY_RESULT  = @"R";
static NSString *const JKEY_CONTENT = @"C";
static NSString *const JKEY_USER    = @"U";
static NSString *const JKEY_DEVICE  = @"I";
static NSString *const JKEY_TIME    = @"T";
static NSString *const JKEY_VERSION = @"V";
static NSString *const JKEY_TOKEN   = @"K";

static NSString *const JKEY_TITLE   = @"title";
static NSString *const JKEY_ID      = @"id";
static NSString *const JKEY_PAGING  = @"pagings";

static NSString *const JVAL_RESULT_OK    = @"OK";
static NSString *const JVAL_RESULT_FALSE = @"FALSE";
static NSString *const JVAL_RESULT_ERROR = @"ERROR";
static NSString *const JVAL_RESULT_NULL  = @"NULL";