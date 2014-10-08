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

#pragma mark - 内容页面控制器
@interface ContentVC ()<UIScrollViewDelegate>
//@property (retain,nonatomic) NSArray *mAryContent;
@property (retain,nonatomic) NSMutableArray *mAryContentViews;

@property (strong, nonatomic) IBOutlet UIScrollView *sv_content;

@end

@implementation ContentVC

//-(id) init
//{
//    self=[super init]
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mAryContentViews =[NSMutableArray arrayWithArray:@[
                    @{DKEY_ID:@(1),DKEY_TITLE:@"第一页",DKEY_TYPE:@"TP",@"content":@"这是第一页"}, //文字加图片
                    @{DKEY_ID:@(2),DKEY_TITLE:@"第二页",DKEY_TYPE:@"V"}, //本地视频
                    @{DKEY_ID:@(3),DKEY_TITLE:@"第三页",DKEY_TYPE:@"LI"}, //链接+提示信息
                    @{DKEY_ID:@(4),DKEY_TITLE:@"第四页",DKEY_TYPE:@"W",DKEY_CONTENT:@"baidu.com"} //Web内容
                      ]];
    
    // Do any additional setup after loading the view.

}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.sv_content setContentSize: CGSizeMake(self.sv_content.frame.size.width * self.mAryContentViews.count,self.sv_content.frame.size.height)];
    [self loadContentAt:0];
    [self loadContentAt:1];

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
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadContentAt:page-1];
    [self loadContentAt:page];
    [self loadContentAt:page+1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

@end

#pragma mark - 内容页面视图

@interface ContentPageView()
@property (strong, nonatomic) IBOutlet UILabel *lb_title;

@end

@implementation ContentPageView

-(instancetype) initWithData:(NSDictionary*) data
{
    self =[[NSBundle mainBundle] loadNibNamed:@"Content" owner:self options:nil][0];
    if (self) {
        //[self.lb_title setText:data[DKEY_TITLE]];
        [self setPageContent:data];
    }
    return self;
}

-(void) setPageContent:(NSDictionary*)content
{
    NSString *mtype=content[DKEY_TYPE];
    int no=[content[DKEY_ID] intValue];
    
    if ([mtype containsString:@"P"]) { //带图片
        UIImageView *iv=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        iv.imageURL=[NSURL URLWithString:@"http://s.cn.bing.net/az/hprichbg/rb/CloseupChrysanthemums_ZH-CN8124616705_1366x768.jpg"];
        [self addSubview:iv];
        [self sendSubviewToBack:iv];
        
    }
    
    if ([mtype containsString:@"T"]) { //带图片
        UILabel *lb=[[UILabel alloc] initWithFrame:CGRectMake(10, 718, 904, 40)];
        [lb setTextAlignment:NSTextAlignmentCenter];
        [lb setBackgroundColor:[UIColor yellowColor]];
        [lb setTextColor:[UIColor blackColor]];
        [lb setText:content[@"content"]];
        [self addSubview:lb];
        [self bringSubviewToFront:lb];
    }
    
    if ([mtype containsString:@"A"]) { //带音频
        
    }
    
    if ([mtype containsString:@"V"]) { //带视频
        if (content[@"content"]) { //外部视频
            
        } else { //默认视频
            
        }
        
    }
    
    
}

@end
