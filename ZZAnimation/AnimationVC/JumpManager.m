//
//  JumpManager.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/8.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "JumpManager.h"
#import <objc/message.h>
@interface JumpManager ()<CAAnimationDelegate>
@property (nonatomic, weak) UIViewController *delegateVC;
@property (nonatomic, assign) JumpMode selectMode;
@property (nonatomic, strong) id transitionContext;
@end
@implementation JumpManager
- (instancetype)initWithDelegate:(UIViewController *)delegate {
    if (self = [super init]) {
        _delegateVC = delegate;
    }
    return self;
}
#pragma mark - 跳转 已某种模式
- (void)presentVC:(UIViewController *)toVC widthMode:(JumpMode)model {
    
    toVC.modalPresentationStyle  = UIModalPresentationFullScreen;
    _selectMode = model;
    toVC.transitioningDelegate = self;
    [_delegateVC presentViewController:toVC animated:YES completion:nil];
}
#pragma mark - 转场时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.35;
}
#pragma mark - 专场具体过程
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    _transitionContext = transitionContext;
    switch (_selectMode) {
        case GradualChangeMode:{
            [self gradualChange];
        }
            break;
        case DiffusanceMode:{
            [self diffusance];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 渐变转场
- (void)gradualChange {

    UIViewController * fromVC = [_transitionContext viewControllerForKey:(UITransitionContextFromViewControllerKey)];
    UIViewController * toVC = [_transitionContext viewControllerForKey:(UITransitionContextToViewControllerKey)];
    UIView * contentView = [_transitionContext containerView];
    
    UIView *fromView = [_transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView   = [_transitionContext viewForKey:UITransitionContextToViewKey];
    
    fromView.frame = [_transitionContext initialFrameForViewController:fromVC];
    toView.frame   = [_transitionContext finalFrameForViewController:toVC];
    fromView.alpha = 1.0f;
    toView.alpha   = 0.0f;

    [contentView addSubview:toView];
    
    NSTimeInterval transitionDuration = [self transitionDuration:_transitionContext];
    [UIView animateWithDuration:transitionDuration animations:^{
        
        fromView.alpha = 0.0f;
        toView.alpha   = 1.0;
        
    } completion:^(BOOL finished) {
        
        BOOL wasCancelled = [_transitionContext transitionWasCancelled];
        [_transitionContext completeTransition:!wasCancelled];
    }];
}
#pragma mark - 扩散转场
- (void)diffusance {
    
    UIViewController * toViewController= [_transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController * toVC = [_transitionContext viewControllerForKey:(UITransitionContextToViewControllerKey)];
    
    UIView * containerView = [_transitionContext containerView];
    [containerView addSubview:toViewController.view];
    
    // 画一个按钮圆
    UIBezierPath * startCycle =  [UIBezierPath bezierPathWithOvalInRect:toVC.view.frame];
    
    //  选择X或者Y的最大值，解释在博客里
    CGFloat x = MAX(toVC.view.frame.origin.x, containerView.frame.size.width - toVC.view.frame.origin.x);
    CGFloat y = MAX(toVC.view.frame.origin.y, containerView.frame.size.height - toVC.view.frame.origin.y);
    
    // sqrtf 求平方根函数  pow求次方函数，这里的意思是求X的2次方，要是pow(m,9)就是求m的9次方
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    
    // UIBezierPath画结束的圆
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    //创建CAShapeLayer
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    
    //将maskLayer 赋给 toVC.View
    toViewController.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation * maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue   = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration  = [self transitionDuration:_transitionContext];
    
    //速度控制函数
    //不理解下面timingFunction函数的的可以看看这个http://www.jianshu.com/p/a4d774315613
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:_transitionContext forKey:@"transitionContext"];
    // 添加动画
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}
- (void)animationEnded:(BOOL)transitionCompleted {
    NSLog(@"转场结束");
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"动画结束");
    BOOL wasCancelled = [_transitionContext transitionWasCancelled];
    [_transitionContext completeTransition:!wasCancelled];
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}
@end
