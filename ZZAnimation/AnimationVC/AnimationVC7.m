//
//  AnimationVC7.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/8.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "AnimationVC7.h"
#import "Animation7PopVC.h"
#import "JumpManager.h"
#import "BaseTableView.h"
#import <objc/message.h>
@interface AnimationVC7 ()
{
    JumpManager *manager;
    BaseTableView *tableview;
    NSArray *dataArray;
}
@end

@implementation AnimationVC7

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = @[@"扩散转场"];
    
    tableview = [[BaseTableView alloc] initWithFrame:self.view.bounds];
    tableview.delegate = self;
    tableview.dataArray = dataArray;
    [self.view addSubview:tableview];
}
- (void)selectIndex:(NSInteger)index title:(NSString *)title {
    
    NSString *methodName = [NSString stringWithFormat:@"present%zd",index+1];
    const char * method =[methodName UTF8String];
    objc_msgSend(self, sel_registerName(method));
}
- (void)present1 {
    Animation7PopVC *vc = [[Animation7PopVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
