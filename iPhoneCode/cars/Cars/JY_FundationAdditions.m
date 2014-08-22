//
//  ZM_FundationAdditions.m
//  基础类扩展
//

#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

#import "JY_FundationAdditions.h"
#import "Reachability.h"
#import "App_Controller.h"

#pragma mark - NSData 扩展
static char encodingTable[64] = {
    'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
    'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
    'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
    'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/' };

@implementation NSData(JY_FoundationAdditions)

+ (NSData *) dataWithBase64EncodedString:(NSString *) string {
    NSData *result = [[NSData alloc] initWithBase64EncodedString:string];
    return result;
}

- (id) initWithBase64EncodedString:(NSString *) string {
    NSMutableData *mutableData = nil;
    
    if( string ) {
        unsigned long ixtext = 0;
        unsigned long lentext = 0;
        unsigned char ch = 0;
        unsigned char inbuf[4], outbuf[3];
        short i = 0, ixinbuf = 0;
        BOOL flignore = NO;
        BOOL flendtext = NO;
        NSData *base64Data = nil;
        const unsigned char *base64Bytes = nil;
        
        // Convert the string to ASCII data.
        base64Data = [string dataUsingEncoding:NSASCIIStringEncoding];
        base64Bytes = [base64Data bytes];
        mutableData = [NSMutableData dataWithCapacity:[base64Data length]];
        lentext = [base64Data length];
        
        while( YES ) {
            if( ixtext >= lentext ) break;
            ch = base64Bytes[ixtext++];
            flignore = NO;
            
            if( ( ch >= 'A' ) && ( ch <= 'Z' ) ) ch = ch - 'A';
            else if( ( ch >= 'a' ) && ( ch <= 'z' ) ) ch = ch - 'a' + 26;
            else if( ( ch >= '0' ) && ( ch <= '9' ) ) ch = ch - '0' + 52;
            else if( ch == '+' ) ch = 62;
            else if( ch == '=' ) flendtext = YES;
            else if( ch == '/' ) ch = 63;
            else flignore = YES;
            
            if( ! flignore ) {
                short ctcharsinbuf = 3;
                BOOL flbreak = NO;
                
                if( flendtext ) {
                    if( ! ixinbuf ) break;
                    if( ( ixinbuf == 1 ) || ( ixinbuf == 2 ) ) ctcharsinbuf = 1;
                    else ctcharsinbuf = 2;
                    ixinbuf = 3;
                    flbreak = YES;
                }
                
                inbuf [ixinbuf++] = ch;
                
                if( ixinbuf == 4 ) {
                    ixinbuf = 0;
                    outbuf [0] = ( inbuf[0] << 2 ) | ( ( inbuf[1] & 0x30) >> 4 );
                    outbuf [1] = ( ( inbuf[1] & 0x0F ) << 4 ) | ( ( inbuf[2] & 0x3C ) >> 2 );
                    outbuf [2] = ( ( inbuf[2] & 0x03 ) << 6 ) | ( inbuf[3] & 0x3F );
                    
                    for( i = 0; i < ctcharsinbuf; i++ )
                        [mutableData appendBytes:&outbuf[i] length:1];
                }
                
                if( flbreak )  break;
            }
        }
    }
    
    self = [self initWithData:mutableData];
    return self;
}

- (NSString *) base64Encoding {
    return [self base64EncodingWithLineLength:0];
}

- (NSString *) base64EncodingWithLineLength:(unsigned int) lineLength {
    const unsigned char    *bytes = [self bytes];
    NSMutableString *result = [NSMutableString stringWithCapacity:[self length]];
    unsigned long ixtext = 0;
    unsigned long lentext = [self length];
    long ctremaining = 0;
    unsigned char inbuf[3], outbuf[4];
    short i = 0;
    short charsonline = 0, ctcopy = 0;
    unsigned long ix = 0;
    
    while( YES ) {
        ctremaining = lentext - ixtext;
        if( ctremaining <= 0 ) break;
        
        for( i = 0; i < 3; i++ ) {
            ix = ixtext + i;
            if( ix < lentext ) inbuf[i] = bytes[ix];
            else inbuf [i] = 0;
        }
        
        outbuf [0] = (inbuf [0] & 0xFC) >> 2;
        outbuf [1] = ((inbuf [0] & 0x03) << 4) | ((inbuf [1] & 0xF0) >> 4);
        outbuf [2] = ((inbuf [1] & 0x0F) << 2) | ((inbuf [2] & 0xC0) >> 6);
        outbuf [3] = inbuf [2] & 0x3F;
        ctcopy = 4;
        
        switch( ctremaining ) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for( i = 0; i < ctcopy; i++ )
            [result appendFormat:@"%c", encodingTable[outbuf[i]]];
        
        for( i = ctcopy; i < 4; i++ )
            [result appendFormat:@"%c",'='];
        
        ixtext += 3;
        charsonline += 4;
        
        if( lineLength > 0 ) {
            if (charsonline >= lineLength) {
                charsonline = 0;
                [result appendString:@"\n"];
            }
        }
    }
    
    return result;
}

