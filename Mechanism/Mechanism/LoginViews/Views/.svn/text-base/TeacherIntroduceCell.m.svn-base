//
//  TeacherIntroduceCell.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/8/24.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "TeacherIntroduceCell.h"
#import "Contant.h"

@implementation TeacherIntroduceCell

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = KWIDTH(60);
        _headImageView.layer.masksToBounds = YES;
        [self addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(0);
            make.width.offset(KWIDTH(120));
            make.height.offset(KWIDTH(120));
        }];
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:KWIDTH(26)];
        _nameLabel.textColor = kDarkLabelColor;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLabel];
        __weak typeof(self) weakSelf = self;
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(weakSelf.headImageView.mas_bottom).offset(KHEIGHT(25));
        }];
    }
    return _nameLabel;
}

+ (CGSize)size {
    return CGSizeMake(KWIDTH(120), KWIDTH(170));
}

@end
