//
//  ViewController.m
//  ZZAnimation
//
//  Created by JB-Mac on 2017/10/23.
//  Copyright © 2017年 ZZAnimation. All rights reserved.
//

#import "ViewController.h"
#import "AnimationVC1.h"
#import "BaseTableView.h"
#import <objc/message.h>
@interface ViewController ()<BaseTableViewDelegate>
{
    BaseTableView *tableview;
    NSArray *dataArray;
}
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"动画";
    
    dataArray = @[@"UIView 基础动画 + CALayer",
                  @"CABasicAnimation 动画",
                  @"CAKeyframeAnimation 关键帧动画",
                  @"CATransition 转场动画",
                  @"Dynamics 力学动画",
                  @"MotionEffects 透视效果",
                  @"控制器转场动画",
                  @"时钟",
                  @"水球",
                  @"粒子发射器"];
    
    tableview = [[BaseTableView alloc] initWithFrame:self.view.bounds];
    tableview.dataArray = dataArray;
    tableview.delegate = self;
    [self.view addSubview:tableview];
}
- (void)selectIndex:(NSInteger)index title:(NSString *)title {
    NSString *className = [NSString stringWithFormat:@"AnimationVC%zd",index+1];
    const char * name =[className UTF8String];
    Class vcClass = objc_getClass(name);
    
    UIViewController *vc = [[vcClass alloc] init];
    vc.title = dataArray[index];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
