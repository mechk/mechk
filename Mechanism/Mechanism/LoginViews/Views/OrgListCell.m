//
//  OrgListCell.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/8/8.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "OrgListCell.h"
#import "Contant.h"

@implementation OrgListCell

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        [_backImageView setImage:[UIImage imageNamed:@"Org_listcell_background"]];
        [self addSubview:_backImageView];
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(KWIDTH(17));
            make.right.offset(KWIDTH(-17));
            make.top.offset(KHEIGHT(10));
            make.bottom.offset(KHEIGHT(-5));
        }];
    }
    return _backImageView;
}

- (UIImageView *)orgImageView {
    if (!_orgImageView) {
        _orgImageView = [[UIImageView alloc] init];
        [self.backImageView addSubview:_orgImageView];
        [_orgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(KWIDTH(30));
            make.top.offset(KHEIGHT(30));
            make.width.offset(KWIDTH(140));
            make.height.offset(KWIDTH(140));
        }];
    }
    return _orgImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:KWIDTH(32)];
        _nameLabel.textColor = kDarkLabelColor;
        [self.backImageView addSubview:_nameLabel];
        __weak typeof(self) weakSelf = self;
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.orgImageView.mas_right).offset(KWIDTH(20));
            make.top.equalTo(weakSelf.orgImageView).offset(KHEIGHT(10));
            make.right.offset(0);
        }];
    }
    return _nameLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:KWIDTH(24)];
        _typeLabel.textColor = KDarkGrayColor;
        [self.backImageView addSubview:_typeLabel];
        __weak typeof(self) weakSelf = self;
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.nameLabel);
            make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(KHEIGHT(20));
            make.right.offset(0);
        }];
    }
    return _typeLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:KWIDTH(24)];
        _addressLabel.textColor = KDarkGrayColor;
        [self.backImageView addSubview:_addressLabel];
        __weak typeof(self) weakSelf = self;
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.nameLabel);
            make.top.equalTo(weakSelf.typeLabel.mas_bottom).offset(KHEIGHT(20));
            make.right.offset(KWIDTH(-150));
        }];
    }
    return _addressLabel;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.font = [UIFont systemFontOfSize:KWIDTH(24)];
        _distanceLabel.textColor = KDarkGrayColor;
        [self.backImageView addSubview:_distanceLabel];
        __weak typeof(self) weakSelf = self;
        [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(KWIDTH(-30));
            make.centerY.equalTo(weakSelf.addressLabel);
        }];
    }
    return _distanceLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        //        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        self.backgroundColor = kCommonBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