//- (NSString*) urlEncodedString
//{
//	char *hex = "0123456789ABCDEF";
//	unsigned char* data = (unsigned char*)[self bytes];
//	int len = [self length];
//	//NSLog(@"len = %d", len);
//	NSMutableString* s = [NSMutableString string];
//	for(int i = 0;i<len;i++){
//		unsigned char c = data[i];
//		if( ('a' <= c && c <= 'z')
//		   || ('A' <= c && c <= 'Z')
//		   || ('0' <= c && c <= '9') ){
//			NSString* ts = [[NSString alloc] initWithCString:(char *)&c length:1];
////			NSString* ts = [NSString stringWithUTF8String:(char *)&c];
//
//			[s appendString:ts];
//			[ts release];
//		} else {
//			[s appendString:@"%"];
//			char ts1 = hex[c >> 4];
//		//	NSLog(@"ts = %c", ts1);
//			NSString* ts = [[NSString alloc] initWithCString:&ts1 length:1];
////			NSString* ts = [NSString stringWithUTF8String:(char *)&ts1];
//			[s appendString:ts];
//
//			[ts release];
//			char ts2 = hex[c & 15];
//			ts = [[NSString alloc] initWithCString:&ts2 length:1];
////			ts = [NSString stringWithUTF8String:(char *)&ts2];
//			[s appendString:ts];
//			[ts release];
//		}
//	}
//	return s;
//}
//
//- (NSString*) urlEncodedString1
//{
//    NSString *s =[[NSString alloc] initWithData:self  encoding:NSUTF8StringEncoding];
//    if (s) {
//        return [s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    } else {
//        return @"";
//    }
//
////    s
////    NSString *newString = [NSMakeCollectable(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)s, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding([self stringEncoding]))) autorelease];
////    if (newString) return newString;
////    return @"";
//
//}

//- 把NSData 转换成 string -
- (NSString *)hexadecimalDescription
{
    if ([self length]==0) return nil;
    
    NSMutableString *string = [NSMutableString stringWithCapacity:[self length] * 2];
    const uint8_t *bytes = [self bytes];
    
    for (int i = 0; i < [self length]; i++)
        [string appendFormat:@"%02x", (uint32_t)bytes[i]];
    
    return [string copy];
}


@end

#pragma mark - NSString扩展
@implementation NSString(JY_FoundationAdditions)

+(BOOL) isEmpty:(NSString*)str
{
    return !str || [str length]==0 || [@"(null)" isEqual:str] || [@"null" isEqualToString:str];
}

-(int) indexInList:(NSArray*) slist
{

    for (int i=0; i<[slist count]; i++) {
        if ([self isEqualToString:[slist objectAtIndex:i]]) {
            return i;
        }
    }
    
    return 0;
}

-(NSDate*) dateValue:(NSString*)dFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat :dFormat];
    
    NSDate *date = [dateFormatter dateFromString:self];

    return date?:[NSDate date];
}

-(NSDictionary*) jsonObject
{
    NSError *e;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&e];
    
//    if (e) NSLog(@"JSON Error:%@",[e userInfo] );
    return [NSJSONSerialization isValidJSONObject:dict]?dict:nil;
}

-(NSArray*) jsonArray
{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *e;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&e];
    
//    if (e) NSLog(@"JSON Error:%@",[e userInfo] );
    
    return [NSJSONSerialization isValidJSONObject:array]?array:nil;
}

