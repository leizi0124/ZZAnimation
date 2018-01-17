//
//  AnimationVC10.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/11.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "AnimationVC10.h"
#import "BaseTableView.h"
#import <objc/message.h>
@interface AnimationVC10 ()
{
    UIScrollView *scrollView;
}
@property (nonatomic, strong) CAEmitterLayer *caELayer;
@end

@implementation AnimationVC10

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3.0, self.view.frame.size.height - 64);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)];
    bgImage.alpha = 0.5;
    [scrollView addSubview:bgImage];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
    [bgImage.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id) [UIColor orangeColor].CGColor,
                             (__bridge id) [UIColor yellowColor].CGColor,
                             (__bridge id) [UIColor greenColor].CGColor,
                             (__bridge id) [UIColor cyanColor].CGColor,
                             (__bridge id) [UIColor blueColor].CGColor,
                             (__bridge id)[UIColor purpleColor].CGColor];
    
    gradientLayer.locations = @[@0.0, @0.17, @0.34, @0.51, @0.68, @0.85, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}
- (void)rightAction {
    
    [self.caELayer removeFromSuperlayer];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)selectIndex:(NSInteger)index title:(NSString *)title {
    
    NSString *methodName = [NSString stringWithFormat:@"animation%zd",index+1];
    const char * method =[methodName UTF8String];
    objc_msgSend(self, sel_registerName(method));
}
#pragma mark - 烟花效果
- (void)animation1 {
    
    self.view.backgroundColor       = [UIColor blackColor];
    self.caELayer                   = [CAEmitterLayer layer];
    self.caELayer.emitterPosition   = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 50);
    self.caELayer.emitterSize       = CGSizeMake(50, 0);
    self.caELayer.emitterMode       = kCAEmitterLayerOutline;
    self.caELayer.emitterShape      = kCAEmitterLayerLine;
    self.caELayer.renderMode        = kCAEmitterLayerAdditive;
    self.caELayer.velocity          = 1;
    self.caELayer.seed              = (arc4random() % 100) + 1;

    CAEmitterCell *cell             = [CAEmitterCell emitterCell];
    cell.birthRate                  = 0.5;
    cell.emissionRange              = 0.11 * M_PI;
    cell.velocity                   = 300;
    cell.velocityRange              = 150;
    cell.yAcceleration              = 75;
    cell.lifetime                   = 2.04;
    cell.contents                   = (id)[[UIImage imageNamed:@"FFRing"] CGImage];
    cell.scale                      = 0.2;
    cell.color                      = [[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] CGColor];
    cell.greenRange                 = 1.0;
    cell.redRange                   = 1.0;
    cell.blueRange                  = 1.0;
    cell.spinRange                  = M_PI;
    
    CAEmitterCell *burst            = [CAEmitterCell emitterCell];
    burst.birthRate                 = 1.0;
    burst.velocity                  = 0;
    burst.scale                     = 2.5;
    burst.redSpeed                  = -1.5;
    burst.blueSpeed                 = +1.5;
    burst.greenSpeed                = +1.0;
    burst.lifetime                  = 0.35;

    CAEmitterCell *spark            = [CAEmitterCell emitterCell];
    spark.birthRate                 = 400;
    spark.velocity                  = 125;
    spark.emissionRange             = 2 * M_PI;
    spark.yAcceleration             = 75;
    spark.lifetime                  = 3;
    spark.contents                  = (id)[[UIImage imageNamed:@"FFTspark"] CGImage];
    spark.scaleSpeed                = -0.2;
    spark.greenSpeed                = -0.1;
    spark.redSpeed                  = 0.4;
    spark.blueSpeed                 = -0.1;
    spark.alphaSpeed                = -0.25;
    spark.spin                      = 2* M_PI;
    spark.spinRange                 = 2* M_PI;
    
    self.caELayer.emitterCells = [NSArray arrayWithObject:cell];
    cell.emitterCells = [NSArray arrayWithObjects:burst, nil];
    burst.emitterCells = [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:self.caELayer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
