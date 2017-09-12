//
//  DyPictureTableViewCell.m
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/11.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import "DyPictureTableViewCell.h"
#import <View+MASAdditions.h>
#import "SRPictureModel.h"
#import "SRPictureBrowser.h"

@interface DyPictureTableViewCell ()<SRPictureBrowserDelegate>

@property (nonatomic, strong) NSMutableArray *imageViewFrames;
@end
@implementation DyPictureTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.layoutMargins = UIEdgeInsetsZero;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setSeparatorInset:UIEdgeInsetsZero];
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews{
    self.orgHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30*scaleW,  150*scaleH-64, 80*scaleW,80*scaleH)];
    _orgHeadImageView.layer.cornerRadius = KWIDTH(40);
    _orgHeadImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_orgHeadImageView];
  
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoOrgDetail:)];
//        _orgHeadImageView.userInteractionEnabled = YES;
//        [_orgHeadImageView addGestureRecognizer:tap];
    
    
    _orgNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(130*scaleW, 173*scaleH-64, def_width -130*scaleW -10, 30*scaleH)];
    _orgNameLabel.font = [UIFont systemFontOfSize:KWIDTH(30)];
    _orgNameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_orgNameLabel];
  
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoOrgDetail:)];
//    _orgNameLabel.userInteractionEnabled = YES;
//    [_orgNameLabel addGestureRecognizer:tap];
    

    
    _imagesBackView = [[UIView alloc] init];
    _imagesBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_imagesBackView];
  

    
    _discLabel = [[UILabel alloc] init];
    _discLabel.font = [UIFont systemFontOfSize:KWIDTH(28)];
    _discLabel.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    _discLabel.numberOfLines = 0;
    [self.contentView addSubview:_discLabel];


    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeButton setImage:[UIImage imageNamed:@"Home_isliked_selected"] forState:UIControlStateNormal];
    [self.contentView addSubview:_likeButton];

   
    _likeLabel = [[UILabel alloc] init];
    _likeLabel.font = [UIFont systemFontOfSize:(KWIDTH(26))];
    _likeLabel.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    [self.contentView addSubview:_likeLabel];
  
   
    
    _likeImageView = [[UIImageView alloc] init];
    [self.likeButton addSubview:_likeImageView];
    [_likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KWIDTH(10));
        make.right.offset(KWIDTH(-10));
        make.top.offset(KWIDTH(10));
        make.bottom.offset(KWIDTH(-10));
    }];
    
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

//- (void)gotoOrgDetail:(UITapGestureRecognizer *)sender {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(homeImagesCellSelctOrgImage:)]) {
//        [self.delegate homeImagesCellSelctOrgImage:self];
//    }
//}

- (void)imageTapAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    
    UIImageView *tapedImageView = (UIImageView *)tapGestureRecognizer.view;
    NSMutableArray *imageBrowserModels = [[NSMutableArray alloc] init];
    NSInteger count = self.imagesArray.count;
    if (self.imagesArray.count > 3) {
        count = 3;
    }
    for (NSInteger i = 0; i < count; i++) {
        SRPictureModel *imageBrowserModel = [SRPictureModel sr_pictureModelWithPicURLString:self.imagesArray[i]
                                                                              containerView:nil
                                                                        positionInContainer:[self.imageViewFrames[i] CGRectValue]
                                                                                      index:i];
        [imageBrowserModels addObject:imageBrowserModel];
    }
    [SRPictureBrowser sr_showPictureBrowserWithModels:imageBrowserModels currentIndex:tapedImageView.tag delegate:self];
}

- (void)setImagesArray:(NSArray *)imagesArray {
    _imagesArray = imagesArray;
    if (imagesArray.count == 1) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, KWIDTH(450))];
        imageView.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imagesArray[0]] placeholderImage:[UIImage imageNamed:@"One_placehoder"]];
        [self.imagesBackView addSubview:imageView];
        
        [self.imageViewFrames addObject:[NSValue valueWithCGRect:imageView.frame]];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 0;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
        [imageView addGestureRecognizer:tapGestureRecognizer];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        
    } else if (imagesArray.count == 2) {
        for (int i = 0; i < 2; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((KWIDTH(372) + KWIDTH(6)) * i, 0, KWIDTH(372), KWIDTH(372))];
            imageView.backgroundColor =[UIColor colorWithHexString:@"#d8d8d8"];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imagesArray[i]] placeholderImage:[UIImage imageNamed:@"Two_placehoder"]];
            [self.imagesBackView addSubview:imageView];
            
            [self.imageViewFrames addObject:[NSValue valueWithCGRect:imageView.frame]];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i;
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
            [imageView addGestureRecognizer:tapGestureRecognizer];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
        }
    } else if (imagesArray.count >= 3) {
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((KWIDTH(248) + KWIDTH(3)) * i, 0, KWIDTH(248), KWIDTH(248))];
            imageView.backgroundColor = [UIColor colorWithHexString:@"#d8d8d8"];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imagesArray[i]] placeholderImage:[UIImage imageNamed:@"Three_placehoder"]];
            [self.imagesBackView addSubview:imageView];
            
            [self.imageViewFrames addObject:[NSValue valueWithCGRect:imageView.frame]];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i;
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
            [imageView addGestureRecognizer:tapGestureRecognizer];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
        }
    }
    
}
- (void)select:(DynamicModel *)dyModel{
    
    [self.orgHeadImageView sd_setImageWithURL:[NSURL URLWithString:dyModel.icon] placeholderImage:[UIImage imageNamed:@"LoseIcon"]];
    self.orgNameLabel.text = dyModel.name;
    self.imagesArray = dyModel.resourceList;
    self.discLabel.text  = dyModel.content;
    self.dateLabel.text = dyModel.time;
    self.likeLabel.text = dyModel.likedNum;
    self.commentLabel.text = dyModel.commentNum;
    __weak typeof(self) weakSelf = self;
    [_imagesBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orgHeadImageView.mas_bottom).offset(KHEIGHT(20));
        make.left.offset(0);
        make.right.offset(0);
        if (weakSelf.imagesArray.count == 1) {
            make.height.offset(KHEIGHT(450));
        } else if (weakSelf.imagesArray.count == 2) {
            make.height.offset(KHEIGHT(372));
        } else {
            make.height.offset(KHEIGHT(248));
        }
    }];
    [_discLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(KWIDTH(30));
        make.right.offset(KWIDTH(-30));
        make.top.equalTo(weakSelf.imagesBackView.mas_bottom).offset(KHEIGHT(20));
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
