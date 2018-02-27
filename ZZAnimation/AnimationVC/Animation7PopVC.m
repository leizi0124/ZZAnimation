//
//  Animation7PopVC.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/8.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "Animation7PopVC.h"
#import "XWCircleSpreadTransition.h"
#import "JumpManager.h"
@interface Animation7PopVC ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) JumpManager *interactiveTransition;
@end

@implementation Animation7PopVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.interactiveTransition = [JumpManager interactiveTransitionWithTransitionType:XWInteractiveTransitionTypeDismiss GestureDirection:XWInteractiveTransitionGestureDirectionDown];
    [self.interactiveTransition addPanGestureForViewController:self];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"退出");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [XWCircleSpreadTransition transitionWithTransitionType:XWCircleSpreadTransitionTypePresent];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [XWCircleSpreadTransition transitionWithTransitionType:XWCircleSpreadTransitionTypeDismiss];
}
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _interactiveTransition.interation ? _interactiveTransition : nil;
}
@end
