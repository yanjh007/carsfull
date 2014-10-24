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
@property (assign) int vtag;
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

- (IBAction)do_save:(UIButton *)sender {
    UIView *v;
    NSMutableArray *feedback=[NSMutableArray new];
    NSDictionary *item;
    
    for (int i=501;i<600;i++) {
        v=[self.sv_content viewWithTag:i];
        if (!v) break;
        if ([v isKindOfClass:[LessonItem class]]) {
            item=[(LessonItem*)v getResult];
            if (item)[feedback addObject:item];
        }
    }
   
    if (feedback.count>0) {
        [self.mLesson saveFeedback:[feedback copy]];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) loadContent
{
    if (!self.mLesson.content || self.mLesson.content.length==0) return;

    NSDictionary *dic_content=[self.mLesson.content jsonObject];
    NSArray *ary_content=dic_content[@"content"];
    
    NSArray *ary_answer=[self.mLesson.answer jsonArray];
    
    int y=10,itag=501;
    LessonItem *lv; NSString* sanswer;
    for (NSDictionary *item in ary_content) {
        
        for (NSDictionary *aitem in ary_answer){
            sanswer=@"";
            if ([aitem[@"qorder"] intValue]==[item[@"qorder"] intValue]) {
                sanswer=aitem[@"answer"];
                break;
            }
        }
        
        lv=[[LessonItem alloc] initWithData:
                @{@"content":item,
                  @"answer":sanswer,
                  @"width":@(self.sv_content.frame.size.width-20)
                  }];
 
        if ([item[@"qtype"]intValue]!=10) {
            [lv setTag:itag];
            itag++;
        }
        
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
@property (retain,nonatomic) AnswerPanel* mAnswerPanel;
@property (retain,nonatomic) NSDictionary* mQuestion;
@property (retain,nonatomic) NSString *mAnswer,*rAnswer; //答案和参考
@property (assign) int mWidth,mHeight,qtype,qcount,qid; //视图宽度，高度，类型，选项数量，问题id(order)

@end
@implementation LessonItem

-(instancetype) initWithData:(NSDictionary*)data
{
    self= [super initWithFrame:CGRectZero];
    if (self) {
        self.mQuestion =data[@"content"];
        self.mAnswer   =data[@"answer"];
        self.mWidth    =[data[@"width"]floatValue];
        
        [self setViews];
    }
    return self;
}

-(void) setViews
{
    self.qid    =[self.mQuestion[@"qorder"] intValue];
    self.qtype  =[self.mQuestion[@"qtype"]  intValue];
    
    int y=5;
    // 标题
    y+= [self setTitle:y];
    
    // 内容区域
    y+= [self setContent:y];

    // 选项 附件、链接、单选、多选
    //y+= [self setOption:y];
    
    // 答题区域
    y+= [self setAnswerPanel:y];

    // 视图设置
    [self setFrame:CGRectMake(0, 0, self.mWidth, y)];
    [self setBackgroundColor:[UIColor yellowColor]];
    [self setTag:[self.mQuestion[@"id"] intValue]];
    
    self.mHeight = y+10;
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

}

// 标题区域
-(int)  setTitle:(float) y // 标题
{
    if (self.mQuestion[@"title"]) {
        NSString *title=self.mQuestion[@"title"];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(5, y, self.mWidth-10, 36)];
        [lb setBackgroundColor:[UIColor clearColor]];
        [lb setFont:FONT_STD_TITLE];
        [lb setTextColor:[UIColor blackColor]];
        [lb setNumberOfLines:1];
        [lb setText:title];
        
        [self addSubview:lb];
        return 40;
    } else {
        return 0;
    }

}

// 内容区域

-(float)  setContent:(float) y
{
    if (self.mQuestion[@"content"]) {
        float h=0; UILabel *lb;
        self.rAnswer=@"";
        
        NSString *c=self.mQuestion[@"content"];
        
        NSArray *clist=[c componentsSeparatedByString:QSPLIT_OPTION];
        if (clist.count>0 && clist[0]) { //内容
            NSString *content=clist[0];
            content = [content stringByReplacingOccurrencesOfString:TRI_SPACE withString:@"\n"];
            
            lb = [self textLabel:content width:self.mWidth-10];
            [self addSubview:lb];
            
            h=lb.frame.size.height+5;
        }
        
        if (clist.count>1 && clist[1]) { //选项
            NSString *option=clist[1],*c1,*str;
            NSArray *ary_char=@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H"],*oplist;
            
            NSMutableString *answer=[NSMutableString stringWithString:@""];
            if (self.qtype==QTYPE_SINGLE_SELECT || self.qtype==QTYPE_MULTI_SELECT) { //单选多选 填空
                oplist = [option componentsSeparatedByString:QSPLIT_OPTION_CONTENT];
                self.qcount=oplist.count;

                for (int i=0; i<self.qcount; i++) {
//                    str=oplist[i];
//                    c1=[str substringWithRange:NSMakeRange(i, 1)];
                    str =oplist[i];
                    if ([[str substringToIndex:1] isEqualToString:ANSWER_MARKER_RIGHT]) {
                        [answer appendString:ary_char[i]];
                        str = [str substringFromIndex:1];
                    }
                    
                    str = [NSString stringWithFormat:@"%@. %@",ary_char[i],str];
                    
                    lb = [self textLabel:str width:self.mWidth-10];
                    [lb setFrame:CGRectMake(5, y+h, lb.frame.size.width, lb.frame.size.height)];
                    
                    [self addSubview:lb];
                    
                    h+=lb.frame.size.height+2;
                }
                
                self.rAnswer=[answer copy];
                
            } else if (self.qtype== QTYPE_FILL_BLANK) { //填空
                oplist = [option componentsSeparatedByString:QSPLIT_OPTION_CONTENT];
                self.rAnswer = option;
                self.qcount=oplist.count;
                
            } else if (self.qtype== QTYPE_SIMPLE_ANSWER) { //
                self.qcount=1;
            } else if (self.qtype==1) {
                
            } else if (self.qtype==2) { //链接按钮
                //        content = [content stringByReplacingOccurrencesOfString:TRI_SPACE withString:@""];
                //        NSArray *list=[content componentsSeparatedByString:@","];
                //        for (int i=0,count=list.count; i<count; i++) {
                //            NSString *text=list[i];
                //            NSString *link=list[i+1];
                //
                //            bt=[[UIButton alloc] initWithFrame:CGRectMake(5, y, 200, 40)];
                //            [bt setTitle:text forState:UIControlStateNormal];
                //            [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                //            [bt setBackgroundColor:[UIColor blueColor]];
                //
                //            [bt setTag:i];
                //            [bt setObjectTag:link];
                //
                //            [bt addTarget:self
                //                   action:@selector(do_link:)
                //         forControlEvents:UIControlEventTouchUpInside];
                //         
                //            [self addSubview:bt];
                //            
                //            y+=45;
                //            i++;
                //        }
            }
        }
        return h ;
    } else {
        return 0;
    }
    
}

// 答题区域
-(int)  setAnswerPanel:(float) y // 标题
{
    if (self.qtype == QTYPE_SINGLE_SELECT
        || self.qtype == QTYPE_MULTI_SELECT
        || self.qtype == QTYPE_FILL_BLANK
        || self.qtype == QTYPE_SIMPLE_ANSWER) {
        AnswerPanel *fv=[[AnswerPanel alloc] initWithConfig:@{
                                                          @"vid"     :@(self.qid),
                                                          @"width"   :@(self.mWidth-10),
                                                          @"type"    :@(self.qtype),
                                                          @"answer"  :self.rAnswer,
                                                          @"uanswer" :self.mAnswer,
                                                          @"score"   :self.mQuestion[@"score"]?self.mQuestion[@"score"]:@(1),
                                                          @"count"   :@(self.qcount)
                                                          }];
        
        [fv setFrame:CGRectMake(5, y, fv.frame.size.width, fv.frame.size.height)];
        self.mAnswerPanel=fv;
        
        [self addSubview:fv];
        return fv.frame.size.height+5;
        
    } else {
        return 0;
    }
}

-(UILabel*) textLabel:(NSString*)content width:(float)width
{
    content = [content stringByReplacingOccurrencesOfString:TRI_SPACE withString:@"\n"]; //换行
    CGSize strSize = [content sizeWithFont:FONT_STD_CONTENT constrainedToSize:CGSizeMake(width,400)];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,width,strSize.height)];
    [lb setBackgroundColor:[UIColor clearColor]];
    [lb setFont:FONT_STD_CONTENT];
    [lb setTextColor:[UIColor blueColor]];
    [lb setNumberOfLines:0];
    [lb setLineBreakMode:NSLineBreakByWordWrapping];
    [lb setText:content];
    
    return lb;
}


