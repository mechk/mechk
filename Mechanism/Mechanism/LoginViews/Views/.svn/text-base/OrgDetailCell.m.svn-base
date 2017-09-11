//
//  OrgDetailCell.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/8/24.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "OrgDetailCell.h"
#import "Contant.h"
#import "SRPictureBrowser.h"
#import "SRPictureModel.h"

@interface OrgDetailCell () <SRPictureBrowserDelegate>

@property (nonatomic, strong) NSMutableArray *imageViewFrames;
@property (nonatomic, copy) NSMutableArray *imagesArray;
@end

@implementation OrgDetailCell

- (UIImageView *)orgHeadImageView {
    if (!_orgHeadImageView) {
        _orgHeadImageView = [[UIImageView alloc] init];
        _orgHeadImageView.layer.cornerRadius = KWIDTH(50);
        _orgHeadImageView.layer.masksToBounds = YES;
        [self addSubview:_orgHeadImageView];
        [_orgHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(KWIDTH(100));
            make.width.offset(KWIDTH(100));
            make.top.offset(KHEIGHT(20));
            make.left.offset(KWIDTH(30));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoOrgDetail:)];
        _orgHeadImageView.userInteractionEnabled = YES;
        [_orgHeadImageView addGestureRecognizer:tap];
        
    }
    return _orgHeadImageView;
}

- (UILabel *)orgNameLabel {
    if (!_orgNameLabel) {
        _orgNameLabel = [[UILabel alloc] init];
        _orgNameLabel.font = [UIFont systemFontOfSize:KWIDTH(36)];
        _orgNameLabel.textColor = [UIColor blackColor];
        [self addSubview:_orgNameLabel];
        __weak typeof(self) weakSelf = self;
        [_orgNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.orgHeadImageView.mas_right).offset(KWIDTH(20));
            make.centerY.equalTo(weakSelf.orgHeadImageView);
            make.height.equalTo(weakSelf.orgHeadImageView);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoOrgDetail:)];
        _orgNameLabel.userInteractionEnabled = YES;
        [_orgNameLabel addGestureRecognizer:tap];
    }
    return _orgNameLabel;
}

- (void)gotoOrgDetail:(UITapGestureRecognizer *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(orgDetailCellSelctOrgImage:)]) {
        [self.delegate orgDetailCellSelctOrgImage:self];
    }
}

- (UIButton *)orgTypeButton {
    if (!_orgTypeButton) {
        _orgTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _orgTypeButton.userInteractionEnabled = NO;
        _orgTypeButton.titleLabel.font = [UIFont systemFontOfSize:KWIDTH(24)];
        [_orgTypeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_orgTypeButton];
        __weak typeof(self) weakSelf = self;
        [_orgTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.orgNameLabel);
            make.left.equalTo(weakSelf.orgNameLabel.mas_right).offset(KWIDTH(10));
            make.height.offset(KHEIGHT(30));
            //            make.width.offset(KWIDTH(62));
        }];
    }
    return _orgTypeButton;
}

- (UIView *)imagesBackView {
    if (!_imagesBackView) {
        _imagesBackView = [[UIView alloc] init];
        _imagesBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_imagesBackView];
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
    }
    return _imagesBackView;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImage:[UIImage imageNamed:@"Org_detail_address"]];
        [self addSubview:imageView];
        __weak typeof(self) weakSelf = self;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.orgHeadImageView);
            make.top.equalTo(weakSelf.imagesBackView.mas_bottom).offset(KHEIGHT(38));
            make.width.offset(KWIDTH(26));
            make.height.offset(KWIDTH(26));
        }];
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:KWIDTH(30)];
        _addressLabel.textColor = kDarkLabelColor;
        [self addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(KWIDTH(10));
            make.centerY.equalTo(imageView);
        }];
    }
    return _addressLabel;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImage:[UIImage imageNamed:@"Org_detail_phone"]];
        [self addSubview:imageView];
        __weak typeof(self) weakSelf = self;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.orgHeadImageView);
            make.top.equalTo(weakSelf.addressLabel.mas_bottom).offset(KHEIGHT(30));
            make.width.offset(KWIDTH(26));
            make.height.offset(KWIDTH(26));
        }];
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.font = [UIFont systemFontOfSize:KWIDTH(28)];
        _phoneLabel.textColor = kDarkLabelColor;
        [self addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(KWIDTH(10));
            make.centerY.equalTo(imageView);
        }];
    }
    return _phoneLabel;
}

- (UIButton *)connectButton {
    if (!_connectButton) {
        _connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _connectButton.layer.cornerRadius = KWIDTH(15);
        _connectButton.layer.borderWidth = KWIDTH(1);
        _connectButton.layer.borderColor = KLabelBlueColor.CGColor;
        [_connectButton setTitle:@"联系机构" forState:UIControlStateNormal];
        _connectButton.titleLabel.font = [UIFont systemFontOfSize:KWIDTH(22)];
        [_connectButton setTitleColor:KLabelBlueColor forState:UIControlStateNormal];
        [self addSubview:_connectButton];
        __weak typeof(self) weakSelf = self;
        [_connectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.phoneLabel.mas_right).offset(KWIDTH(10));
            make.centerY.equalTo(weakSelf.phoneLabel);
            make.height.offset(KWIDTH(30));
            make.width.offset(KWIDTH(120));
        }];
    }
    return _connectButton;
}

- (UIButton *)joinButton {
    if (!_joinButton) {
        _joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _joinButton.backgroundColor = KLabelBlueColor;
        _joinButton.layer.cornerRadius = KWIDTH(35);
        [_joinButton setTitle:@"关注机构" forState:UIControlStateNormal];
        [_joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_joinButton];
        __weak typeof(self) weakSelf = self;
        [_joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mas_bottom).offset(KHEIGHT(-30));
            make.centerX.offset(0);
            make.width.offset(kLayoutScreenWidth - KWIDTH(60));
            make.height.offset(KWIDTH(70));
        }];
    }
    return _joinButton;
}