-(NSDictionary*) httpDic
{
    NSArray *array=[self componentsSeparatedByString:@"&"];
    if (array && [array count]>0) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
        for (int i=0; i<[array count]; i++) {
            NSString *strkv=[array objectAtIndex:i];
            NSArray *kv=[strkv componentsSeparatedByString:@"="];
            if ([kv count]==2) {
                [dic setObject:[kv objectAtIndex:1] forKey:[kv objectAtIndex:0]];
            }
        }
        return [dic copy];
    } else {
        return nil;
    }
}

-(NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


-(NSString*) sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

+(NSString*) randomString:(int)num {
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return string;
}

- (NSString *)reversedString
{
    NSUInteger count = [self length];
    
    if (count <= 1) { // Base Case
        return self;
    } else {
        NSString *lastLetter = [self substringWithRange:NSMakeRange(count - 1, 1)];
        NSString *butLastLetter = [self substringToIndex:count - 1];
        return [lastLetter stringByAppendingString:[butLastLetter reversedString]];
    }
}


- (NSString *) URLEncodedString_ch
{
    NSMutableString * output = [NSMutableString string];
    const unsigned char * source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

-(NSString*) formatDateInLong:(float)timesec
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timesec];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:self];
    
    return  [format stringFromDate:date];
}

-(void) drawAtX:(float)x Y:(float)y withFont:font align:(int)align
{
    CGPoint pt;
    CGSize size= [self sizeWithFont:font];;
    switch (align) {
            
        case 0: //水平中心
            pt=CGPointMake(x-size.width/2, y-size.height/2); break;
        case 1: //水平常规左上
            pt=CGPointMake(x, y); break;
        case 2: //水平常规中上
            pt=CGPointMake(x-size.width/2, y); break;
        case 3: //水平右上
            pt=CGPointMake(x-size.width, y); break;
        case 4: //水平左中
            pt=CGPointMake(x,y-size.height/2); break;
        case 5: //水平右中
            pt=CGPointMake(x-size.width,y-size.height/2); break;
        case 6: //水平左下
            pt=CGPointMake(x,y-size.height); break;
        case 7: //水平中下
            pt=CGPointMake(x-size.width/2,y-size.height); break;
        case 8: //水平右下
            pt=CGPointMake(x-size.width,y-size.height); break;
            
        case 10: //垂直中心
            pt=CGPointMake(y-size.width/2, -x-size.height/2); break;
        case 14: //垂直上中
            pt=CGPointMake(y,-x-size.height/2); break;
        case 15: //垂直下中
            pt=CGPointMake(y-size.width,-x-size.height/2); break;
        default:
            break;
    }
    
    if (align>=10) {  //旋转
        CGContextRef context=UIGraphicsGetCurrentContext();

        CGAffineTransform   r   =   CGAffineTransformMakeRotation(M_PI_2);
        CGContextConcatCTM(context, r);
        [self drawAtPoint:pt withFont:font];
        CGContextConcatCTM(context, CGAffineTransformInvert(r));
        
    } else {
        [self drawAtPoint:pt withFont:font];
    }
}
@end

#pragma mark - NSArray扩展
@implementation NSArray (JY_FoundationAdditions)

// 稀疏表操作
-(id) objectAtCheckedIndex:(NSUInteger) index
{
    if(index >= self.count) {
        return nil;
    } else {
        id result =  [self objectAtIndex:index];
        return result == [NSNull null] ? nil : result;
    }
}

+ (BOOL) isEmpty:(NSArray*)ary
{
    if (ary ==nil) return YES;
    if (ary == (NSArray*)[NSNull null]) return YES;
    if ([ary count]==0) return YES;
    
    return NO;
}

@end

// 稀疏表操作
@implementation NSMutableArray (JY_FoundationAdditions)

-(void) setObject:(id) object atCheckedIndex:(NSUInteger) index {
    NSNull* null = [NSNull null];
    if (!object) {
        object = null;
    }
    
    NSUInteger count = self.count;
    if (index < count) {
        [self replaceObjectAtIndex:index withObject:object];
    } else {
        if (index > count) {
            NSUInteger delta = index - count;
            for (NSUInteger i=0; i<delta;i++) {
                [self addObject:null];
            }
        }
        [self addObject:object];
    }
}

@end

