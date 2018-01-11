//
//  AnimationVC6.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/8.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "AnimationVC6.h"

@interface AnimationVC6 ()
{
    UIImageView *bg;
    UIImageView *yurt2;
    UIImageView *yurt1;
    UIImageView *ship;
    UIImageView *octocat;
    UIImageView *text;
}
@end

@implementation AnimationVC6

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat vheight = self.view.frame.size.height;
    CGFloat vwidth = self.view.frame.size.width;
    
    bg = [self addImageView:CGRectMake(-100, -100, vwidth + 200, vheight + 200) imageName:@"bg.jpeg"];
    yurt1 = [self addImageView:CGRectMake(vwidth-250, vheight/2-100, 200, 75) imageName:@"yurt1"];
    yurt2 = [self addImageView:CGRectMake(vwidth-140, vheight/2-150, 120, 50) imageName:@"yurt2"];
    ship = [self addImageView:CGRectMake(vwidth/3, vheight/2, vwidth/3*2, vwidth/3) imageName:@"ship"];
    text = [self addImageView:CGRectMake(20, vheight/3*2, vwidth/3, vwidth/3) imageName:@"text"];
    octocat = [self addImageView:CGRectMake(vwidth/2-vwidth/6+40, vheight/3*2, vwidth/3, vwidth/3*1.2) imageName:@"octocat"];
    
    [self addEffect:100 View:bg];
    [self addEffect:120 View:yurt2];
    [self addEffect:160 View:yurt1];
    [self addEffect:300 View:ship];
    [self addEffect:20 View:octocat];
    [self addEffect:50 View:text];
}
- (void)addEffect:(int)scop View:(UIView *)view {
    UIInterpolatingMotionEffect *hEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    [hEffect setMinimumRelativeValue:[NSNumber numberWithInt:-scop]];
    [hEffect setMaximumRelativeValue:[NSNumber numberWithInt:scop]];
    
    UIInterpolatingMotionEffect *vEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    [vEffect setMinimumRelativeValue:[NSNumber numberWithInt:-scop]];
    [vEffect setMaximumRelativeValue:[NSNumber numberWithInt:scop]];
    
    UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
    group.motionEffects = @[hEffect, vEffect];
    [view addMotionEffect:group];
}
- (UIImageView *)addImageView:(CGRect)frame imageName:(NSString *)imageName {
    UIImageView *image = [[UIImageView alloc] init];
    image.frame = frame;
    image.image = [UIImage imageNamed:imageName];
    [self.view addSubview:image];
    return image;
}
@end
