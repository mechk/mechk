//
//  DyVideoTableViewCell.m
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/11.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import "DyVideoTableViewCell.h"

@interface DyVideoTableViewCell ()
@property (nonatomic, strong) UIImageView *orgHeadImageView;
@property (nonatomic, strong) UILabel *orgNameLabel;
@property (nonatomic, strong) UILabel *discLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UIImageView *likeImageView;

@end

@implementation DyVideoTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        self.layoutMargins = UIEdgeInsetsZero;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setSeparatorInset:UIEdgeInsetsZero];
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews{
    _orgHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30*scaleW,  150*scaleH-64, 80*scaleW,80*scaleH)];
    _orgHeadImageView.layer.cornerRadius = KWIDTH(40);
    _orgHeadImageView.layer.masksToBounds = YES;
    [self addSubview:_orgHeadImageView];
    
    _orgNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(130*scaleW, 173*scaleH-64, def_width -130*scaleW -10, 30*scaleH)];
    _orgNameLabel.font = [UIFont systemFontOfSize:KWIDTH(30)];
    _orgNameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_orgNameLabel];
    
    _videoImageView = [[UIImageView alloc] init];
    _videoImageView.userInteractionEnabled = YES;
    [self addSubview:_videoImageView];
    __weak typeof(self) weakSelf = self;
    [_videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orgHeadImageView.mas_bottom).offset(KHEIGHT(20));
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(KHEIGHT(450));
    }];
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setBackgroundImage:[UIImage imageNamed:@"Home_video_play"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.videoImageView addSubview:_playButton];
 
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.videoImageView);
        make.centerY.equalTo(weakSelf.videoImageView);
        make.height.offset(KWIDTH(120));
        make.width.offset(KWIDTH(120));
    }];
    
    _discLabel = [[UILabel alloc] init];
    _discLabel.font = [UIFont systemFontOfSize:KWIDTH(28)];
    _discLabel.textColor = kDarkLabelColor;
    _discLabel.numberOfLines = 0;
    [self addSubview:_discLabel];
 
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeButton setImage:[UIImage imageNamed:@"Home_isliked_selected"] forState:UIControlStateNormal];
    [self.contentView addSubview:_likeButton];
    
    
    _likeLabel = [[UILabel alloc] init];
    _likeLabel.font = [UIFont systemFontOfSize:(KWIDTH(26))];
    _likeLabel.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    [self.contentView addSubview:_likeLabel];
    
    
    
    _likeImageView = [[UIImageView alloc] init];
    [self.likeButton addSubview:_likeImageView];
  
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentButton setImage:[UIImage imageNamed:@"Home_comment"] forState:UIControlStateNormal];
    _commentButton.showsTouchWhenHighlighted = YES;
    [self.contentView addSubview:_commentButton];
    
    
    _commentLabel = [[UILabel alloc] init];
    _commentLabel.font = MainFontOfSize(KWIDTH(26));
    _commentLabel.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    [self.contentView addSubview:_commentLabel];
    
    
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareButton setImage:[UIImage imageNamed:@"Home_share"] forState:UIControlStateNormal];
    
    _shareButton.showsTouchWhenHighlighted = YES;
    [self.contentView addSubview:_shareButton];
    
    
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = [UIFont systemFontOfSize:KWIDTH(30)];
    _dateLabel.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    [self.contentView addSubview:_dateLabel];

  
}
- (void)playButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeViedoCellPlayButtonClicked:)]) {
        [self.delegate homeViedoCellPlayButtonClicked:self];
    }
}
- (void)select:(DynamicModel *)dyModel{
    [self.orgHeadImageView sd_setImageWithURL:[NSURL URLWithString:dyModel.icon] placeholderImage:[UIImage imageNamed:@"LoseIcon"]];
    self.orgNameLabel.text = dyModel.name;
   // self.imagesArray = dyModel.resourceList;
    self.discLabel.text  = dyModel.content;
    self.dateLabel.text = dyModel.time;
    self.likeLabel.text = dyModel.likedNum;
    self.commentLabel.text = dyModel.commentNum;
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString:dyModel.mailPic] placeholderImage:nil];
    
    __weak typeof(self) weakSelf = self;
    
    [_videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orgHeadImageView.mas_bottom).offset(KHEIGHT(20));
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(KHEIGHT(450));
    }];
    [_discLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KWIDTH(30));
        make.right.offset(KWIDTH(-30));
        make.top.equalTo(weakSelf.videoImageView.mas_bottom).offset(KHEIGHT(20));
    }];
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(KWIDTH(-60));
        make.top.equalTo(weakSelf.discLabel.mas_bottom).offset(KHEIGHT(20));
        make.height.offset(KWIDTH(100));
        make.width.offset(KWIDTH(100));
    }];
    [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.likeButton);
        make.left.equalTo(weakSelf.likeButton.mas_right);
    }];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.likeButton);
        make.right.equalTo(weakSelf.likeButton.mas_left).offset(KWIDTH(-70));
        make.width.equalTo(weakSelf.likeButton);
        make.height.equalTo(weakSelf.likeButton);
    }];
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.commentButton);
        make.left.equalTo(weakSelf.commentButton.mas_right);
    }];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.commentButton);
        make.right.equalTo(weakSelf.commentButton.mas_left).offset(KWIDTH(-70));
        make.width.equalTo(weakSelf.commentButton);
        make.height.equalTo(weakSelf.commentButton);
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KWIDTH(30));
        make.centerY.equalTo(weakSelf.shareButton);
    }];
    
}
@end
