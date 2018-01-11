//
//  ZZSelectTableView.h
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/4.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZModel.h"
@interface ZZSelectTableView : UIView
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSArray *dataArray;
@end
@protocol ZZSelectTableViewDelegate <NSObject>
- (void)selectIndex:(NSInteger)index isOn:(BOOL)isOn;
@end
