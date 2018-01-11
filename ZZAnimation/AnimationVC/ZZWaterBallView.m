//
//  ZZWaterBallView.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/10.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "ZZWaterBallView.h"
@interface ZZWaterBallView ()
{
    CAShapeLayer *waterLayer;
    CAShapeLayer *waterLayerBg;
}
@end
@implementation ZZWaterBallView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = frame.size.width / 2.0;
        self.layer.masksToBounds = YES;
        self.alpha = 0.6;
        self.layer.borderWidth = 2.0;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        //前
        waterLayerBg = [CAShapeLayer layer];
        waterLayerBg.frame = CGRectMake(-frame.size.width, frame.size.height / 5.0 * 3.0 - 15, frame.size.width * 3.0, frame.size.height * 3.0);
        waterLayerBg.fillColor = [UIColor greenColor].CGColor;
        UIBezierPath *waterPathBg = [UIBezierPath bezierPathWithRoundedRect:waterLayerBg.bounds cornerRadius:waterLayerBg.frame.size.width / 3.1];
        waterLayerBg.path = waterPathBg.CGPath;
        [self.layer addSublayer:waterLayerBg];
        
        CAKeyframeAnimation *animationBg = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animationBg.repeatCount = CGFLOAT_MAX;
        animationBg.duration = 5.0;
        animationBg.calculationMode = kCAAnimationCubicPaced;
        animationBg.removedOnCompletion = NO;
        CATransform3D rotation1Bg = CATransform3DMakeRotation(0, 0, 0, -1);
        CATransform3D rotation2Bg = CATransform3DMakeRotation(M_PI, 0, 0, -1);
        animationBg.values = @[[NSValue valueWithCATransform3D:rotation1Bg],[NSValue valueWithCATransform3D:rotation2Bg]];
        [waterLayerBg addAnimation:animationBg forKey:@"animationBg"];
        
        //背景
        waterLayer = [CAShapeLayer layer];
        waterLayer.frame = CGRectMake(-frame.size.width, frame.size.height / 5.0 * 3.0, frame.size.width * 3.0, frame.size.height * 3.0);
        waterLayer.fillColor = [UIColor orangeColor].CGColor;
        UIBezierPath *waterPath = [UIBezierPath bezierPathWithRoundedRect:waterLayer.bounds cornerRadius:waterLayer.frame.size.width / 3.1];
        waterLayer.path = waterPath.CGPath;
        [self.layer addSublayer:waterLayer];

        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.repeatCount = CGFLOAT_MAX;
        animation.duration = 5.0;
        animation.calculationMode = kCAAnimationCubicPaced;
        animation.removedOnCompletion = NO;
        CATransform3D rotation1 = CATransform3DMakeRotation(M_PI, 0, 0, -1);
        CATransform3D rotation2 = CATransform3DMakeRotation(0, 0, 0, -1);
        animation.values = @[[NSValue valueWithCATransform3D:rotation1],[NSValue valueWithCATransform3D:rotation2]];
        [waterLayer addAnimation:animation forKey:@"animation"];
    }
    return self;
}
- (void)updateProgress:(CGFloat)progress {
    waterLayer.frame = CGRectMake(-self.frame.size.width, self.frame.size.height * (1.0 - progress) + 10, self.frame.size.width * 3.0, self.frame.size.height * 3.0);
    waterLayerBg.frame = CGRectMake(-self.frame.size.width, self.frame.size.height * (1.0 - progress) - 5, self.frame.size.width * 3.0, self.frame.size.height * 3.0);

}
@end
