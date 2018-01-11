//
//  ZZPendulumClockView.h
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/10.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSInteger, ShowType) {
    showQuartzClock = 1,        //石英钟
    showPendulumClock,          //摆钟
};
@interface ZZPendulumClockView : UIView
@property (nonatomic, assign) ShowType type;
@end
