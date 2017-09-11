//
//  PhotoCollectionViewCell.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/6/6.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "Masonry.h"
#import "Contant.h"
#import "CommonTool.h"

@implementation PhotoCollectionViewCell

- (UIImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImageView.clipsToBounds = YES;
        _photoImageView.layer.cornerRadius = KWIDTH(6);
        [self.contentView addSubview:_photoImageView];
         if (self.type == 2) {
             [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.offset(0);
                 make.right.offset(KWIDTH(0));
                 make.top.offset(KWIDTH(0));
                 make.bottom.offset(0);
             }];
         } else {
             [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.offset(0);
                 make.right.offset(KWIDTH(-20));
                 make.top.offset(KWIDTH(20));
                 make.bottom.offset(0);
             }];
         }
    }
    return _photoImageView;
}

- (UIButton *)selectedButton {
    if (!_selectedButton) {
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectedButton];
        __weak typeof(self) weakSelf = self;
        if (self.type == 2) {
            [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(0);
                make.top.offset(0);
                make.width.offset(KWIDTH(40));
                make.height.offset(KWIDTH(40));
            }];
        } else {
            [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.photoImageView.mas_right);
                make.centerY.equalTo(weakSelf.photoImageView.mas_top);
                //            make.right.offset(0);
                //            make.top.offset(0);
                make.width.offset(KWIDTH(40));
                make.height.offset(KWIDTH(40));
            }];
        }
    }
    return _selectedButton;
}

- (void)selectedButtonAction:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(photoCollectionViewCell:selectedButtonClicked:)]) {
        [_delegate photoCollectionViewCell:self selectedButtonClicked:sender];
    }

}

+ (CGSize)size {
    return CGSizeMake(KWIDTH(220), KWIDTH(220));
}

@end