#pragma mark - NSDictionay 扩展
@implementation NSDictionary(JY_FoundationAdditions)
- (NSString*) jsonString
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (jsonData) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    } else {
        NSLog(@"Got an error: %@", error);
    }
    return nil;
}

+ (BOOL) isEmpty:(NSDictionary*)dic
{
    if (dic ==nil) return YES;
    if (dic == (NSDictionary*)[NSNull null]) return YES;
    if (![dic isKindOfClass:[NSDictionary class]]) return YES;
    
    if ([dic count]==0) return YES;
    
    return NO;
}


- (NSData*) httpEncode
{
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in self.allKeys) {
        id v=self[key];
        NSString *value;
        if ([v isKindOfClass:[NSString class]]) {
            value=v;
        } else {
            value=[v stringValue];
        }
        if (value) {
            NSString *encodedValue = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
            [parts addObject:part];
        }
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}

@end

#pragma mark - UIViewController扩展
@implementation UIViewController(JY_FoundationAdditions)

-(BOOL) isInternetAvailable:(BOOL) bPrompt
{
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus != NotReachable) {
        return YES;
    }
    
    //if (bPrompt)  [self.view showToast:PMT_NOINTERNET];
    
    return NO;
}


-(id) pushTo:(NSString*)name withObject:(id)tag andDelegate:(id)delegate
{
    UIViewController *controller = [[NSClassFromString(name) alloc] initWithNibName:name bundle:nil];
    
    if (controller && [controller respondsToSelector:@selector(setTagObject:)]) {
        [controller setTagObject:tag];
    } else {
        //NSLog(@"No setTagObject method");
    }
    
    if (delegate && [controller respondsToSelector:@selector(setDele:)]) { //附加标准代理
        [controller setDele:delegate];
    } else {
        //NSLog(@"No setDelegate method");
    }
    
    [[self navigationController] pushViewController:controller animated:YES];
    
    return controller ;
}

-(id) pushTo:(NSString*)name
{
    UIViewController *controller = [[NSClassFromString(name) alloc] init];
    
    [[self navigationController] pushViewController:controller animated:YES];
    
    return controller ;
}

-(id) pushTo:(NSString*)name showBack:(BOOL) bShow
{
    UIViewController *controller = [[NSClassFromString(name) alloc] init];
    
    if (bShow) [controller setZMBackButton];
    
    [[self navigationController] pushViewController:controller animated:YES];
    
    return controller ;
}


-(id) popUp:(NSString*)name withObject:(id)tag andDelegate:(id)delegate
{
    UIViewController *controller = [[NSClassFromString(name) alloc] initWithNibName:name bundle:nil];
    
    if (tag && [controller respondsToSelector:@selector(setTagObject:)]) {
        [controller setTagObject:tag];
    } else {
        //NSLog(@"No setTagObject method");
    }
    
    if (delegate && [controller respondsToSelector:@selector(setDele:)]) { //附加标准代理
        [controller setDele:delegate];
    } else {
        //NSLog(@"No setDelegate method");
    }
    
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:controller animated:NO];
    return controller;
}

-(id) goNVController:(NSString*)name andObject:(id)tag
{
    UIViewController *controller = [[NSClassFromString(name) alloc] initWithNibName:name bundle:nil ];
    
    if (controller && [controller respondsToSelector:@selector(setTagObject:)]) {
        UINavigationController *nvc_info = [[UINavigationController alloc] initWithRootViewController:controller];
        [nvc_info setNavigationBarHidden:YES];
        [controller setTagObject:tag];
        [[self navigationController] pushViewController:nvc_info animated:YES];
    } else {
        //NSLog(@"No setTagObject method");
    }
    
    return controller ;
}


+(UIViewController*) addController:(NSString*)name toView:(UIView*) v andTag:(id)tag andDelegate:(id)delegate
{
    UIViewController *controller = [[NSClassFromString(name) alloc] initWithNibName:name bundle:nil];
    
    if (controller) {
        if (tag && [controller respondsToSelector:@selector(setTagObject:)]) { // 附加数据
            [controller setTagObject:tag];
        } else {
        }
        
        if (delegate && [controller respondsToSelector:@selector(setDele:)]) { //附加标准代理
            [controller setDele:delegate];
        } else {
        }
        
        [v addSubview:controller.view];
        return controller ;
    } else {
        return nil;
    }
}

