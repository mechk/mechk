//
//  ConditionCell.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/8/16.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "ConditionCell.h"
#import "Contant.h"

@implementation ConditionCell

- (UILabel *)conditionLabel {
    if (!_conditionLabel) {
        _conditionLabel = [[UILabel alloc] init];
        _conditionLabel.font = [UIFont systemFontOfSize:KWIDTH(28)];
        _conditionLabel.textColor = kDarkLabelColor;
        [self addSubview:_conditionLabel];
        [_conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(KWIDTH(30));
            make.centerY.offset(0);
        }];
    }
    return _conditionLabel;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont systemFontOfSize:KWIDTH(28)];
        _numberLabel.textColor = KDarkGrayColor;
        [self addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(KWIDTH(-30));
            make.centerY.offset(0);
        }];
    }
    return _numberLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        //        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
    }
    return self;
}

@end
