//
//  AnimationVC4.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/8.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "AnimationVC4.h"
#import "BaseTableView.h"
#import <objc/message.h>
@interface AnimationVC4 ()<BaseTableViewDelegate>
{
    BaseTableView *tableview;
    NSArray *dataArray;
    UIImageView *bgImage;
    NSString *selectImg;
}
@end
@implementation AnimationVC4

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = @[@"淡入淡出",
                  @"移到上方",
                  @"推开旧的",
                  @"移走旧的显示新的",
                  @"一下为私有模式",
                  @"立方体",
                  @"吸走",
                  @"前后翻转",
                  @"波纹",
                  @"翻页上",
                  @"翻页下",
                  @"镜头开",
                  @"镜头关"];
    
    tableview = [[BaseTableView alloc] initWithFrame:self.view.bounds];
    tableview.dataArray = dataArray;
    tableview.delegate = self;
    [self.view addSubview:tableview];
    
    selectImg = @"xzq1.jpg";
    bgImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImage.image = [UIImage imageNamed:selectImg];
    bgImage.alpha = 0.5;
    [self.view addSubview:bgImage];
}
- (void)selectIndex:(NSInteger)index title:(NSString *)title {
    
    if (index == 4) {
        return;
    }
    
    NSString *methodName = [NSString stringWithFormat:@"animation%zd",index+1];
    const char * method =[methodName UTF8String];
    objc_msgSend(self, sel_registerName(method));
}
- (void)animation1 {
    bgImage.image = [self otherImage];
    CATransition *trasition = [[CATransition alloc] init];
    trasition.type = kCATransitionFade;
    trasition.duration = 1.0;
    [bgImage.layer addAnimation:trasition forKey:@"trasition"];
}
- (void)animation2 {
    bgImage.image = [self otherImage];
    CATransition *trasition = [[CATransition alloc] init];
    trasition.type = kCATransitionMoveIn;
    trasition.duration = 1.0;
    [bgImage.layer addAnimation:trasition forKey:@"trasition"];
}
- (void)animation3 {
    bgImage.image = [self otherImage];
    CATransition *trasition = [[CATransition alloc] init];
    trasition.type = kCATransitionPush;
    trasition.duration = 1.0;
    [bgImage.layer addAnimation:trasition forKey:@"trasition"];
}
- (void)animation4 {
    bgImage.image = [self otherImage];
    CATransition *trasition = [[CATransition alloc] init];
    trasition.type = kCATransitionReveal;
    trasition.duration = 1.0;
    [bgImage.layer addAnimation:trasition forKey:@"trasition"];
}
- (void)animation6 {
    bgImage.image = [self otherImage];
    CATransition *trasition = [[CATransition alloc] init];
    trasition.type = @"cube";
    trasition.duration = 1.0;
    [bgImage.layer addAnimation:trasition forKey:@"trasition"];
}
- (void)animation7 {
    bgImage.image = [self otherImage];
    CATransition *trasition = [[CATransition alloc] init];
    trasition.type = @"suckEffect";
    trasition.duration = 1.0;
    [bgImage.layer addAnimation:trasition forKey:@"trasition"];
}
- (void)animation8 {
    bgImage.image = [self otherImage];
    CATransition *trasition = [[CATransition alloc] init];
    trasition.type = @"oglFlip";
    trasition.duration = 1.0;
    [bgImage.layer addAnimation:trasition forKey:@"trasition"];
}
- (void)animation9 {
    bgImage.image = [self otherImage];
    CATransition *trasition = [[CATransition alloc] init];
    trasition.type = @"rippleEffect";
    trasition.duration = 1.0;
    [bgImage.layer addAnimation:trasition forKey:@"trasition"];
}
- (void)animation10 {
    bgImage.image = [self otherImage];
    CATransition *trasition = [[CATransition alloc] init];
    trasition.type = @"pageCurl";
    trasition.duration = 1.0;
    [bgImage.layer addAnimation:trasition forKey:@"trasition"];
}
- (void)animation11 {
    bgImage.image = [self otherImage];
    CATransition *trasition = [[CATransition alloc] init];
    trasition.type = @"pageUnCurl";
    trasition.duration = 1.0;
    [bgImage.layer addAnimation:trasition forKey:@"trasition"];
}
- (void)animation12 {
    bgImage.image = [self otherImage];
    CATransition *trasition = [[CATransition alloc] init];
    trasition.type = @"cameraIrisHollowOpen";
    trasition.duration = 1.0;
    [bgImage.layer addAnimation:trasition forKey:@"trasition"];
}
- (void)animation13 {
    bgImage.image = [self otherImage];
    CATransition *trasition = [[CATransition alloc] init];
    trasition.type = @"cameraIrisHollowClose";
    trasition.duration = 1.0;
    [bgImage.layer addAnimation:trasition forKey:@"trasition"];
}
- (UIImage *)otherImage {
    if ([selectImg isEqualToString:@"xzq1.jpg"]) {
        selectImg = @"xzq2.jpg";
    }else {
        selectImg = @"xzq1.jpg";
    }
    return [UIImage imageNamed:selectImg];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
