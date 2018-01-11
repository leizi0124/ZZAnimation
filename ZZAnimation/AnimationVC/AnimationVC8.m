//
//  AnimationVC8.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/9.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "AnimationVC8.h"
#import "ZZClockView.h"
#import "ZZPendulumClockView.h"
@interface AnimationVC8 ()
{
    ZZClockView *clockView;
    ZZPendulumClockView *pendulumClockView;
}
@end

@implementation AnimationVC8

- (void)viewDidLoad {
    [super viewDidLoad];
    
    clockView = [[ZZClockView alloc] initWithFrame:CGRectMake(0, 0, 200, 70)];
    clockView.center = CGPointMake(self.view.center.x, 130);
    [self.view addSubview:clockView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 70, 100, 30)];
    label.text = @"显示秒";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UISwitch *mySwitch = [[UISwitch alloc] init];
    mySwitch.center = CGPointMake(self.view.frame.size.width - 50, 140);
    [mySwitch addTarget:self action:@selector(showSecondView:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySwitch];
    
    pendulumClockView = [[ZZPendulumClockView alloc] initWithFrame:self.view.bounds];
    pendulumClockView.type = showQuartzClock;
    [self.view addSubview:pendulumClockView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 250, 100, 30)];
    label1.text = @"钟摆";
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    UISwitch *mySwitch1 = [[UISwitch alloc] init];
    mySwitch1.center = CGPointMake(self.view.frame.size.width - 50, 300);
    [mySwitch1 addTarget:self action:@selector(changType:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySwitch1];
}
- (void)showSecondView:(UISwitch *)mySwitch {
    clockView.showSeconds = mySwitch.on;
    if (mySwitch.on) {
        clockView.frame = CGRectMake(0, 0, 260, 70);
    }else {
        clockView.frame = CGRectMake(0, 0, 200, 70);
    }
    clockView.center = CGPointMake(self.view.center.x, 130);
}
- (void)changType:(UISwitch *)mySwitch {
    
    if (mySwitch.on) {
        pendulumClockView.type = showPendulumClock;
    }else {
        pendulumClockView.type = showQuartzClock;
    }
    clockView.center = CGPointMake(self.view.center.x, 130);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
