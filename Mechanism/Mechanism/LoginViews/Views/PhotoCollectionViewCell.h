//
//  PhotoCollectionViewCell.h
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/6/6.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoCollectionViewCell;

@protocol PhotoCollectionViewCellDelegate <NSObject>

- (void)photoCollectionViewCell:(PhotoCollectionViewCell *)cell selectedButtonClicked:(UIButton *)sender;

@end

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UIButton *selectedButton;

@property (nonatomic, weak) id<PhotoCollectionViewCellDelegate>delegate;


+ (CGSize)size;

@end
