//
//  ContentVC.m
//  slearning
//
//  Created by YanJH on 14-9-30.
//  Copyright (c) 2014年 cn.yanjh. All rights reserved.
//

#import "LessonVC.h"
#import "AppController.h"
#import "AsyncImageView.h"
#import <MediaPlayer/MediaPlayer.h>

#pragma mark - 普通课堂控制器，普通滚动视图
@interface LessonVC ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *sv_content;
@property (strong,nonatomic) JY_Lesson *mLesson;
@property (assign) float cy;
@end

@implementation LessonVC
-(void) setLesson:(JY_Lesson*)lesson
{
    if (lesson) {
        self.mLesson= lesson;
    }
    
    self.cy=0;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.cy==0) {
        [self loadContent];
    }

    [self.sv_content setContentSize: CGSizeMake(self.sv_content.frame.size.width,self.cy)];
    
}

- (IBAction)do_back:(UIButton *)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) loadContent
{
    if (!self.mLesson.content || self.mLesson.content.length==0) return;

    NSDictionary *dic_content=[self.mLesson.content jsonObject];
    NSArray *ary_content=dic_content[@"content"];
    LessonItem *lv;
    
    int y=10;
    
    for (NSDictionary *item in ary_content) {
        lv=[[LessonItem alloc] initWithData:item andWidth:self.sv_content.frame.size.width-20];
        [self.sv_content addSubview:lv];

        [lv moveToX:10 andY:y];
        
        y+=lv.frame.size.height+10;
    }
    
    self.cy=y;
}

@end

#pragma mark - 课堂页面控制器
@interface LessonPageVC ()<UIScrollViewDelegate>

@property (retain,nonatomic) NSMutableArray *mAryContentViews;
@property (strong,nonatomic) LessonPage *lp_current;

@property (strong, nonatomic) IBOutlet UIScrollView *sv_content;
@property (strong, nonatomic) IBOutlet UIView *tbar,*bbar;

@end

@implementation LessonPageVC

//-(id) init
//{
//    self=[super init]
//}
-(void) setMData:(id)data
{
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        self.mAryContentViews =[data[@"data"] mutableCopy];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tbar setHidden:YES];
    [self.bbar setHidden:YES];
    
    // Do any additional setup after loading the view.

}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.sv_content setContentSize: CGSizeMake(self.sv_content.frame.size.width * self.mAryContentViews.count,self.sv_content.frame.size.height)];
    
    [self showPage:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)do_back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadContentAt:(int)page //为滚动视图加载内容视图
{
    if (page < 0 || page >= self.mAryContentViews.count) return;
    
    // replace the placeholder if necessary
    LessonPage *cv;
    NSObject *o = self.mAryContentViews[page];
    if ([o isKindOfClass:[NSDictionary class]]) { //还没有视图
        cv = [[LessonPage alloc] initWithData:(NSDictionary*)o];
        cv.tag=page;
        [self.mAryContentViews replaceObjectAtIndex:page withObject:cv];
    } else {
        cv=(LessonPage*)o;
    }
    
    // add the controller's view to the scroll view
    if (cv.superview == nil) { //还未添加视图
        CGRect frame = self.sv_content.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        
        cv.frame = frame;
        [self.sv_content addSubview:cv];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
//    if (pageControlUsed)
//    {
//        // do nothing - the scroll was initiated from the page control, not the user dragging
//        return;
//    }
    
    // Switch the indicator when more than 50% of the previous/next page is visible
//    CGFloat pageWidth = sender.frame.size.width;
//    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
////    pageControl.currentPage = page;
//    
//    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
//    [self loadContentAt:page-1];
//    [self loadContentAt:page];
//    [self loadContentAt:page+1];
//    
//    [self showPage:page];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    scrollView.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //Run your code on the current page
    scrollView.userInteractionEnabled = YES;
    
    CGFloat pageWidth = scrollView.frame.size.width;
    
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self showPage:page];
}

-(void) showPage:(int) page
{
    [self loadContentAt:page];
    
    if (!self.lp_current) { //
        self.lp_current = self.mAryContentViews[page];
        [self.lp_current show:YES];
    } else {
        if (self.lp_current.tag!=page) { //变换页面
            [self.lp_current show:NO];
            self.lp_current = self.mAryContentViews[page];
            [self.lp_current show:YES];
        }
    }
    
    //加载前后页面
    [self loadContentAt:page-1];
    [self loadContentAt:page+1];
}
- (IBAction)do_go_prev:(UIButton *)sender {
    [self goPage:-2];
}
- (IBAction)do_go_next:(UIButton *)sender {
    [self goPage:-1];
}