+(void) addNVController:(NSString*)name toView:(UIView*) v andTag:(id)tag andDelegate:(id)delegate
{
    UIViewController *controller = [[NSClassFromString(name) alloc] initWithNibName:name bundle:nil];
    
    if (controller) {
        UINavigationController *nvc_info = [[UINavigationController alloc] initWithRootViewController:controller];
        [nvc_info setNavigationBarHidden:YES];
        if (tag && [controller respondsToSelector:@selector(setTagObject:)]) { // 附加数据
            [controller setTagObject:tag];
        } else {
        }
        
        if (delegate) {
            if (tag && [controller respondsToSelector:@selector(setDele:)]) { //附加标准代理
                [controller setDele:delegate];
            } else {
            }
        }
        
        [v addSubview:nvc_info.view];
    }
}

-(void) _go_back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) setTagObject:(id)tag{}

-(void) setDele:(id)delegate{}

- (void) setupTitleBar:(int)smode
{
    if (iOS7) self.edgesForExtendedLayout = UIRectEdgeNone;
//    [self.navigationItem setHidesBackButton:YES];
//    
//    if (smode==0) { //show backbutton
//        UIButton *btn_left=[UIButton buttonWithType:UIButtonTypeCustom];
//        [btn_left setFrame:CGRectMake(0,0,54.0,44.0)];
//        [btn_left setImage:[UIImage imageNamed:BG_BUTTON_BACK1] forState:UIControlStateNormal];
//        [btn_left setImage:[UIImage imageNamed:BG_BUTTON_BACK2] forState:UIControlStateHighlighted];
//        [btn_left addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [btn_left setExclusiveTouch:YES];
//        
//        UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 54, 44)];
//        [v addSubview:btn_left];
//        
//        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:v]];
//    }
//    
//    UILabel *lb_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160.0, 44.0f)];
//    [lb_title setTextColor:ZMCOLOR_MAIN_FOREGROUND];
//    [lb_title setFont:[UIFont boldSystemFontOfSize:20.0f]];
//    [lb_title setBackgroundColor:[UIColor clearColor]];
//    [lb_title setTextAlignment:NSTextAlignmentCenter];
//    [lb_title setTag:200];
//    [lb_title setCenter:CGPointMake(160.0f, 22.0f)];
//    
//    [self.navigationItem setTitleView:lb_title];
}

-(void) setZMBackButton
{
    [self.navigationItem setHidesBackButton:YES];
    
    UIButton *btn_back=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn_back setFrame:CGRectMake(0, 0, 40.0, 44.0)];
    [btn_back setBackgroundImage:[UIImage imageNamed:BG_BUTTON_BACK1] forState:UIControlStateNormal];
    [btn_back setBackgroundImage:[UIImage imageNamed:BG_BUTTON_BACK2] forState:UIControlStateHighlighted];
    [btn_back addTarget:self action:@selector(_go_back) forControlEvents:UIControlEventTouchUpInside];
    [btn_back setExclusiveTouch:YES];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn_back];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

- (UIButton*) setZMRightButton:(NSString *)image1 andImage2:(NSString*)image2 withSEL:(SEL)onClick
{
    //    [self.navigationItem setHidesBackButton:YES];
    UIButton *btn_right=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn_right setFrame:CGRectMake(0, 0, 40.0, 44.0)];
    [btn_right setBackgroundImage:[UIImage imageNamed:image1 ] forState:UIControlStateNormal];
    [btn_right setBackgroundImage:[UIImage imageNamed:image2 ] forState:UIControlStateHighlighted];
    [btn_right setBackgroundImage:[UIImage imageNamed:image2 ] forState:UIControlStateSelected];
    
    [btn_right addTarget:self action:onClick forControlEvents:UIControlEventTouchUpInside];
    [btn_right setExclusiveTouch:YES];
    
//    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [v addSubview:btn_right];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:btn_right]];
    return btn_right;
}


-(void) setZMBackGround
{
    UIImageView *v_bg = [[UIImageView alloc] initWithFrame:self.view.frame];
    [v_bg setImage:[UIImage imageNamed:BG_IMG_NORMAL_PAGE]];
    [self.view addSubview:v_bg];
    [self.view sendSubviewToBack:v_bg];
}

