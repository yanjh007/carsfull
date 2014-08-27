//
//  ZM_FundationAdditions.h
//  基础类扩展
//

#import <Foundation/Foundation.h>
#import "App_Controller.h"

#define iPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iOS_VERSION  [[[UIDevice currentDevice] systemVersion] floatValue]
#define is_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0)


// 字符串常量
static NSString *const STRING_DATE_YMDHM=@"yyyy-MM-dd HH:mm";
static NSString *const STRING_DATE_YMDHMS=@"yyyy-MM-dd HH:mm:ss";
static NSString *const STRING_DATE_YMDTHMS=@"yyyy-MM-dd'T'HH:mm:ss";
static NSString *const STRING_DATE_DHMS=@"MM-dd HH:mm";
static NSString *const STRING_DATE_HM  =@"HH:mm";
static NSString *const STRING_DATE_YMD =@"yyyy-MM-dd";
static NSString *const STRING_DATE_MD  =@"MM-dd";

// 代理方法
static int const DELE_RESULT_VOID   = 0;
static int const DELE_RESULT_OK     = 1;
static int const DELE_RESULT_CANCEL = 2;
static int const DELE_RESULT_QUIT   = 3;
static int const DELE_RESULT_NULL   = 4;

static int const DELE_ACTION_HTTP_OK=11;
static int const DELE_ACTION_HTTP_FALSE=12;
static int const DELE_ACTION_HTTP_ERROR=13;

static int const DELE_ACTION_SET_EXPAND=1001;

static int const DELE_ACTION_POPUP=1011;
static int const DELE_ACTION_DISMISS=1012;
static int const DELE_ACTION_POPMENU_ITEM=1013;

static int const DELE_ACTION_SEARCH=1101;

static int const DELE_ACTION_NOTIFICATION_PERMISSION=1201;

static int const DELE_ACTION_PUSH=1211;
static int const DELE_ACTION_PUSH_BACK=1212;

static int const DELE_LIST_CHECK     = 1301;
static int const DELE_LIST_UNCHECK   = 1302;
static int const DELE_LIST_SELECT    = 1303;
static int const DELE_LIST_EXPAND    = 1304;
static int const DELE_LIST_COLLAPSE  = 1305;
static int const DELE_LIST_TOGGLE_EXPAND  = 1306;

static int const DELE_LIST_ADD_LAST  = 1311;
static int const DELE_LIST_ADD_FIRST = 1312;
static int const DELE_LIST_DELETE    = 1313;

static int const DELE_LIST_RELOAD= 1321;
static int const DELE_CELL_RELOAD= 1322;

static int const DELE_MENU_ITEM  = 1331;
static int const DELE_MENU_LARROW    = 1332;
static int const DELE_MENU_RARROW    = 1333;
static int const DELE_MENU_OK   = 1334;
static int const DELE_MENU_CANCEL   = 1335;

static int const DELE_ACTION_PAY         = 2101;
static int const DELE_ACTION_PAY_SUCCESS = 2102;
static int const DELE_ACTION_PAY_FALSE   = 2103;
static int const DELE_ACTION_PAY_RECOVER = 2104;


@protocol JY_STD_Delegate<NSObject>
@optional
- (int) action:(int)act withIndex:(int)index;
- (int) action:(int)act withTag:(NSObject*)tag;
@end

#pragma mark - NSArray扩展
@interface  NSArray (JY_FoundationAdditions)
-(id) objectAtCheckedIndex:(NSUInteger) index;
+ (BOOL) isEmpty:(NSArray*)ary;
@end

@interface NSMutableArray (JY_FoundationAdditions)
-(void) setObject:(id) object atCheckedIndex:(NSUInteger) index;
@end

#pragma mark - UIButton扩展
@interface UIButton (JY_FoundationAdditions)
-(void)setObjectTag:(NSObject *) tag;
-(NSObject*) objectTag;
@end

#pragma mark - UIViewController 扩展
@interface UIViewController(JY_FoundationAdditions)
-(BOOL) isInternetAvailable:(BOOL) bPrompt;

-(id) pushTo:(NSString*)name;
-(id) pushTo:(NSString*)name showBack:(BOOL) bShow;
-(id) pushTo:(NSString*)name withObject:(id)tag andDelegate:(id)delegate;
-(id) popUp:(NSString*)name withObject:(id)tag andDelegate:(id)delegate;

+(UIViewController*) addController:(NSString*)name toView:(UIView*) v andTag:(id)tag andDelegate:(id)delegate;

-(void) setTagObject:(id)tag;
-(void) setDele:(id)delegate;

- (UIButton*) setZMRightButton:(NSString *)image1 andImage2:(NSString*)image2 withSEL:(SEL)onClick;
- (void) setupTitleBar:(int)smode;
- (void) setZMBackButton;
- (void) setZMBackGround;