-(void) goPage:(int) page
{
    if (page>=(int)self.mAryContentViews.count || page<(-2)) return;

    int p=self.lp_current.tag;
    
    if (page==-1) { //向后
        [self goPage:p+1];
    } else if (page==-2) { // 向前
        if (p==0) return;
        [self goPage:p-1];
    } else {
        [self.sv_content setContentOffset:CGPointMake(self.sv_content.frame.size.width*page, 0) animated:YES];
        [self showPage:page];
    }
}


@end

#pragma mark - 内容页面视图

@interface LessonPage()
@property (retain,nonatomic) NSDictionary *mData;

@property (nonatomic,retain) MPMoviePlayerController *mpc_content;
@property (nonatomic,retain) UIWebView *wv_content;
@end

@implementation LessonPage

-(instancetype) initWithData:(NSDictionary*) data
{
    self= [[LessonPage alloc] initWithFrame:CGRectZero];
    //self =[[NSBundle mainBundle] loadNibNamed:@"Content" owner:self options:nil][0];
    if (self) {
        [self setMData:data];
    }
    return self;
}

-(void) show:(BOOL)bShow
{
    if (bShow) {
        [self setPageContent:self.mData];
        if (self.mpc_content) {
            [self.mpc_content play];
            NSLog(@"begin play:%@",self.mpc_content.contentURL);
        }
        
        if (self.wv_content) {
            [self.wv_content loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.mData[DKEY_CONTENT]]]];
        }
    } else {
        if (self.mpc_content) {
            [self.mpc_content stop];
            NSLog(@"end play:%@",self.mpc_content.contentURL);
        }
    }
}

-(void) setPageContent:(NSDictionary*)content
{
    NSString *mtype=content[DKEY_TYPE];
    NSString *path= @"http://192.168.0.102/course/1/";
    int no=[content[DKEY_ID] intValue];
    NSString *sno;
    if (no<10) {
        sno=[NSString stringWithFormat:@"00%i",no];
    } else if (no<100) {
        sno=[NSString stringWithFormat:@"0%i",no];
    } else {
        sno=[NSString stringWithFormat:@"%i",no];
    }
    
    if ([mtype rangeOfString:@"P"].location != NSNotFound) { //带图片
        UIImageView *iv= (UIImageView*)[self viewWithTag:1001];
        if (!iv) {
            iv=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width,self.frame.size.height)];
            [iv setTag:1001];
            [self addSubview:iv];
            [self sendSubviewToBack:iv];
        }
        
        iv.imageURL= [NSURL URLWithString:[NSString stringWithFormat:@"%@%@.jpg",path,sno]];
    }
    
    if ([mtype rangeOfString:@"T"].location != NSNotFound) { //带图片
        UILabel *lb= (UILabel*)[self viewWithTag:1011];
        if (!lb) {
            lb= [[UILabel alloc] initWithFrame:CGRectMake(4, self.frame.size.height-44, self.frame.size.width-8, 40)];
            [lb setTextAlignment:NSTextAlignmentCenter];
            [lb setBackgroundColor:[UIColor yellowColor]];
            [lb setTextColor:[UIColor blackColor]];
            [lb setTag:1011];
            
            [self addSubview:lb];
            [self bringSubviewToFront:lb];
        }
        [lb setText:content[@"content"]];
    }
    
    if ([mtype rangeOfString:@"A"].location != NSNotFound) { //带音频
        if (!self.mpc_content && content[DKEY_CONTENT]) {
            self.mpc_content = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.mp3",path,sno]]];
            [self.mpc_content.view setFrame:CGRectZero];
            [self.mpc_content.view setHidden:YES];
            [self addSubview:self.mpc_content.view];
        }
    }
    
    if ([mtype rangeOfString:@"V"].location != NSNotFound) { //带视频
        if (!self.mpc_content && content[DKEY_CONTENT]) { //外部视频
            self.mpc_content = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.mp4",path,sno]]];
            [self.mpc_content.view setFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height) ];
            self.mpc_content.controlStyle=MPMovieControlStyleDefault;
            [self addSubview:self.mpc_content.view];
            [self sendSubviewToBack:self.mpc_content.view];
        } else { //默认视频
            
        }
    }
    
    if ([mtype contain:@"W"]) { //WebView
        if (content[DKEY_CONTENT]) { //外部视频
            self.wv_content=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];

            [self addSubview:self.wv_content];
            [self sendSubviewToBack:self.wv_content];
        } else { //默认视频
            
        }
    }
    
}