@end

#pragma mark - UIButton扩展
@implementation UIButton (JY_FoundationAdditions)
static char const * const ZM_OBJTAG_KEY = "ZM_ObjectTag";

//@dynamic tagObject;

-(void)setObjectTag:(NSObject *) tag
{
    objc_setAssociatedObject(self, ZM_OBJTAG_KEY, tag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSObject*) objectTag
{
    return (NSObject*)objc_getAssociatedObject(self, ZM_OBJTAG_KEY);
}

@end


#pragma mark - UIScrollView扩展
@implementation UIScrollView(JY_FoundationAdditions)
- (float) addView:(UIView*)view atX:(float)x andY:(float)y
{
    [view setFrame:CGRectMake(x, y, view.frame.size.width, view.frame.size.height)];
    [self addSubview:view];
    return view.frame.size.height;
}

@end

#pragma mark - UIView扩展
@implementation UIView(JY_FoundationAdditions)

- (void) removeAllSubview
{
    for (NSObject *v in self.subviews) {
        if ([v isKindOfClass:[UIView class]]) {
            [(UIView *)v removeFromSuperview];
        }
    }
}

- (void) moveToX:(float)x andY:(float)y
{
    [self setFrame:CGRectMake(x, y, self.frame.size.width, self.frame.size.height)];
}

- (void) moveY:(float)y
{
    CGRect rect= CGRectMake(self.frame.origin.x,self.frame.origin.y+y, self.frame.size.width, self.frame.size.height);
    [self setFrame:rect];
}

- (void) moveAniToX:(float)x andY:(float)y
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [self setFrame:CGRectMake(x, y, self.frame.size.width, self.frame.size.height)];
    [UIView commitAnimations];
}

+(UIImage *) imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end

#pragma mark - UIImageView 扩展
@implementation UIImageView(JY_FoundationAdditions)
- (void)setImageWithUrl:(NSString *)url andHolder:(NSString*)holder
{

    
}

@end

#pragma mark - UITableView 扩展
@implementation UITableView(JY_FoundationAdditions)
- (void)setBottomMargin
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 40.0f, 0);
    self.contentInset = insets; //something like margin for content;
    self.scrollIndicatorInsets = insets; // and for scroll indicator (scroll bar)
}

@end

#pragma mark - UIColor 扩展
@implementation UIColor(JY_FoundationAdditions)
+ (UIColor *) colorWithStr: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])    cString = [cString substringFromIndex:2];
        if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
        if ([cString length] != 6) return [UIColor blackColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
    
    
}

+ (UIColor *) colorMainBlue
{
    return [UIColor colorWithStr:@"2FBECD"];
}


+ (UIColor *) stockRed
{
    return [UIColor colorWithRed:219.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1.0];
}

+ (UIColor *) stockGreen
{
    return [UIColor colorWithRed:12.0/255.0 green:151.0/255.0 blue:22.0f/255.0 alpha:1.0];
}

@end


#pragma mark - NSDate 扩展
@implementation NSDate(JY_FoundationAdditions)
- (NSString*) stringValue:(NSString*)dFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat :dFormat];
    
    return [dateFormatter stringFromDate:self];
}

+ (NSString*) stringNow:(NSString*)dFormat
{
    return [[NSDate date] stringValue:dFormat];
}

+ (int) daysFromNow:(NSString*)date format:(NSString*)dFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat :dFormat];
    
    NSDate *d=[dateFormatter dateFromString:date];

    return [d timeIntervalSinceNow]/86400;
    
}

@end

#pragma mark - ZM Default 抓米设置方法
@implementation ZM_Default

+(NSObject*) get:(NSString *) key;
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:key];
}

+(NSNumber*) getNumber:(NSString *) key;
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:key];
}

+(int) getInt:(NSString *) key;
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [[userDefault objectForKey:key] intValue];
}

+(NSString*) getString:(NSString *) key;
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:key];
}

+(void) saveString:(NSString *)value forKey:(NSString*) key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:value forKey:key];
    [userDefault synchronize];
}

+(void) saveInt:(int)value forKey:(NSString*) key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:@(value) forKey:key];
    [userDefault synchronize];
}

