//
//  AnimationVC11.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/2/1.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "AnimationVC11.h"
@interface AnimationVC11 ()
{
    UIView *musicView;
    UIView *zanView;
}
@end
@implementation AnimationVC11
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self createMusic];
}
#pragma mark - 参照抖音音乐盒
- (void)createMusic {
    
    musicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    musicView.center = self.view.center;
    [self.view addSubview:musicView];
    
    CGSize musicSize = musicView.frame.size;
    
    //旋转背景
    CAShapeLayer *bglayer= [[CAShapeLayer alloc] init];
    bglayer.frame = CGRectMake(musicSize.width / 4.0, musicSize.width / 4.0, musicSize.width / 2.0, musicSize.width / 2.0);
    UIBezierPath *bgPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(musicSize.width / 4.0, musicSize.width / 4.0) radius:musicSize.width / 4.0 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    [bgPath closePath];
    bglayer.path = bgPath.CGPath;
    bglayer.fillColor = [UIColor blackColor].CGColor;
    [musicView.layer addSublayer:bglayer];
    
    musicSize = bglayer.frame.size;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(1, musicSize.width / 5.0 * 1.5, musicSize.width - 2, musicSize.width / 5.0 * 3.0);
    [bglayer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                             (__bridge id) [UIColor darkGrayColor].CGColor,
                             (__bridge id) [UIColor clearColor].CGColor];
    
    gradientLayer.locations = @[@0.0, @0.3, @0.7];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    keyAnimation.autoreverses = YES;                        //执行完成反向执行
    keyAnimation.repeatCount = CGFLOAT_MAX;                 //无限次
    keyAnimation.rotationMode = kCAAnimationRotateAuto;     //方向为自动方向
    keyAnimation.calculationMode = kCAAnimationCubicPaced;  //匀速运动
    keyAnimation.duration = 0.01;                            //动画时间
    keyAnimation.removedOnCompletion = NO;                  //完成后不移除
    keyAnimation.fillMode = kCAFillModeForwards;            //
    keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //运动速度 加速至中点 减速至终点
    
    CATransform3D rotation1 = CATransform3DMakeRotation(0, 0, 0, -1);
    CATransform3D rotation2 = CATransform3DMakeRotation(M_PI * 0.05, 0, 0, -1);
    keyAnimation.values = @[[NSValue valueWithCATransform3D:rotation1],
                            [NSValue valueWithCATransform3D:rotation2]];
    [bglayer addAnimation:keyAnimation forKey:@"keyAnimation"];
    
    //头像
    musicSize = musicView.frame.size;
    CAShapeLayer *headerlayer = [CAShapeLayer layer];
    headerlayer.frame = CGRectMake(musicSize.width / 8.0 * 3.0, musicSize.width / 8.0 * 3.0, musicSize.width / 4.0, musicSize.width / 4.0);
    [musicView.layer addSublayer:headerlayer];
    headerlayer.contents = (id)[UIImage imageNamed:@"octocat"].CGImage;
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.repeatCount = CGFLOAT_MAX;                 //无限次
    rotateAnimation.byValue = @(M_PI * 2.0);
    rotateAnimation.duration = 3.0;                            //动画时间
    [headerlayer addAnimation:rotateAnimation forKey:@"rotateAnimation"];
    
    //音符 1
    CAShapeLayer *musicLayer = [CAShapeLayer layer];
    musicLayer.frame = CGRectMake(musicSize.width / 2.0, musicSize.width / 10.0 * 8.5, musicSize.width / 6.0, musicSize.width / 6.0);
    [musicView.layer addSublayer:musicLayer];
    musicLayer.contents = (id)[UIImage imageNamed:@"music1"].CGImage;
    //2
    CAShapeLayer *musicLayer1 = [CAShapeLayer layer];
    musicLayer1.frame = CGRectMake(musicSize.width / 2.0, musicSize.width / 10.0 * 8.5, musicSize.width / 6.0, musicSize.width / 6.0);
    [musicView.layer addSublayer:musicLayer1];
    musicLayer1.opacity = 0.0;
    musicLayer1.contents = (id)[UIImage imageNamed:@"music2"].CGImage;
    //3
    CAShapeLayer *musicLayer2 = [CAShapeLayer layer];
    musicLayer2.frame = CGRectMake(musicSize.width / 2.0, musicSize.width / 10.0 * 8.5, musicSize.width / 6.0, musicSize.width / 6.0);
    [musicView.layer addSublayer:musicLayer2];
    musicLayer2.opacity = 0.0;
    musicLayer2.contents = (id)[UIImage imageNamed:@"music2"].CGImage;
    
    CAKeyframeAnimation *pAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    pAnimation.rotationMode = kCAAnimationDiscrete;
    CGPathMoveToPoint(path, nil, musicSize.width / 2.0, musicSize.width / 10.0 * 8.5);
    CGPathAddCurveToPoint(path, nil,
                          musicSize.width / 2.0, musicSize.width / 10.0 * 8.5,
                          0, musicSize.width / 5.0 * 4.0,
                          0, 0);
    pAnimation.path = path;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    
    CAKeyframeAnimation *keyAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    keyAnimation1.autoreverses = YES;                        //执行完成反向执行
    keyAnimation1.repeatCount = CGFLOAT_MAX;                 //无限次
    keyAnimation1.rotationMode = kCAAnimationRotateAuto;     //方向为自动方向
    keyAnimation1.calculationMode = kCAAnimationCubicPaced;  //匀速运动
    keyAnimation1.duration = 0.5;                            //动画时间
    keyAnimation1.removedOnCompletion = NO;                  //完成后不移除
    keyAnimation1.fillMode = kCAFillModeForwards;            //
    keyAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //运动速度 加速至中点 减速至终点
    CATransform3D rotation3 = CATransform3DMakeRotation(0, 0, 0, -1);
    CATransform3D rotation4 = CATransform3DMakeRotation(M_PI * 0.1, 0, 0, -1);
    keyAnimation1.values = @[[NSValue valueWithCATransform3D:rotation3],
                             [NSValue valueWithCATransform3D:rotation4]];
    
    CABasicAnimation *animationScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animationScale.fromValue = @0.5;    //结束倍率
    animationScale.toValue = @1.0;    //结束倍率
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[animation, pAnimation, keyAnimation1, animationScale];
    group.duration = 3.0;
    group.repeatCount = CGFLOAT_MAX;
    group.removedOnCompletion = false;
    group.fillMode = kCAFillModeForwards;
    [group setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    [musicLayer addAnimation:group forKey:@"rightdowm100"];
    [group setBeginTime:CACurrentMediaTime() + 1.0];
    [musicLayer1 addAnimation:group forKey:@"rightdowm101"];
    [group setBeginTime:CACurrentMediaTime() + 2.0];
    [musicLayer2 addAnimation:group forKey:@"rightdowm102"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
