//
//  Animation7PopVC.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/8.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "Animation7PopVC.h"
@interface Animation7PopVC ()

@end

@implementation Animation7PopVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"退出");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
