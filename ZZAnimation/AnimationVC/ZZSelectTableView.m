//
//  ZZSelectTableView.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/4.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "ZZSelectTableView.h"
#import "ZZSelectTableCell.h"
@interface ZZSelectTableView ()<UITableViewDelegate, UITableViewDataSource, ZZSelectTableCellDelegate>
{
    UITableView *tableview;
}
@end
@implementation ZZSelectTableView
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = [[UIView alloc] init];
        [self addSubview:tableview];
        [tableview registerClass:[ZZSelectTableCell class] forCellReuseIdentifier:@"ZZSelectTableCell"];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZSelectTableCell *cell = [tableview dequeueReusableCellWithIdentifier:@"ZZSelectTableCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ZZSelectTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZZSelectTableCell"];
    }
    cell.delegate = self;
    ZZModel *model = _dataArray[indexPath.row];
    [cell updateWith:model]; 
    
    return cell;
}
- (void)selectCell:(ZZSelectTableCell *)cell isOn:(BOOL)isOn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectIndex:isOn:)]) {
        NSInteger index = [tableview indexPathForCell:cell].row;
        [self.delegate selectIndex:index isOn:isOn];
    }
}
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [tableview reloadData];
}
@end
