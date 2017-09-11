//
//  OrgListView.m
//  RPRingedPages
//
//  Created by Mac02Nvisoft on 2017/6/29.
//  Copyright © 2017年 Ding. All rights reserved.
//

#import "OrgListView.h"
#import "Contant.h"

@implementation OrgListView

- (UIImageView *)headImageView {
    if (!_headImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImage:[UIImage imageNamed:@"Org_list_card"]];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.bottom.offset(0);
            make.left.offset(0);
            make.right.offset(0);
        }];
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = KWIDTH(30);
        _headImageView.layer.masksToBounds = YES;
//        _headImageView.frame = CGRectMake(10, 10, KWIDTH(80), KWIDTH(80));
//        _headImageView.backgroundColor = [UIColor greenColor];
        [self addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(KWIDTH(30));
            make.left.offset(KWIDTH(30));
            make.width.offset(KWIDTH(60));
            make.height.offset(KWIDTH(60));
        }];
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:KWIDTH(36)];
        _nameLabel.textColor = KCommonLabelColor;
        [self addSubview:_nameLabel];
        __weak typeof(self) weakSelf = self;
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.headImageView);
            make.left.equalTo(weakSelf.headImageView.mas_right).offset(KWIDTH(10));
        }];
    }
    return _nameLabel;
}

- (UIButton *)typeButton {
    if (!_typeButton) {
        _typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_typeButton];
        __weak typeof(self) weakSelf = self;
        [_typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.nameLabel.mas_right).offset(KWIDTH(10));
            make.centerY.equalTo(weakSelf.nameLabel);
        }];
    }
    return _typeButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
//        _imageView.backgroundColor = [UIColor yellowColor];
//        _imageView.frame = CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame) + 10, self.bounds.size.width, 200);
        [self addSubview:_imageView];
        __weak typeof(self) weakSelf = self;
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.headImageView.mas_bottom).offset(KHEIGHT(20));
            make.left.offset(KWIDTH(7));
            make.right.offset(KWIDTH(-14));
            make.height.offset(KHEIGHT(400));
        }];
    }
    return _imageView;
}

- (UILabel *)discLabel {
    if (!_discLabel) {
        _discLabel = [[UILabel alloc] init];
        _discLabel.textColor = kDarkLabelColor;
        _discLabel.numberOfLines = 0;
        _discLabel.font = [UIFont systemFontOfSize:KWIDTH(28)];
        [self addSubview:_discLabel];
        __weak typeof(self) weakSelf = self;
        [_discLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.imageView.mas_bottom).offset(KHEIGHT(36));
            make.left.offset(KWIDTH(25));
            make.right.offset(KWIDTH(-25));
            make.bottom.lessThanOrEqualTo(weakSelf.imageView.mas_bottom).offset(KHEIGHT(260));
        }];
    }
    return _discLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImage:[UIImage imageNamed:@"Org_list_address@3x"]];
        [self addSubview:imageView];
        __weak typeof(self) weakSelf = self;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(KWIDTH(20));
            make.top.equalTo(weakSelf.imageView.mas_bottom).offset(KHEIGHT(280));
            make.width.offset(KWIDTH(19));
            make.height.offset(KHEIGHT(26));
        }];
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.textColor = kDarkLabelColor;
        _addressLabel.numberOfLines = 2;
        _addressLabel.font = [UIFont systemFontOfSize:KWIDTH(30)];
        [self addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView).offset(KWIDTH(-5));
            make.left.equalTo(imageView.mas_right).offset(KWIDTH(10));
            make.right.lessThanOrEqualTo(weakSelf.mas_right).offset(KWIDTH(-25));
        }];
    }
    return _addressLabel;
}

- (UIButton *)joinButton {
    if (!_joinButton) {
        _joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _joinButton.titleLabel.font = [UIFont systemFontOfSize:KWIDTH(30)];
        [_joinButton setBackgroundImage:[UIImage imageNamed:@"Org_list_join_button"] forState:UIControlStateNormal];
        [_joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _joinButton.showsTouchWhenHighlighted = YES;
        [self addSubview:_joinButton];
        __weak typeof(self) weakSelf = self;
        [_joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(weakSelf.imageView.mas_bottom).offset(KWIDTH(367));
            make.width.offset(KWIDTH(200));
            make.height.offset(KHEIGHT(80));
        }];
    }
    return _joinButton;
}

@end