-(NSDictionary*) getResult;
{
    if (self.mAnswerPanel) {
        return [self.mAnswerPanel getResult];
    } else {
        return nil;
    }
}

@end

#pragma mark - 普通测试选项面板
@interface AnswerPanel()
@property (retain,nonatomic) NSDictionary* mConfig;
@property (retain,nonatomic) NSArray  *lheaders;
@property (retain,nonatomic) NSString *vlabel,*vanswer,*uanswer;
@property (assign) int vid,vtype,vcount,vscore,vhight;
@property (retain,nonatomic) UIButton *curItem;

@end

@implementation AnswerPanel

-(instancetype) initWithConfig:(NSDictionary*)cfg
{
    float w=cfg[@"width"]?[cfg[@"width"] floatValue]:240;
    self=[super initWithFrame:CGRectZero];
    
    if (self) {
        self.mConfig = cfg;
//        [self setBackgroundColor:[UIColor redColor]];
        
        self.vid  = cfg[@"vid"]     ?[cfg[@"vid"] intValue]:0;
        self.vtype   = cfg[@"type"]     ?[cfg[@"type"] intValue]:11;
        self.vlabel  = cfg[@"label"]    ? cfg[@"label"] :@"A,B,C,D";
        self.vanswer = cfg[@"answer"]   ? cfg[@"answer"]  :@""; //参考答案
        self.uanswer = cfg[@"uanswer"]  ? cfg[@"uanswer"] :@""; //用户答案
        self.vcount  = cfg[@"count"]    ?[cfg[@"count"] intValue]:1;
        self.vscore  = cfg[@"score"]    ?[cfg[@"score"] intValue]:1;
        
        self.lheaders =[self.vlabel componentsSeparatedByString:@","];
        
        UIButton *bt;
        UILabel *lb;
        UIImageView *iv;
        UITextField *tf;
        UITextView  *tv;
        NSString *iname1,*iname2;
        
        float w1= 50; // w/self.vcount;
        self.vhight=30;
        
        if (self.vtype ==QTYPE_MULTI_SELECT || self.vtype ==QTYPE_SINGLE_SELECT) {
            if (self.vtype==QTYPE_SINGLE_SELECT) {  //单选
                iname1=@"r1"; iname2=@"r2";
            } else if (self.vtype==12) {
                iname1=@"c1"; iname2=@"c2";
            } else {
                
            }
            
            for (int i=0; i<self.vcount; i++) {
                bt=[[UIButton alloc] initWithFrame:CGRectMake(i*w1, 0, w1, self.vhight)];
                lb=[[UILabel alloc]  initWithFrame:CGRectMake(4,0,20,self.vhight)];
                
                [lb setFont:[UIFont systemFontOfSize:14]];
                [lb setText:self.lheaders[i]];
                [bt addSubview:lb];
                
                iv=[[UIImageView alloc] initWithImage  :[UIImage imageNamed:iname1]
                                       highlightedImage:[UIImage imageNamed:iname2]];
                
                [iv setFrame:CGRectMake(16, 2, self.vhight-4, self.vhight-4)];
                [iv setTag:20];
                [bt addSubview:iv];
                
                [bt addTarget:self action:@selector(do_toggle:) forControlEvents:UIControlEventTouchUpInside];
                [bt setTag:100+i];
                
                [self addSubview:bt];
                
                if ([self.uanswer rangeOfString:self.lheaders[i]].length>0) {
                    [bt setSelected:YES];
                    [iv setHighlighted:YES];
                    if (self.vtype==QTYPE_SINGLE_SELECT) {
                        self.curItem=bt;
                    }
                }
            }
            
        } else if (self.vtype==QTYPE_FILL_BLANK) {
            NSArray *alist=[self.uanswer componentsSeparatedByString:QSPLIT_MULTI_BLANK];
            
            for (int i=0;i<self.vcount;i++) {
                // 标题
                lb=[[UILabel alloc]  initWithFrame:CGRectMake(4,self.vhight*i+2,20,self.vhight-4)];
                
                [lb setFont:[UIFont systemFontOfSize:14]];
                [lb setText:self.lheaders[i]];
                [self addSubview:lb];
                
                // 编辑框
                tf=[[UITextField  alloc] initWithFrame:CGRectMake(30,self.vhight*i+2,120, self.vhight-4)];
                [tf setBorderStyle:UITextBorderStyleLine];
                [tf setTag:100+i];
                
                if ([alist count]>i) [tf setText:alist[i]];
                
                [self addSubview:tf];
            }
            
            self.vhight=self.vhight*self.vcount;
        } else if (self.vtype==QTYPE_SIMPLE_ANSWER) {
            tv=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, w, 80)];
            [tv setBackgroundColor:[UIColor lightGrayColor]];
            [tv setTag:100];
            
            [self addSubview:tv];
            
            [tv setText:self.uanswer];
            
            self.vhight=80;
        }
        
        // 位置和大小
        [self setFrame:CGRectMake(0, 0, w, self.vhight)];
    }
    return self;
}


