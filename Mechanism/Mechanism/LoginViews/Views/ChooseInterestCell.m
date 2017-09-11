//
//  ChooseInterestCell.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/7/25.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "ChooseInterestCell.h"
#import "Contant.h"

@implementation ChooseInterestCell

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        [self addSubview:_backImageView];
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.top.offset(0);
            make.bottom.offset(0);
        }];
    }
    return _backImageView;
}

- (UILabel *)categoryLabel {
    if (!_categoryLabel) {
        _categoryLabel = [[UILabel alloc] init];
        _categoryLabel.font = [UIFont systemFontOfSize:KWIDTH(32)];
        _categoryLabel.textColor = [UIColor whiteColor];
        [self addSubview:_categoryLabel];
        [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(0);
        }];
    }
    return _categoryLabel;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"Interest_normal"] forState:UIControlStateNormal];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"Interest_selected"] forState:UIControlStateSelected];
        _selectButton.userInteractionEnabled = NO;
        [self addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(KHEIGHT(20));
            make.right.offset(KWIDTH(-20));
            make.width.offset(KWIDTH(34));
            make.height.offset(KHEIGHT(30));
        }];
    }
    return _selectButton;
}

+ (CGSize)size {
    return CGSizeMake((kLayoutScreenWidth - KWIDTH(100)) / 2, KHEIGHT(180));
}


@end
