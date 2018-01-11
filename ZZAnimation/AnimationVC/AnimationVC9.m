//
//  AnimationVC9.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/10.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "AnimationVC9.h"
#import "ZZWaterBallView.h"
@interface AnimationVC9 ()
{
    ZZWaterBallView *waterBall;
}
@end

@implementation AnimationVC9

- (void)viewDidLoad {
    [super viewDidLoad];
    waterBall = [[ZZWaterBallView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    waterBall.center = self.view.center;
    [self.view addSubview:waterBall];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, self.view.frame.size.height - 100, self.view.frame.size.width - 100, 50)];
    [slider addTarget:self action:@selector(progressAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}
- (void)progressAction:(UISlider *)slider {
    [waterBall updateProgress:slider.value];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
