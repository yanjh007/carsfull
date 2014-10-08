//
//  ContentVC.m
//  slearning
//
//  Created by YanJH on 14-9-30.
//  Copyright (c) 2014年 cn.yanjh. All rights reserved.
//

#import "ContentVC.h"
#import "AppController.h"
#import "AsyncImageView.h"
#import "FSAudioController.h"

#pragma mark - 内容页面控制器
@interface ContentVC ()<UIScrollViewDelegate>
//@property (retain,nonatomic) NSArray *mAryContent;
@property (retain,nonatomic) NSMutableArray *mAryContentViews;

@property (strong, nonatomic) IBOutlet UIScrollView *sv_content;
@property (strong, nonatomic) IBOutlet UIView *tbar,*bbar;
@property (strong, nonatomic) IBOutlet ContentPageView *cp_current;;

@property (assign) int iCurrent_page;

@end

@implementation ContentVC

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
    ContentPageView *cv;
    NSObject *o = self.mAryContentViews[page];
    if ([o isKindOfClass:[NSDictionary class]]) { //还没有视图
        cv = [[ContentPageView alloc] initWithData:(NSDictionary*)o];
        cv.tag=page;
        [self.mAryContentViews replaceObjectAtIndex:page withObject:cv];
    } else {
        cv=(ContentPageView*)o;
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
    
    if (!self.cp_current) { //
        self.cp_current = self.mAryContentViews[page];
        [self.cp_current show:YES];
    } else {
        if (self.cp_current.tag!=page) { //变换页面
            [self.cp_current show:NO];
            self.cp_current = self.mAryContentViews[page];
            [self.cp_current show:YES];
        }
    }
    if (self.cp_current && self.cp_current.tag!=page) { //当前页面改变
        [self.cp_current show:NO];
    }
    
    //加载前后页面
    [self loadContentAt:page-1];
    [self loadContentAt:page+1];
}

@end

#pragma mark - 内容页面视图

@interface ContentPageView()
@property (retain,nonatomic) NSDictionary *mData;

@property (nonatomic,retain)  FSAudioController *ac_content;
@end

@implementation ContentPageView

-(instancetype) initWithData:(NSDictionary*) data
{
    self= [[ContentPageView alloc] initWithFrame:CGRectZero];
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
        if (self.ac_content && self.ac_content.url) {
            [self.ac_content play];
            NSLog(@"begin play:%@",self.ac_content.url);
        }
    } else {
        NSLog(@"hide Page:%@",self.mData[DKEY_ID]);
        if (self.ac_content) {
            [self.ac_content stop];
            NSLog(@"end play:%@",self.ac_content.url);
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
        if (!self.ac_content) {
            self.ac_content = [[FSAudioController alloc] init];
        }
        self.ac_content.url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.mp3",path,sno]];
        //[self.ac_content setUrl:[NSURL URLWithString:[U] content[@"content"]];
    }
    
    if ([mtype rangeOfString:@"V"].location != NSNotFound) { //带视频
        if (content[@"content"]) { //外部视频
            
        } else { //默认视频
            
        }
        
    }
    
}

@end
