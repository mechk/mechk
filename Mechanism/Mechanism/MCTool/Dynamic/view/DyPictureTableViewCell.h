//
//  DyPictureTableViewCell.h
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/11.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
@interface DyPictureTableViewCell : UITableViewCell
//头像
@property (nonatomic, strong) UIImageView *orgHeadImageView;
@property (nonatomic, strong) UIImageView *circleImageView;   // 圈注皇冠

//名字
@property (nonatomic, strong) UILabel *orgNameLabel;

@property (nonatomic, strong) UIButton *orgTypeButton;
@property (nonatomic, strong) UIButton  *auditionButton;

//题目
@property (nonatomic, strong) UILabel *discLabel;
//时间
@property (nonatomic, strong) UILabel *dateLabel;

//分享
@property (nonatomic, strong) UIButton *shareButton;
//评论
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UILabel *commentLabel;
//喜欢
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UIImageView *likeImageView;


@property (nonatomic, strong) UIView *imagesBackView;
@property (nonatomic, copy) NSArray *imagesArray;

//@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, assign) NSInteger type;  // 0 : 视频    ，   1 : 图片

@property (nonatomic, assign) NSInteger orgType;
- (void)select:(DynamicModel *)dyModel;

@end