-(void) do_toggle:(UIButton*)sender
{
    if (self.vtype==QTYPE_MULTI_SELECT) { //多选
        [sender setSelected:!sender.isSelected];
        [(UIImageView*)[sender viewWithTag:20] setHighlighted:sender.isSelected];
    } else if (self.vtype==QTYPE_SINGLE_SELECT) { //单选
        if (sender.isSelected) return; //已选择
        if (self.curItem) {
            [self.curItem setSelected:NO];
            [(UIImageView*)[self.curItem viewWithTag:20] setHighlighted:NO];
        }
        
        [sender setSelected:YES];
        [(UIImageView*)[sender viewWithTag:20] setHighlighted:YES];
        
        self.curItem=sender;
    }
}

-(NSDictionary*) getResult
{
    NSString
    *keya=@"answer", //用户答案
    *keyr=@"result", //当前结果 0-未完成 1-错 2-对 3-待批复 4-批复
    *keys=@"score"; // 当前得分

    NSMutableDictionary *dic=[@{
                               @"qorder":@(self.vid),
                               @"type":@(self.vtype),
                               keyr:@(0),
                               keys:@(0)} mutableCopy];
    
    // 客户答案
    NSMutableString *str=[NSMutableString stringWithString:@""];
    NSArray *alist=[self.vanswer componentsSeparatedByString:QSPLIT_OPTION_CONTENT],*l; //填空题答案列表
    int j=0; //正确累计
    if (self.vtype==QTYPE_SIMPLE_ANSWER) {
        dic[keya] =[(UITextView*)[self viewWithTag:100] text];
    } else {
        for (int i=0; i<self.vcount; i++) {
            if (self.vtype==QTYPE_SINGLE_SELECT) { //单选
                if ([((UIButton*)[self viewWithTag:100+i]) isSelected]) {
                    [str appendString:self.lheaders[i]];
                    break;
                }
            } else if (self.vtype==QTYPE_MULTI_SELECT) { //多选
                if ([((UIButton*)[self viewWithTag:100+i]) isSelected]) {
                    [str appendString:self.lheaders[i]];
                }
            } else if (self.vtype==QTYPE_FILL_BLANK) { //填空
                if (i>0) [str appendString: QSPLIT_MULTI_BLANK];
                if ([self viewWithTag:100+i]) {
                    NSString *r=[(UITextField*)[self viewWithTag:100+i] text];
                    if (alist[i]) {
                        NSString *a=alist[i];
                        l= [a componentsSeparatedByString:QSPLIT_MULTI_ANSWER];
                        for (NSString *item in l) {
                            if ([item isEqualToString:r ]) {
                                j++;
                                break;
                            }
                        }
                    }
                    [str appendString: r];
                }
                
            }
        }
        dic[keya] = [str copy];
    }

    // 得分判断
    if (self.vtype==QTYPE_SINGLE_SELECT || self.vtype==QTYPE_MULTI_SELECT) { //多选答案验证
        if ([str isEqualToString:self.vanswer]) {
            dic[keyr]= @(2);
            dic[keys]= @(self.vscore);
        } else {
            dic[keyr]= @(1);
        }
    } else if (self.vtype==QTYPE_FILL_BLANK) { //填空题
        if (j==self.vcount) {
            dic[keys]= @(self.vscore);
            dic[keyr]= @(2);
        } else {
            dic[keyr]= @(1);
        }
    } else if (self.vtype==QTYPE_SIMPLE_ANSWER) {
        dic[keyr]= @(3);
    }
    
    return [dic copy];
}


@end


