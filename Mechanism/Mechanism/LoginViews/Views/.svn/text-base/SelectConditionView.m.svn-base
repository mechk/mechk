//
//  SelectConditionView.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/8/8.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "SelectConditionView.h"
#import "Contant.h"
#import "ConditionCell.h"

@interface SelectConditionView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, copy) NSString *leftTitle;

@end

@implementation SelectConditionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, kLayoutScreenHeight)];
        self.backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self addSubview:self.backView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewTaped:)];
        [self.backView addGestureRecognizer:tap];
    }
    return self;
}

- (void)backViewTaped:(UITapGestureRecognizer *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectConditionView:backViewDidClick:)]) {
        [self.delegate selectConditionView:self backViewDidClick:self.backView];
    }
    self.hidden = YES;
}

- (void)setLeftArray:(NSArray *)leftArray {
    _leftArray = leftArray;
    NSDictionary *dict = leftArray.firstObject;
    self.rightArray = dict[@"list"];
    [self.leftTableView reloadData];
}

- (void)setRightArray:(NSArray *)rightArray {
    _rightArray = rightArray;
    [self.rightTableView reloadData];
}

- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width / 2, KHEIGHT(490)) style:UITableViewStylePlain];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.tableFooterView = [[UIView alloc] init];
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_leftTableView];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2, 0, kLayoutScreenWidth / 2, KHEIGHT(490)) style:UITableViewStylePlain];
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.tableFooterView = [[UIView alloc] init];
        _rightTableView.separatorColor = [CommonTool colorWithHexString:@"#eeeeee"];
        [_rightTableView registerClass:[ConditionCell class] forCellReuseIdentifier:@"condition"];
        [self addSubview:_rightTableView];
    }
    return _rightTableView;
}

#pragma mark - tableView delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.leftArray.count;
    } else {
        return self.rightArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KHEIGHT(70);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] init];
        }
        cell.backgroundColor = kCommonBackgroundColor;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth / 2, KHEIGHT(70))];
        view.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = view;
        NSDictionary *dict = self.leftArray[indexPath.row];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KWIDTH(30), 0, tableView.bounds.size.width - KWIDTH(60), KHEIGHT(70))];
        label.font = [UIFont systemFontOfSize:KWIDTH(28)];
        label.textColor = kDarkLabelColor;
        label.text = dict[@"areaName"];
        [cell addSubview:label];
        return cell;
    } else {
        NSDictionary *dict = self.rightArray[indexPath.row];
        ConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"condition" forIndexPath:indexPath];
        cell.conditionLabel.text = dict[@"areaName"];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        NSDictionary *dict = self.leftArray[indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectConditionView:didSelectLeftRowAtIndex:withAreaCode:AreaName:)]) {
            [self.delegate selectConditionView:self didSelectLeftRowAtIndex:indexPath.row withAreaCode:[NSString stringWithFormat:@"%@", dict[@"areaCode"]] AreaName:[NSString stringWithFormat:@"%@", dict[@"areaName"]]];
        }
        self.leftTitle = [NSString stringWithFormat:@"%@", dict[@"areaName"]]; // 记录左侧title，选择全部时方便显示
        self.rightArray = dict[@"list"];
        [self.rightTableView reloadData];
        if (indexPath.row == 0) {
            self.hidden = YES;
        }
    } else {
        NSDictionary *dict = self.rightArray[indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectConditionView:didSelectRightRowAtIndex:withAreaCode:AreaName:)]) {
            if (indexPath.row == 0) {
                [self.delegate selectConditionView:self didSelectRightRowAtIndex:indexPath.row withAreaCode:[NSString stringWithFormat:@"%@", dict[@"areaCode"]] AreaName:self.leftTitle]; // 如果选择第一个（全部），显示左侧的名称
            } else {
                [self.delegate selectConditionView:self didSelectRightRowAtIndex:indexPath.row withAreaCode:[NSString stringWithFormat:@"%@", dict[@"areaCode"]] AreaName:[NSString stringWithFormat:@"%@", dict[@"areaName"]]];
            }
        }
        self.hidden = YES;
    }
}

@end