@end

#pragma mark - NSData 扩展
@interface NSData(JY_FoundationAdditions)
+ (NSData *) dataWithBase64EncodedString:(NSString *) string;

- (id) initWithBase64EncodedString:(NSString *) string;
- (NSString *) base64Encoding;
- (NSString *) base64EncodingWithLineLength:(unsigned int) lineLength;
//- (NSString*) urlEncodedString;

- (NSString *)hexadecimalDescription;
@end


#pragma mark - NSString 扩展
@interface NSString(JY_FoundationAdditions)
+(BOOL) isEmpty:(NSString*)str;

-(int) indexInList:(NSArray*) slist;
-(NSDate*) dateValue:(NSString*)dFormat;
-(NSDictionary*) jsonObject;
-(NSArray*) jsonArray;

-(NSString *) URLEncodedString_ch;
-(NSDictionary*) httpDic;

-(NSString*) sha1;
-(NSString*) md5;

+(NSString*) randomString:(int)num;
- (NSString *)reversedString;

-(NSString*) formatDateInLong:(float)timesec;
-(void) drawAtX:(float)x Y:(float)y withFont:font align:(int)align;

@end

#pragma mark - NSDictionay 扩展
@interface NSDictionary(JY_FoundationAdditions)
+ (BOOL) isEmpty:(NSDictionary*)dic;
- (NSString*) jsonString;
- (NSData*) httpEncode;
@end


#pragma mark - UIScrolleView 扩展

@interface UIScrollView (JY_FoundationAdditions)

- (float) addView:(UIView*)view atX:(float)x andY:(float)y;

@end

#pragma mark - UIView扩展
@interface UIView(JY_FoundationAdditions)
- (void) removeAllSubview;
- (void) moveToX:(float)x andY:(float)y;
- (void) moveY:(float)y;
- (void) moveAniToX:(float)x andY:(float)y;

+(UIImage *) imageFromColor:(UIColor *)color;

@end

#pragma mark - UIImageView扩展
@interface UIImageView(JY_FoundationAdditions)
-(void) setImageWithUrl:(NSString *)url andHolder:(NSString*)holder;
@end

#pragma mark - UITableView 扩展
@interface UITableView(JY_FoundationAdditions)
- (void)setBottomMargin;
@end

#pragma mark - UIColor 扩展
@interface UIColor(JY_FoundationAdditions)
+(UIColor *) colorWithStr:(NSString *) stringToConvert;
+ (UIColor *) stockRed;
+ (UIColor *) stockGreen;
@end

#pragma mark - NSDate 扩展
@interface NSDate(JY_FoundationAdditions)
- (NSString*) stringValue:(NSString*)dFormat;
+ (NSString*) stringNow:(NSString*)dFormat;
+ (NSString*) rstringNow;
+ (int) daysFromNow:(NSString*)date format:(NSString*)dFormat;
@end

#pragma mark - ZM Helper 抓米实用方法
@interface JY_Default:NSObject
+(NSObject*) get:(NSString *) key;
+(int) getInt:(NSString *) key;
+(NSNumber*) getNumber:(NSString *) key;
+(NSString*) getString:(NSString *) key;

+(void) save:(NSDictionary*)dic;
+(void) save:(NSObject*) value forKey:(NSString*) key;
+(void) saveString:(NSString *)value forKey:(NSString*) key;
+(void) saveInt:(int) value forKey:(NSString*) key;
+(void) saveNumber:(NSNumber*) value forKey:(NSString*) key;

+(void) remove:(NSArray*) keys;
+(void) removeOne:(NSString*) key;
@end

#pragma mark - ZM NotifyHelper 抓米通知
@interface ZM_NotifyHelper:NSObject
+(void) regNotify:(NSString*)token;
@end

#pragma mark - ZM Helper 抓米实用方法
@interface JY_Helper:NSObject

+ (NSString *) getWeekString:(NSString *) stringYMD;
+ (id) loadNib:(NSString*) nibName atIndex:(int)index;

+(UIAlertView*) showAlert:(NSString*)title message:(NSString*)message withID:(int)aid andDelegate:(id<UIAlertViewDelegate>)dele;
+(UIAlertView*) showAlert:(NSString*)title message:(NSString*)message;

+(NSString*) fakeIMEI;
+(NSString*) appID;
+(NSString*) channel;
+(long) setTimeMargin:(NSDate*)serverDate;
+(NSString*) uid:(NSString*) idkey;

+(BOOL) isZMResultOK:(NSString*)str;
+(BOOL) isZMNotNull:(NSObject*)obj;

+ (float) largerValue:(float) v1 and:(float)v2;
+ (float) smallerValue:(float) v1 and:(float)v2;


//格式化
+(NSString*) format:(float)value withtype:(int)ftype;


@end

