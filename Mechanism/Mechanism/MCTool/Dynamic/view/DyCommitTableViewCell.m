//
//  DyCommitTableViewCell.m
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/11.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import "DyCommitTableViewCell.h"
@interface DyCommitTableViewCell()
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *iconPic;
@property(nonatomic,assign)NSInteger dyId;
@property(nonatomic,strong)UIButton *deleBtn;

@end
@implementation DyCommitTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews{
 
    self.iconPic = [[UIImageView alloc]initWithFrame:CGRectMake(30*scaleW, 160/2 -64, 55*scaleW, 55*scaleH)];
    self.iconPic.clipsToBounds = YES;
    self.iconPic.layer.cornerRadius = 22.5*scaleW;
    [self.contentView addSubview:_iconPic];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(103*scaleW, 170/2-64, (570-103)*scaleW -10, 30*scaleH)];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor =[UIColor colorWithHexString:@"#000000"];
    [self.contentView addSubview:_nameLabel];
    
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(570*scaleW, 170/2 - 64, def_width-570*scaleW -10, 30*scaleH)];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"#9b9b9b"];
    [self.contentView addSubview:_timeLabel];

    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(105*scaleW, 224/2-64, def_width-135*scaleW, 30*scaleH)];
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.numberOfLines= 0;
    self.contentLabel.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    [self.contentView addSubview:_contentLabel];
    
    self.deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.deleBtn.backgroundColor = [UIColor clearColor];
    [self.deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    self.deleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.deleBtn setTitleColor:[UIColor colorWithHexString:@"#e14a3b"] forState:UIControlStateNormal];
    [self.deleBtn addTarget:self action:@selector(deleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleBtn];


    
   
}
- (void)deleAction{
    
    //删除
    
}
- (void)selectDynamic:(DynamicModel *)dynamic{
    self.nameLabel.text = dynamic.name;
    [self.iconPic sd_setImageWithURL:[NSURL URLWithString:dynamic.icon] placeholderImage:[UIImage imageNamed:@"LoseIcon"]];
    self.timeLabel.text = dynamic.time;
    self.contentLabel.text = dynamic.content;
    CGFloat hei =[dynamic.content sizeWithString:dynamic.content font:[UIFont systemFontOfSize:13] reducedWidth:135*scaleW].height;
    self.contentLabel.frame = CGRectMake(105*scaleW, 224/2-64, def_width-135*scaleW, hei);
    
    self.deleBtn.frame = CGRectMake(660*scaleW, self.contentLabel.frame.origin.y +self.contentLabel.frame.size.height+ 20*scaleH, 70*scaleW, 30*scaleH);
    
    UIView *line = [UIView oneline:CGRectMake(0, self.deleBtn.frame.origin.y +self.deleBtn.frame.size.height +18*scaleH, def_width, 2*scaleH)];
    [self.contentView addSubview:line];
    
}
@end
