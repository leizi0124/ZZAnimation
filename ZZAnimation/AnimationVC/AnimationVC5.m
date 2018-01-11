//
//  AnimationVC5.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/8.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "AnimationVC5.h"
#import "ZZSelectTableView.h"
@interface AnimationVC5 ()<CAAnimationDelegate, ZZSelectTableViewDelegate>
{
    UIView *animationView;
    ZZSelectTableView *selectTableView;
    NSMutableArray *dataArray;
    UIImageView *pointImage;
    __block UIDynamicAnimator *dyamic;
}

@end

@implementation AnimationVC5

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"复原" style:UIBarButtonItemStylePlain target:self action:@selector(defaultLocation)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    dataArray = [[NSMutableArray alloc] init];
    NSArray *array = @[@"重力行为",
                       @"碰撞行为 (可与重力行为配合使用 看效果)",
                       @"链接行为 (可与重力行为配合使用 看效果)",
                       @"推动行为（瞬间力）",
                       @"推动行为（持续力）",
                       @"吸引行为（延时0.5秒执行）"];
    
    for (NSString *title in array) {
        ZZModel *model = [[ZZModel alloc] init];
        model.title = title;
        [dataArray addObject:model];
    }
    
    selectTableView = [[ZZSelectTableView alloc] initWithFrame:self.view.bounds];
    selectTableView.delegate = self;
    selectTableView.dataArray = dataArray;
    [self.view addSubview:selectTableView];
    
    animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    animationView.center = self.view.center;
    animationView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:animationView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(baseAnimation)];
    [animationView addGestureRecognizer:tap];
    
    pointImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    pointImage.center = self.view.center;
    pointImage.layer.cornerRadius = 5;
    pointImage.backgroundColor = [UIColor grayColor];
    [self.view addSubview:pointImage];
    pointImage.hidden = YES;
}
- (void)selectIndex:(NSInteger)index isOn:(BOOL)isOn {
    
    ZZModel *model = dataArray[index];
    model.isOpen = isOn;
    selectTableView.dataArray = dataArray;
}
- (void)baseAnimation {
    
    /** 这个动画移动的是layer 当移动完成后，真正的视图其实还在原来的位置，需要在动画完成后将视图的位置进行调整 但是调整时会出现闪烁，效果不是很好*/
    NSLog(@"开始动画");
    //初始化管理者
    if (dyamic) {
        [dyamic removeAllBehaviors];
    }else {
        dyamic = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    
    ZZModel *attModel = [dataArray objectAtIndex:2];
    ZZModel *snapModel = [dataArray objectAtIndex:5];
    if (attModel.isOpen || snapModel.isOpen) {
        animationView.center = CGPointMake(self.view.center.x - 100, self.view.center.y);
    }
    
    pointImage.hidden = YES;
    
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZZModel *model = (ZZModel *)obj;
        
        if (model.isOpen) {
            NSLog(@"title == %@",model.title);
            switch (idx) {
                case 0:{
                    //重力行为
                    UIGravityBehavior *item = [[UIGravityBehavior alloc] initWithItems:@[animationView]];
                    [dyamic addBehavior:item];
                }
                    break;
                case 1:{
                    //碰撞行为
                    UICollisionBehavior *col = [[UICollisionBehavior alloc] initWithItems:@[animationView]];
                    col.translatesReferenceBoundsIntoBoundary = YES;
                    [dyamic addBehavior:col];
                }
                    break;
                case 2:{
                    //链接行为
                    pointImage.hidden = NO;
                    UIAttachmentBehavior *att = [[UIAttachmentBehavior alloc] initWithItem:animationView attachedToAnchor:self.view.center];
                    [dyamic addBehavior:att];
                }
                    break;
                case 3:{
                    //推动行为
                    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[animationView] mode:UIPushBehaviorModeInstantaneous];
                    push.angle = -M_PI / 4.0;
                    push.magnitude = 4;
                    [dyamic addBehavior:push];
                }
                    break;
                case 4:{
                    //推动行为
                    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[animationView] mode:UIPushBehaviorModeContinuous];
                    push.angle = -M_PI / 4.0;
                    push.magnitude = 4;
                    [dyamic addBehavior:push];
                }
                    break;
                case 5:{
                    //吸引行为
                    pointImage.hidden = NO;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:animationView snapToPoint:self.view.center];
                        snap.damping = 50;
                        [dyamic addBehavior:snap];
                    });
                }
                    break;
                default:
                    break;
            }
        }
    }];
}
- (void)defaultLocation {
    [dyamic removeAllBehaviors];
    animationView.center = self.view.center;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
