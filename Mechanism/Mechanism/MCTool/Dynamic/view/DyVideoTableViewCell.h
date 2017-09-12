//
//  DyVideoTableViewCell.h
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/11.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
@class DyVideoTableViewCell;
@protocol HomeVideoCellDelegate <NSObject>

//- (void)homeVideoCellSelctOrgImage:(DyVideoTableViewCell *)cell;

- (void)homeViedoCellPlayButtonClicked:(DyVideoTableViewCell *)cell;

@end
@interface DyVideoTableViewCell : UITableViewCell
- (void)select:(DynamicModel *)dyModel;
@property (nonatomic, assign) id<HomeVideoCellDelegate> delegate;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UIButton *playButton;
@end