- (NSMutableArray *)imageViewFrames {
    
    if (!_imageViewFrames) {
        _imageViewFrames = [NSMutableArray array];
    }
    return _imageViewFrames;
}

- (void)setOrgDict:(NSDictionary *)orgDict {
    _orgDict = orgDict;
    NSLog(@"orgDict %@", orgDict);
    [self.orgHeadImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", orgDict[@"logo"]]] placeholderImage:[UIImage imageNamed:@"Common_noheadimage"]];
    self.orgNameLabel.text = [NSString stringWithFormat:@"%@", orgDict[@"name"]];
    NSString *picStr = [NSString stringWithFormat:@"%@", orgDict[@"pic"]];
    if (![picStr containsString:@"null"]) {
        NSArray *temp=[picStr componentsSeparatedByString:@","];
        NSLog(@"temp %@ %@", orgDict[@"pic"], temp);
        self.imagesArray = [NSMutableArray arrayWithArray:temp];
    }
    
    [self imagesFromArray];
    __weak typeof(self) weakSelf = self;
    [self.imagesBackView mas_updateConstraints:^(MASConstraintMaker *make) {
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
    self.addressLabel.text = orgDict[@"address"];
    NSString *phoneStr = [NSString stringWithFormat:@"%@", orgDict[@"phone"]];
//    NSString *phoneStr = @"";

    if (![phoneStr containsString:@"null"] && phoneStr.length > 0) {
        phoneStr = [phoneStr stringByReplacingCharactersInRange:NSMakeRange(phoneStr.length - 4, 4) withString:@"****"];
        self.phoneLabel.text = phoneStr;
        [self.connectButton addTarget:self action:@selector(connectOrgAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    NSString *inTime = [NSString stringWithFormat:@"%@", orgDict[@"inTime"]];
//    NSString *inTime = @"";

    if (inTime.length > 0) {
        self.joinButton.backgroundColor = KImageViewBackGroundColor;
        [self.joinButton setTitle:@"已关注机构" forState:UIControlStateNormal];
    } else {
        self.joinButton.backgroundColor = KLabelBlueColor;
    }
    NSDictionary *orgTypeDict = orgDict[@"orgtype"];
    self.orgType = [orgTypeDict[@"colorflg"] integerValue];
}

- (void)setOrgType:(NSInteger)orgType {
    _orgType = orgType;
    switch (orgType) {
        case 1: {  // 美术
            [self.orgTypeButton setBackgroundImage:[UIImage imageNamed:@"Home_org_type_art"] forState:UIControlStateNormal];
        }
            break;
        case 2: {  // 生活
            [self.orgTypeButton setBackgroundImage:[UIImage imageNamed:@"Home_org_type_life"] forState:UIControlStateNormal];
        }
            break;
        case 3: {  // 书法
            [self.orgTypeButton setBackgroundImage:[UIImage imageNamed:@"Home_org_type_calligraphy"] forState:UIControlStateNormal];
        }
            break;
        case 4: {  // 舞蹈
            [self.orgTypeButton setBackgroundImage:[UIImage imageNamed:@"Home_org_type_dance"] forState:UIControlStateNormal];
        }
            break;
        case 5: {  // 音乐
            [self.orgTypeButton setBackgroundImage:[UIImage imageNamed:@"Home_org_type_music"] forState:UIControlStateNormal];
        }
            break;
        case 6: {  // 语言
            [self.orgTypeButton setBackgroundImage:[UIImage imageNamed:@"Home_org_type_language"] forState:UIControlStateNormal];
        }
            break;
        case 7: {  // 运动
            [self.orgTypeButton setBackgroundImage:[UIImage imageNamed:@"Home_org_type_sports"] forState:UIControlStateNormal];
        }
            break;
        case 8: {  // 早教
            [self.orgTypeButton setBackgroundImage:[UIImage imageNamed:@"Home_org_type_education"] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}


- (void)connectOrgAction:(UIButton *)sender {
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.orgDict[@"phone"]];
    // NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}

- (void)imagesFromArray {
    if (self.imagesArray.count == 1) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, KWIDTH(450))];
        imageView.backgroundColor = [UIColor whiteColor];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.imagesArray[0]]];
        [self.imagesBackView addSubview:imageView];
        [self.imageViewFrames addObject:[NSValue valueWithCGRect:imageView.frame]];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 0;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
        [imageView addGestureRecognizer:tapGestureRecognizer];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        
    } else if (self.imagesArray.count == 2) {
        for (int i = 0; i < 2; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((KWIDTH(372) + KWIDTH(6)) * i, 0, KWIDTH(372), KWIDTH(372))];
            imageView.backgroundColor = KImageViewBackGroundColor;
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imagesArray[i]] placeholderImage:[UIImage imageNamed:@"Two_placehoder"]];
            [self.imagesBackView addSubview:imageView];
            
            [self.imageViewFrames addObject:[NSValue valueWithCGRect:imageView.frame]];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i;
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
            [imageView addGestureRecognizer:tapGestureRecognizer];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
        }
    } else if (self.imagesArray.count >= 3) {
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((KWIDTH(248) + KWIDTH(3)) * i, 0, KWIDTH(248), KWIDTH(248))];
            imageView.backgroundColor = KImageViewBackGroundColor;
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imagesArray[i]] placeholderImage:[UIImage imageNamed:@"Three_placehoder"]];
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


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        //        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
