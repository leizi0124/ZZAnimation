//
//  ZZClockView.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/9.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//
#define ZZBGColor [UIColor clearColor]  //背景色
#define ZZPointColor [UIColor blackColor]     //点颜色
#import "ZZClockView.h"
#import "ZZClockNumItem.h"
@interface ZZClockView ()
{
    UIView *jumpView;       //跳动两个点
    ZZClockNumItem *hourItem1;
    ZZClockNumItem *hourItem2;
    ZZClockNumItem *minuteItem1;
    ZZClockNumItem *minuteItem2;
    ZZClockNumItem *secondsItem1;
    ZZClockNumItem *secondsItem2;
    NSTimer *timeTimer;
}
@end
@implementation ZZClockView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ZZBGColor;
        [self createPointView];
        [self createNumView];
        
        timeTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    }
    return self;
}
#pragma mark - 初始化双点
- (void)createPointView {
    
    CGFloat unitWidth = 0;
    if (_showSeconds) {
        unitWidth = self.frame.size.width / 28.0;
    }else {
        unitWidth = self.frame.size.width / 22.0;
    }
    
    CGRect subFrame = CGRectMake(unitWidth * 9.0, 0, unitWidth * 4.0, self.frame.size.height);
    jumpView = [[UIView alloc] initWithFrame:subFrame];
    [self addSubview:jumpView];
    
    CAShapeLayer *topPointLayer = [CAShapeLayer layer];
    CGPoint centerPoint = CGPointMake(unitWidth * 2.0, jumpView.frame.size.height / 10.0 * 3.0);
    UIBezierPath *topPointPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:unitWidth startAngle:0 endAngle:2 * M_PI clockwise:YES];
    [topPointPath closePath];
    topPointLayer.path = topPointPath.CGPath;
    topPointLayer.fillColor = ZZPointColor.CGColor;
    [jumpView.layer addSublayer:topPointLayer];
    
    CAShapeLayer *bottomPointLayer = [CAShapeLayer layer];
    centerPoint = CGPointMake(unitWidth * 2.0, jumpView.frame.size.height / 10.0 * 7.0);
    UIBezierPath *bottomPointPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:unitWidth startAngle:0 endAngle:2 * M_PI clockwise:YES];
    [bottomPointPath closePath];
    bottomPointLayer.path = bottomPointPath.CGPath;
    bottomPointLayer.fillColor = ZZPointColor.CGColor;
    [jumpView.layer addSublayer:bottomPointLayer];
}
#pragma mark - 初始化数字
- (void)createNumView {
    
    CGFloat unitWidth = 0;
    if (_showSeconds) {
        unitWidth = self.frame.size.width / 28.0;
    }else {
        unitWidth = self.frame.size.width / 22.0;
    }
    
    hourItem1 = [[ZZClockNumItem alloc] initWithFrame:CGRectMake(0, 0, unitWidth * 4.0, self.frame.size.height)];
    [self addSubview:hourItem1];
    hourItem2 = [[ZZClockNumItem alloc] initWithFrame:CGRectMake(unitWidth * 5.0, 0, unitWidth * 4.0, self.frame.size.height)];
    [self addSubview:hourItem2];
    minuteItem1 = [[ZZClockNumItem alloc] initWithFrame:CGRectMake(unitWidth * 13.0, 0, unitWidth * 4.0, self.frame.size.height)];
    [self addSubview:minuteItem1];
    minuteItem2 = [[ZZClockNumItem alloc] initWithFrame:CGRectMake(unitWidth * 18.0, 0, unitWidth * 4.0, self.frame.size.height)];
    [self addSubview:minuteItem2];
    
    if (_showSeconds) {
        secondsItem1 = [[ZZClockNumItem alloc] initWithFrame:CGRectMake(unitWidth * 23.0, self.frame.size.height / 2.0, unitWidth * 2.0, self.frame.size.height / 2.0)];
        [self addSubview:secondsItem1];
        secondsItem2 = [[ZZClockNumItem alloc] initWithFrame:CGRectMake(unitWidth * 26.0, self.frame.size.height / 2.0, unitWidth * 2.0, self.frame.size.height / 2.0)];
        [self addSubview:secondsItem2];
    }
    
    [self timeAction];
}
- (void)setShowSeconds:(BOOL)showSeconds {
    _showSeconds = showSeconds;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self createPointView];
    [self createNumView];
}
- (void)timeAction {

    jumpView.hidden = !jumpView.hidden;
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"HHmmss"];
    NSString * dateStr = [dateFormatter stringFromDate:date];
    
    [hourItem1 showNum:[[dateStr substringWithRange:NSMakeRange(0, 1)]integerValue]];
    [hourItem2 showNum:[[dateStr substringWithRange:NSMakeRange(1, 1)]integerValue]];
    [minuteItem1 showNum:[[dateStr substringWithRange:NSMakeRange(2, 1)]integerValue]];
    [minuteItem2 showNum:[[dateStr substringWithRange:NSMakeRange(3, 1)]integerValue]];
    
    if (_showSeconds) {
        [secondsItem1 showNum:[[dateStr substringWithRange:NSMakeRange(4, 1)]integerValue]];
        [secondsItem2 showNum:[[dateStr substringWithRange:NSMakeRange(5, 1)]integerValue]];
    }
}
- (void)layoutSubviews {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self createPointView];
    [self createNumView];
}
@end
