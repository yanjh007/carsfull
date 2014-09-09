//
//  MainViewController.m
//  EasySample
//
//  Created by Marian PAUL on 12/06/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "LinkVC.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface LinkVC ()<JY_STD_Delegate>
@property (strong, nonatomic) LinkView *v_links;
@property (retain,nonatomic) NSDictionary *dic_links;
@end

@implementation LinkVC

- (id)init
{
    self = [JY_Helper loadNib:@"Add" atIndex:0];
    if (self) {
        self.title = @"连线游戏";
        NSMutableArray *ary_connect=[NSMutableArray array];
        
        self.dic_links=@{@"L":@[@"A:1+2",@"D:1+1",@"C:3+2",@"D:2+2"],
                         @"R":@[@"=3",@"=2",@"=5",@"=4"],
                         @"C":ary_connect};
        
        self.v_links = [[LinkView alloc] initWithFrame:CGRectMake(0, 80, 320, 200)];
        [self.v_links setData:self.dic_links];
        [self.v_links setDelegate:self];
        
        [self.view addSubview:self.v_links];
        
        
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(int) action:(int)act withIndex:(int)index
{
    if (act==DELE_ACTION_DISMISS) {
        if (index==0) {
            self.revealSideViewController.panInteractionsWhenClosed = (PPRevealSideInteractionNone | PPRevealSideInteractionNavigationBar);
        } else {
            self.revealSideViewController.panInteractionsWhenClosed = (PPRevealSideInteractionNone | PPRevealSideInteractionNavigationBar|PPRevealSideInteractionContentView);
        }
    }
    return DELE_RESULT_VOID;
}


@end

@interface LinkView()
@property (retain,nonatomic) NSDictionary *mData;
@property (retain,nonatomic) id<JY_STD_Delegate> mDelegate;
@property (retain,nonatomic) NSArray *mLines,*mPoints;
@property (assign) float xl,xr,xbegin,ybegin,xend,yend;

@end

@implementation LinkView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor yellowColor]];
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(gsMade:)]];
        self.xl = 70;
        self.xr = 150;
        self.mLines =@[@(20),@(60),@(40),@(40)];
        
        self.mPoints=@[@(20),@(60),@(80),@(120)];
        
    }
    return self;
}

- (void)setDelegate:(id<JY_STD_Delegate>) dele
{
    self.mDelegate=dele;
}

- (void)setData:(NSDictionary*) data
{
    self.mData=data;
    [self setNeedsDisplay];
}

-(void) drawRect:(CGRect)rect
{
    [self drawTexts];
    [self drawPoints];
    [self drawLines];
}

-(void) drawTexts
{
    if (!self.mData) return;

    float xl=10,xr=160,y=10;
    NSArray *ary_l=self.mData[@"L"],*ary_r=self.mData[@"R"];
    UIFont *font = [UIFont systemFontOfSize:14];
    
    int count= [ary_l count];
    for (int i=0; i<count; i++) {
        y = 20*i+20;
        NSString *text1= ary_l[i],*text2= ary_r[i];
        
        [text1 drawAtPoint:CGPointMake(xl, y) withFont:font];
        [text2 drawAtPoint:CGPointMake(xr, y) withFont:font];
    }
}

-(void) drawLines
{
    UIBezierPath * path=[UIBezierPath bezierPath];
    float x1=80,x2=160;
    for (int i=0; i<self.mLines.count; i++) {
        [path moveToPoint:CGPointMake(x1, [self.mLines[i] floatValue]+10)];
        [path addLineToPoint:CGPointMake(x2, [self.mLines[i+1] floatValue]+10)];
        i++;
    }
    [path stroke];
    
    if (self.ybegin>0 && self.yend>0) {
        path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(80, self.ybegin)];
        [path addLineToPoint:CGPointMake(self.xend, self.yend)];
        [path stroke];
        
        
    }
    
}

-(void) drawPoints
{
    UIBezierPath * path=[UIBezierPath bezierPath];
    for (int i=0; i<self.mPoints.count; i++) {
        [path moveToPoint:CGPointMake(self.xl+3,[self.mPoints[i] floatValue])];
        [path addArcWithCenter:CGPointMake(self.xl,[self.mPoints[i] floatValue])
                        radius:3
                    startAngle:0
                      endAngle:M_2_PI
                     clockwise:YES];
        
        [path moveToPoint:CGPointMake(self.xr-3,[self.mPoints[i] floatValue])];
        [path addArcWithCenter:CGPointMake(self.xr,[self.mPoints[i] floatValue])
                        radius:3
                    startAngle:0
                      endAngle:M_2_PI
                     clockwise:YES];
    }
    [path setLineWidth:2];
    [path stroke];
    
}

- (void) gsMade:(LinkGestureRecognizer*)recognizer
{
    CGPoint pt = [recognizer locationInView:self];
    if (recognizer.state==UIGestureRecognizerStateBegan) {
        if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(action:withIndex:)]) {
            [self.mDelegate action:DELE_ACTION_DISMISS withIndex:0];
        }
        self.ybegin=pt.y;
        NSLog(@"being-%f-%f",pt.x,pt.y);
        
    } else if (recognizer.state==UIGestureRecognizerStateChanged){
        self.yend = pt.y;
        self.xend = pt.x;
        NSLog(@"moving-%f-%f",pt.x,pt.y);
        if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(action:withIndex:)]) {
            [self.mDelegate action:DELE_ACTION_DISMISS withIndex:0];
        }
    } else if (recognizer.state==UIGestureRecognizerStateCancelled) {
        self.ybegin=0;
        if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(action:withIndex:)]) {
            [self.mDelegate action:DELE_ACTION_DISMISS withIndex:1];
        }
    } else if (recognizer.state==UIGestureRecognizerStateEnded) {
        if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(action:withIndex:)]) {
            [self.mDelegate action:DELE_ACTION_DISMISS withIndex:1];
        }
    }
    
    [self setNeedsDisplay];
    
}


@end


#pragma mark - LinkGestureRecognizer
@implementation LinkGestureRecognizer

- (void)reset
{ [super reset ]; }

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{ [super touchesBegan:touches withEvent:event ]; }

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setState:UIGestureRecognizerStateChanged ];
    [super touchesMoved:touches withEvent:event ];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{ [super touchesEnded:touches withEvent:event ]; }

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{ [super touchesCancelled:touches withEvent:event ]; }


@end



