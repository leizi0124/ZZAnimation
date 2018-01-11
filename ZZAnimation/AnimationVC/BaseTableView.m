//
//  BaseTableView.m
//  ZZAnimation
//
//  Created by JB-Mac on 2018/1/4.
//  Copyright © 2018年 ZZAnimation. All rights reserved.
//

#import "BaseTableView.h"
@interface BaseTableView ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *tableview;
}
@end
@implementation BaseTableView
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = [[UIView alloc] init];
        [self addSubview:tableview];
        [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"animationcell"];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"animationcell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableviewcell"];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectIndex:title:)]) {
        [self.delegate selectIndex:indexPath.row title:_dataArray[indexPath.row]];
    }
}
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [tableview reloadData];
}
@end
