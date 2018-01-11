//
//  AnimationVC3.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/5.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "AnimationVC3.h"
#import "BaseTableView.h"
#import <objc/message.h>
@interface AnimationVC3 ()<BaseTableViewDelegate>
{
    BaseTableView *tableview;
    NSArray *dataArray;
    UIView *animationView;
}
@end

@implementation AnimationVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = @[@"弧形运动 position型",
                  @"矩形运动 position型",
                  @"抖动 transform型"];
    
    tableview = [[BaseTableView alloc] initWithFrame:self.view.bounds];
    tableview.delegate = self;
    tableview.dataArray = dataArray;
    [self.view addSubview:tableview];
    
    animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    animationView.center = self.view.center;
    animationView.backgroundColor = [UIColor blackColor];
    animationView.alpha = 0.5;
    animationView.userInteractionEnabled = NO;
    [self.view addSubview:animationView];
    
    //rotationMode：动画计算模式。
    //kCAAnimationLinear: 线性模式，默认值
    //kCAAnimationDiscrete: 离散模式
    //kCAAnimationPaced:均匀处理，会忽略keyTimes
    //kCAAnimationCubic:平滑执行，对于位置变动关键帧动画运行轨迹更平滑
    //kCAAnimationCubicPaced:平滑均匀执行
}
- (void)selectIndex:(NSInteger)index title:(NSString *)title {
    
    NSString *methodName = [NSString stringWithFormat:@"animation%zd",index+1];
    const char * method =[methodName UTF8String];
    objc_msgSend(self, sel_registerName(method));
}
- (void)animation1 {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    keyAnimation.rotationMode = kCAAnimationDiscrete;
    CGPathMoveToPoint(path, nil, self.view.center.x, self.view.center.y);
    CGPathAddCurveToPoint(path, nil,
                          self.view.center.x, self.view.center.y,
                          self.view.frame.size.width * 1.5, self.view.center.y / 2.0 * 3.0,
                          self.view.center.x, self.view.frame.size.height);
    keyAnimation.path = path;
    keyAnimation.duration = 2.0;
    [animationView.layer addAnimation:keyAnimation forKey:@"keyAnimation"];
}
- (void)animation2 {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.rotationMode = kCAAnimationDiscrete;
    keyAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y)],
                           [NSValue valueWithCGPoint:CGPointMake(self.view.center.x + 100, self.view.center.y)],
                           [NSValue valueWithCGPoint:CGPointMake(self.view.center.x + 100, self.view.center.y + 100)],
                           [NSValue valueWithCGPoint:CGPointMake(self.view.center.x - 100, self.view.center.y + 100)],
                           [NSValue valueWithCGPoint:CGPointMake(self.view.center.x - 100, self.view.center.y)],
                           [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y)]
                           ];
    keyAnimation.duration = 2.0;
    [animationView.layer addAnimation:keyAnimation forKey:@"keyAnimation"];
}
- (void)animation3 {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    keyAnimation.rotationMode = kCAAnimationDiscrete;
    keyAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DScale(animationView.layer.transform, 1.2, 1.2, 1.0)],
                            [NSValue valueWithCATransform3D:CATransform3DScale(animationView.layer.transform, 0.8, 0.8, 1.0)],
                            [NSValue valueWithCATransform3D:CATransform3DScale(animationView.layer.transform, 1.1, 1.1, 1.0)],
                            [NSValue valueWithCATransform3D:CATransform3DScale(animationView.layer.transform, 0.9, 0.9, 1.0)],
                            [NSValue valueWithCATransform3D:CATransform3DScale(animationView.layer.transform, 1.05, 1.05, 1.0)],
                            [NSValue valueWithCATransform3D:CATransform3DScale(animationView.layer.transform, 1.0, 1.0, 1.0)]
                            ];
    keyAnimation.duration = 1.0;
    [animationView.layer addAnimation:keyAnimation forKey:@"keyAnimation"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
