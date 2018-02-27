//
//  JumpManager.h
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/8.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^GestureConifg)();

typedef NS_ENUM(NSUInteger, XWInteractiveTransitionGestureDirection) {//手势的方向
    XWInteractiveTransitionGestureDirectionLeft = 0,
    XWInteractiveTransitionGestureDirectionRight,
    XWInteractiveTransitionGestureDirectionUp,
    XWInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, XWInteractiveTransitionType) {//手势控制哪种转场
    XWInteractiveTransitionTypePresent = 0,
    XWInteractiveTransitionTypeDismiss,
    XWInteractiveTransitionTypePush,
    XWInteractiveTransitionTypePop,
};

@interface JumpManager : UIPercentDrivenInteractiveTransition
/**记录是否开始手势，判断pop操作是手势触发还是返回键触发*/
@property (nonatomic, assign) BOOL interation;
/**促发手势present的时候的config，config中初始化并present需要弹出的控制器*/
@property (nonatomic, copy) GestureConifg presentConifg;
/**促发手势push的时候的config，config中初始化并push需要弹出的控制器*/
@property (nonatomic, copy) GestureConifg pushConifg;

//初始化方法

+ (instancetype)interactiveTransitionWithTransitionType:(XWInteractiveTransitionType)type GestureDirection:(XWInteractiveTransitionGestureDirection)direction;
- (instancetype)initWithTransitionType:(XWInteractiveTransitionType)type GestureDirection:(XWInteractiveTransitionGestureDirection)direction;

/** 给传入的控制器添加手势*/
- (void)addPanGestureForViewController:(UIViewController *)viewController;
@end
