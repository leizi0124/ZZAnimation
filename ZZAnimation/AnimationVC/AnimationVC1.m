//
//  AnimationVC1.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/3.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "AnimationVC1.h"
#import "BaseTableView.h"
#import <objc/message.h>
@interface AnimationVC1 ()<BaseTableViewDelegate>
{
    BaseTableView *tableview;
    NSArray *dataArray;
    UIView *animationView;
}
@end
@implementation AnimationVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = @[@"UIView:[beginAnimations:->commitAnimations]",
                  @"UIView animateWithDuration:animations:completion:"];
    
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
}
- (void)selectIndex:(NSInteger)index title:(NSString *)title {
    
    NSString *methodName = [NSString stringWithFormat:@"animation%zd",index+1];
    const char * method =[methodName UTF8String];
    objc_msgSend(self, sel_registerName(method));
}
#pragma mark - UIView:[beginAnimations:->commitAnimations]
- (void)animation1 {
    [UIView beginAnimations:@"viewanimation" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    animationView.frame = self.view.bounds;
    animationView.backgroundColor = [UIColor redColor];
    animationView.alpha = 1;
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self animationDefault];
    });
}
#pragma mark - UIView animateWithDuration:animations:
- (void)animation2 {
    [UIView animateWithDuration:1.0 animations:^{
        animationView.frame = self.view.bounds;
        animationView.backgroundColor = [UIColor greenColor];
        animationView.alpha = 1;
    } completion:^(BOOL finished) {
        [self animationDefault];
    }];
}
- (void)animationDefault {
    animationView.frame = CGRectMake(0, 0, 100, 100);
    animationView.center = self.view.center;
    animationView.backgroundColor = [UIColor blackColor];
    animationView.alpha = 0.5;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