+(void) saveNumber:(NSNumber*) value forKey:(NSString*) key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:value forKey:key];
    [userDefault synchronize];
}


+(void) save:(NSDictionary*)dic
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    for (NSString* key in [dic allKeys]) {
        [userDefault setObject:dic[key] forKey:key];
    }
    
    [userDefault synchronize];
}

+(void) save:(NSObject*) value forKey:(NSString*) key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:value forKey:key];
    [userDefault synchronize];
}

+(void) remove:(NSArray *) keys
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    for (NSString* key in keys) {
        [userDefault removeObjectForKey:key];
    }
    
    [userDefault synchronize];
}

+(void) removeOne:(NSString*) key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:key];
    [userDefault synchronize];
}

@end

/*
 推送通知注册
 */
static NSString *const URL_SD_NOTIFY_REG = @"http://sd2.zhuami.info:7189/pushManager/saveToken.html";

#pragma mark - ZM 通知
@implementation ZM_NotifyHelper

+(void) regNotify:(NSString*)token;
{
    [[[ZM_NotifyHelper alloc] init] reg:token];
}

-(void) saveResult:(NSString*)result
{
    
}

-(void) reg:(NSString*)token
{
    //    UIDevice *device     = [UIDevice currentDevice];
    //    NSString *osStr      = [NSString stringWithFormat:@"%@",[device systemVersion]];
    //    float v = [osStr floatValue];
    
    NSURL* url = [NSURL URLWithString:URL_SD_NOTIFY_REG];
    
    NSData *data = [[NSDictionary dictionaryWithObjectsAndKeys:
                     [JY_Helper uid:SD_UUID_USER], @"tsUserID",
                     token, @"token",
                     nil] httpEncode];
    
	NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    //    NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    //    [urlConn start];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Peform the request
        NSURLResponse *response;
        NSError *error = nil;
        NSData *receivedData = [NSURLConnection sendSynchronousRequest:request
                                                     returningResponse:&response
                                                                 error:&error];
        if (error) { // Deal with your error
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                NSLog(@"HTTP Error: %d %@", httpResponse.statusCode, error);
                return;
            }
            NSLog(@"Error %@", error);
            return;
        }
        
        NSString *responeString = [[NSString alloc] initWithData:receivedData
                                                        encoding:NSUTF8StringEncoding];
        
        [self saveResult:responeString];
        
    });
}

@end


#pragma mark - ZM Helper 抓米实用方法
@implementation JY_Helper

+ (NSString *) getWeekString:(NSString *) stringYMD
{
    static NSString *sWeekday[7] ={@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"};
    
    @try {
        NSArray *dateArray = [stringYMD componentsSeparatedByString:@"-"];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        
        [comps setDay:  [[dateArray objectAtIndex:2] intValue]];
        [comps setMonth:[[dateArray objectAtIndex:1] intValue]];
        [comps setYear: [[dateArray objectAtIndex:0] intValue]];
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *date = [gregorian dateFromComponents:comps];
        NSDateComponents *weekdayComponents =
        [gregorian components:NSWeekdayCalendarUnit fromDate:date];
        int weekday = [weekdayComponents weekday];
        return sWeekday[weekday-1];
        
    } @catch (NSException *exception) {
    } @finally {
    }
    return @"";
    
}

+ (float) largerValue:(float) v1 and:(float)v2
{
    if (v2<0) {
        if (v1>(-v2)) {
            return v1;
        } else {
            return -v2;
        }
    } else {
        if (v1>v2) {
            return v1;
        } else {
            return v2;
        }
    }
}

+ (float) smallerValue:(float) v1 and:(float)v2
{
    if (v2<0) {
        if (v1<(-v2)) {
            return v1;
        } else {
            return -v2;
        }
    } else {
        if (v1<v2) {
            return v1;
        } else {
            return v2;
        }
    }
    
    
}

+ (id) loadNib:(NSString*) nibName atIndex:(int)index
{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] objectAtIndex:index];
}


+(UIAlertView*) showAlert:(NSString*)title message:(NSString*)message
{
    return [JY_Helper showAlert:title message:message withID:0 andDelegate:nil];
}