@end

#pragma mark - 普通内容面板

@interface LessonItem()
@property (retain,nonatomic) NSDictionary* mData;
@property (assign) int mWidth,mHeight;

@end
@implementation LessonItem

-(instancetype) initWithData:(NSDictionary*) data andWidth:(float)width;
{
    self= [super initWithFrame:CGRectZero];
    if (self) {
        self.mData=data;
        self.mWidth=width;
        [self setViews];
    }
    return self;
}

-(void) setViews
{
    UILabel *lb; UIButton *bt;
    CGSize strSize = CGSizeZero;
    int y=5;
    int dtype=[self.mData[@"type"] intValue];
    
    // title
    NSString *title=self.mData[@"title"];
    
    lb = [[UILabel alloc] initWithFrame:CGRectMake(5, y, self.mWidth-10, 40)];
    [lb setBackgroundColor:[UIColor clearColor]];
    [lb setFont:FONT_STD_TITLE];
    [lb setTextColor:[UIColor blackColor]];
    [lb setNumberOfLines:1];
    [lb setText:title];
    
    [self addSubview:lb];
    y+=40+5;
    
    //content
    NSString *content=self.mData[@"content"];
    
    if (dtype==0) {
        content = [content stringByReplacingOccurrencesOfString:TRI_SPACE withString:@"\n"];
        strSize = [content sizeWithFont:FONT_STD_CONTENT constrainedToSize:CGSizeMake(self.mWidth,400)];
        
        lb = [[UILabel alloc] initWithFrame:CGRectMake(5, y,self.mWidth-10,strSize.height)];
        [lb setBackgroundColor:[UIColor clearColor]];
        [lb setFont:FONT_STD_CONTENT];
        [lb setTextColor:[UIColor blueColor]];
        [lb setNumberOfLines:0];
        [lb setLineBreakMode:NSLineBreakByWordWrapping];
        [lb setText:content];
        
        [self addSubview:lb];
        
        y+=strSize.height;
        
        y+=5;
    } else if (dtype==1) { //附件,逗号分割
        content = [content stringByReplacingOccurrencesOfString:TRI_SPACE withString:@""];
        NSArray *list=[content componentsSeparatedByString:@","];
        
        
        
    } else if (dtype==2) { //链接
        content = [content stringByReplacingOccurrencesOfString:TRI_SPACE withString:@""];
        NSArray *list=[content componentsSeparatedByString:@","];
        for (int i=0,count=list.count; i<count; i++) {
            NSString *text=list[i];
            NSString *link=list[i+1];
            
            bt=[[UIButton alloc] initWithFrame:CGRectMake(5, y, 200, 40)];
            [bt setTitle:text forState:UIControlStateNormal];
            [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [bt setBackgroundColor:[UIColor blueColor]];
            
            [bt setTag:i];
            [bt setObjectTag:link];
            
            [bt addTarget:self
                   action:@selector(do_link:)
         forControlEvents:UIControlEventTouchUpInside];
         
            [self addSubview:bt];
            
            y+=45;
            i++;
        }
        
    } else if (dtype==11) { //单选题
        
    }

    // 视图设置
    [self setFrame:CGRectMake(0, 0, self.mWidth, y)];
    [self setBackgroundColor:[UIColor yellowColor]];
    [self setTag:[self.mData[@"id"] intValue]];
    self.mHeight = y;
}

-(void) do_link:(UIButton*)sender
{
    NSString *link=(NSString*)[sender objectTag];
    if (link) {
        if ([link rangeOfString:@"http"].location==NSNotFound) {
            link=[NSString stringWithFormat:@"http://%@",link];
        }
        
        NSLog(@"link:%@",link);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
    }
}

-(void) drawRect:(CGRect)rect
{
//    int dtype=[self.mData[@"type"] intValue];
////    if (dtype==0) {
//        NSString *text=self.mData[@"title"];
//        if (text && text.length>0) {
//            [text drawAtX:5 Y:5 withFont:[UIFont systemFontOfSize:14.0] align:1];
//        }
//        
////    }
}

@end

