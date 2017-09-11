//
//  OrgDetailCell.h
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/8/24.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrgDetailCell;

@protocol OrgDetailCellDeleagate <NSObject>

- (void)orgDetailCellSelctOrgImage:(OrgDetailCell *)cell;

@end

@interface OrgDetailCell : UITableViewCell

@property (nonatomic, strong) UIImageView *orgHeadImageView;
@property (nonatomic, strong) UILabel *orgNameLabel;
@property (nonatomic, strong) UIButton *orgTypeButton;

@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIButton *connectButton;
@property (nonatomic, strong) UIButton *joinButton;


@property (nonatomic, strong) UIView *imagesBackView;


@property (nonatomic, copy) NSDictionary *orgDict;

@property (nonatomic, assign) NSInteger orgType;

@property (nonatomic, assign) id <OrgDetailCellDeleagate> delegate;

@end
