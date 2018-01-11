//
//  ZZAnimation1.m
//  ZZAnimation
//
//  Created by JB-Mac on 2017/10/23.
//  Copyright © 2017年 ZZAnimation. All rights reserved.
//

#import "ZZAnimation1.h"

static const CGFloat Raduis = 50.0f;
static const CGFloat lineWidth = 50.0f;
static const CGFloat lineGapHeight = 10.0f;
static const CGFloat lineHeight = 8.0f;

static const CGFloat kStep1Duration = 0.5;
static const CGFloat kStep2Duration = 0.5;
static const CGFloat kStep3Duration = 5.0;
static const CGFloat kStep4Duration = 5.0;

#define kTopY       Raduis - lineGapHeight
#define kCenterY    kTopY + lineGapHeight + lineHeight
#define kBottomY    kCenterY + lineGapHeight + lineHeight
#define Radians(x)  (M_PI * (x) / 180.0)

@interface ZZAnimation1 ()

@property (nonatomic, strong) CAShapeLayer *changedLayer;

@end

@implementation ZZAnimation1

- (instancetype)init {
    if (self = [super init]) {
        
        NSLog(@"初始化");
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor grayColor];
        
        _changedLayer = [CAShapeLayer layer];
        _changedLayer.fillColor = [UIColor yellowColor].CGColor;
        _changedLayer.strokeColor = [UIColor whiteColor].CGColor;
        _changedLayer.contentsScale = [UIScreen mainScreen].scale;
        _changedLayer.lineWidth = lineHeight ;
        _changedLayer.lineCap = kCALineCapRound;
        
        CGFloat startOriginX = self.center.x - lineWidth /2.0;
        CGFloat endOriginX = self.center.x + lineWidth /2.0;
        CGMutablePathRef solidChangedLinePath =  CGPathCreateMutable();
        
        CGPathMoveToPoint(solidChangedLinePath, NULL, startOriginX, kCenterY);
        CGPathAddLineToPoint(solidChangedLinePath, NULL, endOriginX, kCenterY);
        [_changedLayer setPath:solidChangedLinePath];
        CGPathRelease(solidChangedLinePath);
        
        [self.layer addSublayer:_changedLayer];
    }
    return self;
}

- (void)startAnimation {
    
    NSLog(@"开始动画");
    
    _changedLayer.strokeEnd = 0.4;
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    strokeAnimation.toValue = [NSNumber numberWithFloat:0.4f];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    pathAnimation.toValue = [NSNumber numberWithFloat:-10];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:strokeAnimation,pathAnimation, nil];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animationGroup.duration = kStep1Duration;
    animationGroup.delegate = self;
    animationGroup.removedOnCompletion = YES;
    [animationGroup setValue:@"animationStep1" forKey:@"animationName"];
    [_changedLayer addAnimation:animationGroup forKey:nil];
}

@end
