//
//  SD_UIControl.h
//  StockDiagnose
//
//  Created by Joe Chen on 13-2-22.
//  Copyright (c) 2013年 港澳资讯集团－成都抓米信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JY_FundationAdditions.h"
//#import "ZM_UMHelper.h"
#import "JY_Request.h"

//测试模式 - APP启动实验，支付宝、银联1分，更多测试菜单， IAP验证
#define IN_TEST NO
#define IS_NEED_PAY NO

//iCloud  key-value存储的keyID
#define UBIQUITY_CONTAINER_URL @"YXV3L9ZB93.com.zhuamiinfo.com"

// Url
static NSString *const URL_BASE_URL  = @"http://127.0.0.1/cars/s";
//static NSString *const URL_BASE_URL  = @"http://192.168.0.131/cars/s";


//第一次安装标识
static NSString *const IsFirstInstallMark     = @"isfirstinstallmark";

// 主NIB文件
static NSString *const NIB_MAIN  = @"Main";


// 背景和图片
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

// 图形控制
static int const INT_SDVIEW_MARGIN = 10;


// 控制器名称
static NSString *const VC_NAME_PRICE=@"SD_PriceVC";
static NSString *const VC_NAME_INFO=@"SD_InfoVC";
static NSString *const VC_NAME_INFO_DETAIL=@"SD_InfoDetailVC";

static NSString *const VC_NAME_SIXDIM=@"SD_SixdimVC";

static NSString *const VC_NAME_FAV=@"SD_MyStockVC";

static NSString *const VC_NAME_RANK=@"SD_RankVC";

static NSString *const VC_NAME_NEWS=@"SD_NewsVC";

static NSString *const VC_NAME_ORGDIAG=@"SD_OrgdiagVC";

static NSString *const VC_NAME_CLASS=@"SD_StockClassVC";

static NSString *const VC_NAME_MORE =@"SD_MoreVC";

static NSString *const VC_NAME_DIAGNOSE_PRO = @"SD_DiagProVC";
static NSString *const VC_NAME_DIAGNOSE_STD = @"SD_DiagStdVC";

static NSString *const VC_NAME_EXCHANGE=@"SD_ExchangeVC";
static NSString *const VC_NAME_SEARCH_LIST=@"SD_SearchListVC";


// UUID key
static NSString *const SD_UUID_DEVICE =@"sd_uuid_device";
static NSString *const SD_UUID_APP =@"sd_uuid_app";
static NSString *const SD_UUID_USER =@"sd_uuid_user";

//default key
static NSString *const PKEY_APP_START_COUNT    = @"pkey_app_start_count";
static NSString *const PKEY_APP_CACHED_VERSION = @"pkey_app_cached_version";
static NSString *const PKEY_APP_END_TIME        = @"application_close_time";
static NSString *const PKEY_TIME_MARGIN        = @"application_time_margin_key";

// 设置键值
static NSString *const PKEY_TOKEN       = @"token";
static NSString *const PKEY_TOKEN_TIME  = @"token_time";
static NSString *const PKEY_NOUN_TIME   = @"last_noun_time";
static NSString *const PKEY_TOKEN_LOGIN = @"login";
static NSString *const PKEY_TOKEN_USERID = @"userid";
static NSString *const PKEY_TOKEN_PWD  = @"passwd";


// 标准常用字典键值
static NSString *const DKEY_TITLE=@"title";
static NSString *const DKEY_CONTENT=@"content";
static NSString *const DKEY_TYPE=@"type";
static NSString *const DKEY_USER=@"user";
static NSString *const DKEY_TAG =@"tag";


// 通用网络参数和常量
static NSString *const UKEY_REQUEST=@"req_type";
static NSString *const UKEY_PAGE_SIZE=@"pageSize";
static NSString *const UVAL_PAGE_SIZE=@"40";
static NSString *const UKEY_PAGE_NO=@"pageNo";
static NSString *const UVAL_PAGE_NO=@"1";
static NSString *const UKEY_ID=@"id";
static NSString *const UKEY_END=@"end";
static NSString *const UVAL_END=@"20";

static NSString *const UVAL_APPID=@"1005";

static NSString *const JKEY_RESULT  = @"R";
static NSString *const JKEY_CONTENT = @"C";
static NSString *const JKEY_USER    = @"U";
static NSString *const JKEY_DEVICE  = @"I";
static NSString *const JKEY_TIME    = @"T";

static NSString *const JKEY_TITLE   = @"title";
static NSString *const JKEY_ID      = @"id";
static NSString *const JKEY_PAGING  = @"pagings";

static NSString *const JVAL_RESULT_OK    = @"OK";
static NSString *const JVAL_RESULT_FALSE = @"FALSE";
static NSString *const JVAL_RESULT_ERROR = @"ERROR";
static NSString *const JVAL_RESULT_NULL  = @"NULL";

static NSString *const UKEY_LAST_TIME=@"lastTime"; //

//提示信息
static NSString *const NEWS_SOURCE_GAOTIME    = @"港澳资讯";

static NSString *const PMT_NOINTERNET         = @"哎哟，你的网络貌似有问题";
static NSString *const PMT_NOINTERNET_CHECK   = @"该软件需要在网络状态下运行，请检查你的网络";
static NSString *const PMT_INPUT_STOCK_CODE   = @"请输入代码或简称";
static NSString *const PMT_INPUT_KEYWORD      = @"请输入搜索关键字";
static NSString *const PMT_INPUT_NODATA       = @"输入值为空";

static NSString *const PMT_NODATA             = @"无法获取数据，请检查你的网络";
static NSString *const PMT_NODATA_CONTEXT     = @"数据更新中，请稍后再试";
static NSString *const PMT_NODATA_RETRY       = @"暂时无法获取数据，请稍后再试";

static NSString *const PMT_DATA_ERROR         = @"数据格式错误";
static NSString *const PMT_NO_MATCH_RESULT    = @"抱歉，暂时找不到符合条件的结果";

static NSString *const PMT_IAP_NO_PRODUCT     = @"抱歉，无法获取产品列表，请稍后再试";
static NSString *const PMT_PAY_SUCCESS        = @"购买操作已成功，感谢您的支持！";
static NSString *const PMT_PAY_CANCEL         = @"购买操作已取消";
static NSString *const PMT_PAY_RECOVER        = @"订购记录已经成功恢复";

// App DeleAction 5000+
static int const DELE_ACTION_APMT_SAVE_BACK = 5011;

static int const DELE_ACTION_USER_SAVE_BACK = 5021;
