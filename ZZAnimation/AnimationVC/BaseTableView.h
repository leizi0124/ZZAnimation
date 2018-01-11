//
//  BaseTableView.h
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/4.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableView : UIView
@property (nonatomic, weak) id delegate;
@property (nonatomic, copy) NSArray *dataArray;
@end
@protocol BaseTableViewDelegate <NSObject>
- (void)selectIndex:(NSInteger)index title:(NSString *)title;
@end

