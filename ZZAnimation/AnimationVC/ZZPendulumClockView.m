//
//  ZZPendulumClockView.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/10.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "ZZPendulumClockView.h"
@interface ZZPendulumClockView ()
{
    UIView *pendulumView;       //钟摆
    UIView *clockView;          //表盘
    UIView *hourView;           //时针
    UIView *minuteView;         //分针
    UIView *secondView;         //秒针
    UILabel *secondLabel;       //秒显示
    NSTimer *timeTimer;
}
@end
@implementation ZZPendulumClockView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        [self subviewsInit];
    }
    return self;
}
- (void)subviewsInit {
    //钟摆相关
    pendulumView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, self.frame.size.height - 100)];
    pendulumView.center = self.center;
    [self addSubview:pendulumView];
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    keyAnimation.autoreverses = YES;                        //执行完成反向执行
    keyAnimation.repeatCount = CGFLOAT_MAX;                 //无限次
    keyAnimation.rotationMode = kCAAnimationRotateAuto;     //方向为自动方向
    keyAnimation.calculationMode = kCAAnimationCubicPaced;  //匀速运动
    keyAnimation.duration = 1.0;                            //动画时间
    keyAnimation.removedOnCompletion = NO;                  //完成后不移除
    keyAnimation.fillMode = kCAFillModeForwards;            //
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //运动速度 加速至中点 减速至终点
    
    CATransform3D rotation1 = CATransform3DMakeRotation(-30 * M_PI / 180, 0, 0, -1);
    CATransform3D rotation2 = CATransform3DMakeRotation(30 * M_PI / 180, 0, 0, -1);
    keyAnimation.values = @[[NSValue valueWithCATransform3D:rotation1],
                            [NSValue valueWithCATransform3D:rotation2]];
    
    //钟摆杆
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    UIBezierPath *linePath = [UIBezierPath bezierPathWithRect:CGRectMake((pendulumView.frame.size.width - 3) / 2.0, self.center.y, 3, pendulumView.frame.size.height / 2.0 - 40)];
    [linePath closePath];
    lineLayer.path = linePath.CGPath;
    [pendulumView.layer addSublayer:lineLayer];
    
    //钟摆盘
    CAShapeLayer *pendulumLayer = [CAShapeLayer layer];
    UIBezierPath *pendulumPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake((pendulumView.frame.size.width - 3) / 2.0, pendulumView.frame.size.height)
                                                                radius:25.0
                                                            startAngle:0
                                                              endAngle:M_PI * 2.0
                                                             clockwise:YES];
    [pendulumPath closePath];
    pendulumLayer.path = pendulumPath.CGPath;
    [pendulumView.layer addSublayer:pendulumLayer];
    
    [pendulumView.layer addAnimation:keyAnimation forKey:@"keyAnimation"];
    
    //表盘
    clockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2.0, self.frame.size.width / 2.0)];
    clockView.center = CGPointMake(self.center.x, self.center.y - self.frame.size.width / 8.0);
    [self addSubview:clockView];
    
    CAShapeLayer *discLayer = [CAShapeLayer layer];
    discLayer.fillColor = [UIColor orangeColor].CGColor;
    UIBezierPath *discPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(clockView.frame.size.width / 2.0, clockView.frame.size.width / 2.0)
                                                            radius:clockView.frame.size.width / 2.0
                                                        startAngle:0
                                                          endAngle:M_PI * 2.0
                                                         clockwise:YES];
    [discPath closePath];
    discLayer.path = discPath.CGPath;
    [clockView.layer addSublayer:discLayer];
    
    CGPoint centerPoint  = CGPointZero;
    CGSize itemSize = CGSizeMake(clockView.frame.size.width / 8.0, clockView.frame.size.width / 8.0);
    for (NSInteger index = 0; index < 12; index++) {
        
        centerPoint.x = clockView.frame.size.width / 2.0 + (clockView.frame.size.width / 2.0 - itemSize.width / 2.0) * sinf((index + 1) * M_PI / 6.0);
        centerPoint.y = clockView.frame.size.width / 2.0 - (clockView.frame.size.width / 2.0 - itemSize.width / 2.0) * cosf((index + 1) * M_PI / 6.0);
        
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, itemSize.width, itemSize.height)];
        numLabel.font = [UIFont systemFontOfSize:15.0];
        numLabel.textColor = [UIColor blackColor];
        numLabel.text = [NSString stringWithFormat:@"%zd",index + 1];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.center = centerPoint;
        [clockView addSubview:numLabel];
    }
    
    //秒显示
    secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, clockView.frame.size.height / 4.0 * 3.0, clockView.frame.size.width, 30)];
    secondLabel.font = [UIFont systemFontOfSize:15.0];
    secondLabel.textColor = [UIColor blackColor];
    secondLabel.textAlignment = NSTextAlignmentCenter;
    [clockView addSubview:secondLabel];
    secondLabel.hidden = YES;
    
    //时针
    CGFloat cWidth = clockView.frame.size.width;
    hourView = [[UIView alloc] initWithFrame:CGRectMake(cWidth / 24.0 * 11.0, cWidth / 4.0, cWidth / 12.0, cWidth / 4.0 * 2.0)];
    [clockView addSubview:hourView];
    
    CAShapeLayer *hourLayer = [CAShapeLayer layer];
    hourLayer.fillColor = [UIColor blackColor].CGColor;
    UIBezierPath *hourPath = [UIBezierPath bezierPath];
    [hourPath moveToPoint:CGPointMake(hourView.frame.size.width / 2.0, 0)];
    [hourPath addLineToPoint:CGPointMake(hourView.frame.size.width, hourView.frame.size.width)];
    [hourPath addLineToPoint:CGPointMake(hourView.frame.size.width / 2.0 + 2, hourView.frame.size.width)];
    [hourPath addLineToPoint:CGPointMake(hourView.frame.size.width / 2.0 + 2, hourView.frame.size.height / 2.0 + 10)];
    [hourPath addLineToPoint:CGPointMake(hourView.frame.size.width / 2.0 - 2, hourView.frame.size.height / 2.0 + 10)];
    [hourPath addLineToPoint:CGPointMake(hourView.frame.size.width / 2.0 - 2, hourView.frame.size.width)];
    [hourPath addLineToPoint:CGPointMake(0, hourView.frame.size.width)];
    [hourPath closePath];
    hourLayer.path = hourPath.CGPath;
    [hourView.layer addSublayer:hourLayer];
    
    //分针
    minuteView = [[UIView alloc] initWithFrame:CGRectMake(cWidth / 24.0 * 11.0, cWidth / 8.0, cWidth / 12.0, cWidth / 4.0 * 3.0)];
    [clockView addSubview:minuteView];
    
    CAShapeLayer *minuteLayer = [CAShapeLayer layer];
    minuteLayer.fillColor = [UIColor blackColor].CGColor;
    UIBezierPath *minutePath = [UIBezierPath bezierPath];
    [minutePath moveToPoint:CGPointMake(minuteView.frame.size.width / 2.0, 0)];
    [minutePath addLineToPoint:CGPointMake(minuteView.frame.size.width - 3, minuteView.frame.size.width)];
    [minutePath addLineToPoint:CGPointMake(minuteView.frame.size.width / 2.0 + 1.5, minuteView.frame.size.width)];
    [minutePath addLineToPoint:CGPointMake(minuteView.frame.size.width / 2.0 + 1.5, minuteView.frame.size.height / 2.0 + 10)];
    [minutePath addLineToPoint:CGPointMake(minuteView.frame.size.width / 2.0 - 1.5, minuteView.frame.size.height / 2.0 + 10)];
    [minutePath addLineToPoint:CGPointMake(minuteView.frame.size.width / 2.0 - 1.5, minuteView.frame.size.width)];
    [minutePath addLineToPoint:CGPointMake(3, minuteView.frame.size.width)];
    [minutePath closePath];
    minuteLayer.path = minutePath.CGPath;
    [minuteView.layer addSublayer:minuteLayer];
    
    //秒针
    secondView = [[UIView alloc] initWithFrame:CGRectMake(cWidth / 24.0 * 11.0, cWidth / 16.0, cWidth / 12.0, cWidth / 8.0 * 7.0)];
    [clockView addSubview:secondView];
    
    CAShapeLayer *secondLayer = [CAShapeLayer layer];
    secondLayer.fillColor = [UIColor blackColor].CGColor;
    UIBezierPath *secondPath = [UIBezierPath bezierPath];
    [secondPath moveToPoint:CGPointMake(secondView.frame.size.width / 2.0, 0)];
    [secondPath addLineToPoint:CGPointMake(secondView.frame.size.width - 5, secondView.frame.size.width)];
    [secondPath addLineToPoint:CGPointMake(secondView.frame.size.width / 2.0 + 1, secondView.frame.size.width)];
    [secondPath addLineToPoint:CGPointMake(secondView.frame.size.width / 2.0 + 1, secondView.frame.size.height / 2.0 + 10)];
    [secondPath addLineToPoint:CGPointMake(secondView.frame.size.width / 2.0 - 1, secondView.frame.size.height / 2.0 + 10)];
    [secondPath addLineToPoint:CGPointMake(secondView.frame.size.width / 2.0 - 1, secondView.frame.size.width)];
    [secondPath addLineToPoint:CGPointMake(5, secondView.frame.size.width)];
    [secondPath closePath];
    secondLayer.path = secondPath.CGPath;
    [secondView.layer addSublayer:secondLayer];
    
    [self showTime];
    
    timeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timeTimer forMode:NSRunLoopCommonModes];
}
- (void)showTime {
    
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"HHmmss"];
    NSString * dateStr = [dateFormatter stringFromDate:date];
    
    double hourTime = [[dateStr substringWithRange:NSMakeRange(0, 2)] doubleValue];
    double minuteTime = [[dateStr substringWithRange:NSMakeRange(2, 2)] doubleValue];
    double secondTime = [[dateStr substringWithRange:NSMakeRange(4, 2)] intValue];
    
    hourView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI / 6.0 * hourTime);
    minuteView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI / 30.0 * minuteTime);
    secondView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI / 30.0 * secondTime);
    secondLabel.text = [NSString stringWithFormat:@"%.2zd",(int)secondTime];
}
- (void)setType:(ShowType)type {
    _type = type;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self subviewsInit];
    
    if (type == showQuartzClock) {
        
        [pendulumView removeFromSuperview];
    }else {
        
        [secondView removeFromSuperview];
    }
    
    
}
@end
