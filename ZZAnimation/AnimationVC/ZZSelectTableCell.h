//
//  ZZSelectTableCell.h
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/4.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZModel.h"
@interface ZZSelectTableCell : UITableViewCell
@property (nonatomic, weak) id delegate;
- (void)updateWith:(ZZModel *)model;
@end
@protocol ZZSelectTableCellDelegate <NSObject>
- (void)selectCell:(ZZSelectTableCell *)cell isOn:(BOOL)isOn;
@end

