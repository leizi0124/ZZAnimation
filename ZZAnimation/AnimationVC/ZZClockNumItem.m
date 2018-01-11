//
//  ZZClockNumItem.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/9.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "ZZClockNumItem.h"
//     |--1--|
//     4     5
//     |--2--|
//     6     7
//     |--3--|
@interface ZZClockNumItem ()
{
    //与上图位置相对应
    CAShapeLayer *oneLayer;
    CAShapeLayer *twoLayer;
    CAShapeLayer *thrLayer;
    CAShapeLayer *fouLayer;
    CAShapeLayer *fivLayer;
    CAShapeLayer *sixLayer;
    CAShapeLayer *sevLayer;
}
@end
@implementation ZZClockNumItem
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        CGFloat gap = 1.0;
        CGFloat vWidth = frame.size.width;
        CGFloat vHeight = frame.size.height;
        CGFloat unitWidth = frame.size.width / 8.0;
        
        oneLayer = [CAShapeLayer layer];
        UIBezierPath *onePath = [UIBezierPath bezierPath];
        [onePath moveToPoint:CGPointMake(gap, 0)];
        [onePath addLineToPoint:CGPointMake(vWidth - gap, 0)];
        [onePath addLineToPoint:CGPointMake(vWidth - unitWidth * 2.0 - gap, unitWidth * 2.0)];
        [onePath addLineToPoint:CGPointMake(unitWidth * 2.0 + gap, unitWidth * 2.0)];
        [onePath closePath];
        oneLayer.path = onePath.CGPath;
        oneLayer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:oneLayer];
        
        twoLayer = [CAShapeLayer layer];
        UIBezierPath *twoPath = [UIBezierPath bezierPath];
        [twoPath moveToPoint:CGPointMake(unitWidth + gap, vHeight / 2.0)];
        [twoPath addLineToPoint:CGPointMake(unitWidth * 2.0 + gap, vHeight / 2.0 - unitWidth)];
        [twoPath addLineToPoint:CGPointMake(vWidth - unitWidth * 2.0 - gap, vHeight / 2.0 - unitWidth)];
        [twoPath addLineToPoint:CGPointMake(vWidth - unitWidth - gap, vHeight / 2.0)];
        [twoPath addLineToPoint:CGPointMake(vWidth - unitWidth * 2.0 - gap, vHeight / 2.0 + unitWidth)];
        [twoPath addLineToPoint:CGPointMake(unitWidth * 2.0 + gap, vHeight / 2.0 + unitWidth)];
        [twoPath closePath];
        twoLayer.path = twoPath.CGPath;
        twoLayer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:twoLayer];
        
        thrLayer = [CAShapeLayer layer];
        UIBezierPath *thrPath = [UIBezierPath bezierPath];
        [thrPath moveToPoint:CGPointMake(gap, vHeight)];
        [thrPath addLineToPoint:CGPointMake(unitWidth * 2.0 + gap, vHeight - unitWidth * 2.0)];
        [thrPath addLineToPoint:CGPointMake(vWidth - unitWidth * 2.0 - gap, vHeight - unitWidth * 2.0)];
        [thrPath addLineToPoint:CGPointMake(vWidth - gap, vHeight)];
        [thrPath closePath];
        thrLayer.path = thrPath.CGPath;
        thrLayer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:thrLayer];
        
        fouLayer = [CAShapeLayer layer];
        UIBezierPath *fouPath = [UIBezierPath bezierPath];
        [fouPath moveToPoint:CGPointMake(0, gap)];
        [fouPath addLineToPoint:CGPointMake(unitWidth * 2.0, unitWidth * 2.0 + gap)];
        [fouPath addLineToPoint:CGPointMake(unitWidth * 2.0, vHeight / 2.0 - unitWidth - gap)];
        [fouPath addLineToPoint:CGPointMake(unitWidth, vHeight / 2.0 - gap)];
        [fouPath addLineToPoint:CGPointMake(0, vHeight / 2.0 - gap)];
        [fouPath closePath];
        fouLayer.path = fouPath.CGPath;
        fouLayer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:fouLayer];
        
        fivLayer = [CAShapeLayer layer];
        UIBezierPath *fivPath = [UIBezierPath bezierPath];
        [fivPath moveToPoint:CGPointMake(vWidth - unitWidth * 2.0, unitWidth * 2.0 + gap)];
        [fivPath addLineToPoint:CGPointMake(vWidth, gap)];
        [fivPath addLineToPoint:CGPointMake(vWidth, vHeight / 2.0 - gap)];
        [fivPath addLineToPoint:CGPointMake(vWidth - unitWidth, vHeight / 2.0 - gap)];
        [fivPath addLineToPoint:CGPointMake(vWidth - unitWidth * 2.0, vHeight / 2.0 - unitWidth - gap)];
        [fivPath closePath];
        fivLayer.path = fivPath.CGPath;
        fivLayer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:fivLayer];
        
        sixLayer = [CAShapeLayer layer];
        UIBezierPath *sixPath = [UIBezierPath bezierPath];
        [sixPath moveToPoint:CGPointMake(0, vHeight / 2.0 + gap)];
        [sixPath addLineToPoint:CGPointMake(unitWidth, vHeight / 2.0 + gap)];
        [sixPath addLineToPoint:CGPointMake(unitWidth * 2.0, vHeight / 2.0 + unitWidth + gap)];
        [sixPath addLineToPoint:CGPointMake(unitWidth * 2.0, vHeight - unitWidth * 2.0 - gap)];
        [sixPath addLineToPoint:CGPointMake(0, vHeight - gap)];
        [sixPath closePath];
        sixLayer.path = sixPath.CGPath;
        sixLayer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:sixLayer];
        
        sevLayer = [CAShapeLayer layer];
        UIBezierPath *sevPath = [UIBezierPath bezierPath];
        [sevPath moveToPoint:CGPointMake(vWidth - unitWidth * 2.0, vHeight / 2.0 + unitWidth + gap)];
        [sevPath addLineToPoint:CGPointMake(vWidth - unitWidth, vHeight / 2.0 + gap)];
        [sevPath addLineToPoint:CGPointMake(vWidth, vHeight / 2.0 + gap)];
        [sevPath addLineToPoint:CGPointMake(vWidth, vHeight - gap)];
        [sevPath addLineToPoint:CGPointMake(vWidth - unitWidth * 2.0, vHeight - unitWidth * 2.0 - gap)];
        [sevPath closePath];
        sevLayer.path = sevPath.CGPath;
        sevLayer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:sevLayer];
    }
    return self;
}
- (void)showNum:(NSInteger)num {
    if (num < 0 || num > 9) {
        return;
    }
    switch (num) {
        case 0:{
            oneLayer.hidden = NO;
            twoLayer.hidden = YES;
            thrLayer.hidden = NO;
            fouLayer.hidden = NO;
            fivLayer.hidden = NO;
            sixLayer.hidden = NO;
            sevLayer.hidden = NO;
        }
            break;
        case 1:{
            oneLayer.hidden = YES;
            twoLayer.hidden = YES;
            thrLayer.hidden = YES;
            fouLayer.hidden = YES;
            fivLayer.hidden = NO;
            sixLayer.hidden = YES;
            sevLayer.hidden = NO;
        }
            break;
        case 2:{
            oneLayer.hidden = NO;
            twoLayer.hidden = NO;
            thrLayer.hidden = NO;
            fouLayer.hidden = YES;
            fivLayer.hidden = NO;
            sixLayer.hidden = NO;
            sevLayer.hidden = YES;
        }
            break;
        case 3:{
            oneLayer.hidden = NO;
            twoLayer.hidden = NO;
            thrLayer.hidden = NO;
            fouLayer.hidden = YES;
            fivLayer.hidden = NO;
            sixLayer.hidden = YES;
            sevLayer.hidden = NO;
        }
            break;
        case 4:{
            oneLayer.hidden = YES;
            twoLayer.hidden = NO;
            thrLayer.hidden = YES;
            fouLayer.hidden = NO;
            fivLayer.hidden = NO;
            sixLayer.hidden = YES;
            sevLayer.hidden = NO;
        }
            break;
        case 5:{
            oneLayer.hidden = NO;
            twoLayer.hidden = NO;
            thrLayer.hidden = NO;
            fouLayer.hidden = NO;
            fivLayer.hidden = YES;
            sixLayer.hidden = YES;
            sevLayer.hidden = NO;
        }
            break;
        case 6:{
            oneLayer.hidden = NO;
            twoLayer.hidden = NO;
            thrLayer.hidden = NO;
            fouLayer.hidden = NO;
            fivLayer.hidden = YES;
            sixLayer.hidden = NO;
            sevLayer.hidden = NO;
        }
            break;
        case 7:{
            oneLayer.hidden = NO;
            twoLayer.hidden = YES;
            thrLayer.hidden = YES;
            fouLayer.hidden = YES;
            fivLayer.hidden = NO;
            sixLayer.hidden = YES;
            sevLayer.hidden = NO;
        }
            break;
        case 8:{
            oneLayer.hidden = NO;
            twoLayer.hidden = NO;
            thrLayer.hidden = NO;
            fouLayer.hidden = NO;
            fivLayer.hidden = NO;
            sixLayer.hidden = NO;
            sevLayer.hidden = NO;
        }
            break;
        case 9:{
            oneLayer.hidden = NO;
            twoLayer.hidden = NO;
            thrLayer.hidden = NO;
            fouLayer.hidden = NO;
            fivLayer.hidden = NO;
            sixLayer.hidden = YES;
            sevLayer.hidden = NO;
        }
            break;
            
        default:
            break;
    }
}
@end
