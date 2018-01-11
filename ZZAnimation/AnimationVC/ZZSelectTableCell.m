//
//  ZZSelectTableCell.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/4.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "ZZSelectTableCell.h"
@interface ZZSelectTableCell ()
{
    UISwitch *mySwitch;
    ZZModel *selectModel;
}
@end
@implementation ZZSelectTableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        mySwitch = [[UISwitch alloc] init];
        [mySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        mySwitch.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - mySwitch.frame.size.width - 10, (self.frame.size.height - mySwitch.frame.size.height) / 2.0, 0, 0);
        [self addSubview:mySwitch];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)updateWith:(ZZModel *)model {
    selectModel = model;
    self.textLabel.text = model.title;
    mySwitch.on = model.isOpen;
}
- (void)switchAction:(UISwitch *)mySwitch {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectCell:isOn:)]) {
        [self.delegate selectCell:self isOn:mySwitch.isOn];
    }
    
    selectModel.isOpen = mySwitch.on;
}
@end
