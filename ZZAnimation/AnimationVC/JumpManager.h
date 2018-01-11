//
//  JumpManager.h
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/8.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSInteger, JumpMode) {
    GradualChangeMode = 1,
    DiffusanceMode,
};
@interface JumpManager : NSObject <UIViewControllerAnimatedTransitioning>
- (instancetype)initWithDelegate:(UIViewController *)delegate;
- (void)presentVC:(UIViewController *)toVC widthMode:(JumpMode)model;
@end