+(UIAlertView*) showAlert:(NSString*)title message:(NSString*)message withID:(int)aid andDelegate:(id<UIAlertViewDelegate>)dele
{
    UIAlertView * alertView;
    if (aid>0) {
        alertView = [[UIAlertView alloc] initWithTitle:title
                                               message:message
                                              delegate:nil
                                     cancelButtonTitle:@"取消"
                                     otherButtonTitles:@"确定",nil];
        [alertView setTag:aid];
    } else {
        alertView = [[UIAlertView alloc] initWithTitle:title
                                               message:message
                                              delegate:nil
                                     cancelButtonTitle:@"确定"
                                     otherButtonTitles:nil];
    }
    [alertView setDelegate:dele];
    [alertView show];
    return  alertView;
}

+(NSString*) fakeIMEI
{
    return [JY_Helper uid:SD_UUID_DEVICE];
}

+(NSString*) appID;
{
    return @"1005";
}

+(NSString*) channel;
{
    return @"ZhuamiInfo";
}

+(long) setTimeMargin:(NSDate*)serverDate
{
    NSTimeInterval time = [serverDate timeIntervalSinceNow] ;
    
    long timemargin = [[NSNumber numberWithDouble:time] longValue];
    
    [ZM_Default saveInt:timemargin forKey:PKEY_TIME_MARGIN];
    NSLog(@"server time margin:%ld",timemargin);
    
    return timemargin;
}

#define KS_KEY_PREFIX @"keychain-item"

+ (NSString *) uid:(NSString *)idkey {
	NSUserDefaults *handler = [NSUserDefaults standardUserDefaults];
    NSString *uid=[handler objectForKey:idkey];
	if (!uid || [uid length] < 36) { //不在Default,生成id
        NSString *skey=[NSString stringWithFormat:@"%@-%@",KS_KEY_PREFIX,idkey];
//        uid= [SFHFKeychainUtils getPasswordForUsername:skey
//                                        andServiceName:skey
//                                                 error:nil];
        
        if (!uid || [uid length] < 36) { // 也不在 Keychain
            CFUUIDRef uuid = CFUUIDCreate(NULL);
            CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
            
            uid = [NSString stringWithFormat:@"%@", uuidStr];
//            [SFHFKeychainUtils storeUsername:skey
//                                 andPassword:uid
//                              forServiceName:skey
//                              updateExisting:YES
//                                       error:nil];
            
            CFRelease(uuidStr);
            CFRelease(uuid);
            
        } // 在keychain 保存为default
        
        [handler setObject:uid forKey:idkey];
        [handler synchronize];
	}
    
	return uid;
}

+(BOOL) isZMNotNull:(NSObject*)obj
{
    if (obj==nil)  return FALSE;

    if ([obj isKindOfClass:[NSNumber class]]) {
        
    } else if ([obj isKindOfClass:[NSDictionary class]]) {
        return ([(NSDictionary*)obj count]>0);
    } else {
        
    }
    
    return TRUE;
}

+(BOOL) isZMResultOK:(NSString*)str
{
    if (!str || [str length]==0) return NO;
    NSDictionary *json=[str jsonObject];
    if (!json) return NO;

    return [JVAL_RESULT_OK isEqualToString:[json[JKEY_RESULT] uppercaseString] ];
}

+(NSString*) format:(float)value withtype:(int)ftype
{
    NSString *result=@"";
    switch (ftype) {
        case 0: //保留两位
            return [NSString stringWithFormat:@"%.2f",value];
            break;
        case 1: //带百分号
            return [NSString stringWithFormat:@"%.2f%%",value];
            break;
        case 2: //万，亿
            if (value >1000000000) {
                return [NSString stringWithFormat:@"%.1f亿",value/100000000];
            } else if (value >100000) {
                return [NSString stringWithFormat:@"%.1f万",value/10000];
            } else {
                return [NSString stringWithFormat:@"%.f",value];
            }
            
            break;
        case 3: //手
            return [NSString stringWithFormat:@"%.f手",value];
            break;
        case 4: { //最多保留两位
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.numberStyle = kCFNumberFormatterNoStyle;//这个就是上面的枚举类型对应的值
            [formatter setPositiveFormat:@"###0.##"];
            [formatter setMaximumFractionDigits:2];
            return [formatter stringFromNumber:@(value)];
            break;}

            
        default:
            break;
    }
    return result;
    
}



@end
