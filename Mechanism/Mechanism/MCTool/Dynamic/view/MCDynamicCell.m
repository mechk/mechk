//
//  MCDynamicCell.m
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/8.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import "MCDynamicCell.h"


@interface MCDynamicCell ()
@property(nonatomic,strong)UIImageView *picAmov;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *iconPic;
@property(nonatomic,assign)NSInteger dyId;
@end

@implementation MCDynamicCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews{
    self.picAmov = [[UIImageView alloc]initWithFrame:CGRectMake(30*scaleW, 159/2-64, 36*scaleW, 28*scaleH)];
    [self.contentView addSubview:_picAmov];
    
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(76*scaleW, 159/2-64, 360*scaleW, 30*scaleH)];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    [self.contentView addSubview:_contentLabel];
    
    self.iconPic = [[UIImageView alloc]initWithFrame:CGRectMake(30*scaleW, 210/2 -64, 40*scaleW, 40*scaleH)];
    self.iconPic.clipsToBounds = YES;
    self.iconPic.layer.cornerRadius = 20*scaleW;
    [self.contentView addSubview:_iconPic];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80*scaleW, 215/2-64, 86*scaleW, 28*scaleH)];
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    self.nameLabel.textColor =[UIColor colorWithHexString:@"#000000"];
    [self.contentView addSubview:_nameLabel];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(196*scaleW, 215/2 - 64, 165*scaleW, 28*scaleH)];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"#9b9b9b"];
    [self.contentView addSubview:_timeLabel];
    
    UIButton *guanliBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    guanliBtn.frame = CGRectMake(480*scaleW, 179/2 -64, 130*scaleW, 50*scaleH);
    [guanliBtn setTitle:@"管理评论" forState:UIControlStateNormal];
    guanliBtn.backgroundColor = [UIColor colorWithHexString:@"#00aff6"];
    guanliBtn.clipsToBounds = YES;
    guanliBtn.titleLabel.font = [UIFont systemFontOfSize:def_width<375?13:14];
    guanliBtn.layer.cornerRadius = 4;
    [guanliBtn addTarget:self action:@selector(guanliBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:guanliBtn];
    
    UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleBtn.frame = CGRectMake(630*scaleW, 179/2 -64, 100*scaleW, 50*scaleH);
    [deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleBtn.backgroundColor = [UIColor colorWithHexString:@"#e14a3b"];
    deleBtn.titleLabel.font = [UIFont systemFontOfSize:def_width<375?13:14];
    deleBtn.clipsToBounds = YES;
    deleBtn.layer.cornerRadius = 4;
    [deleBtn addTarget:self action:@selector(deleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:deleBtn];
    
    
    UIView *line = [UIView oneline:CGRectMake(0, 74, def_width, 1)];
    [self.contentView addSubview:line];
}
- (void)guanliBtn:(UIButton *)sender{
    //管理评论
    [self.DGdelegate guanL:[NSString stringWithFormat:@"%ld",self.dyId] ];
}
- (void)deleBtn:(UIButton *)sender{
    //删除
       [self.DGdelegate deleL:[NSString stringWithFormat:@"%ld",self.dyId] ];
    
}
- (void)selectDynamic:(DynamicModel *)dynamic{
    self.picAmov.image = [UIImage imageNamed:dynamic.picOrMov?@"pic":@"mov"];
    self.contentLabel.text = dynamic.content;
    [self.iconPic sd_setImageWithURL:[NSURL URLWithString:dynamic.icon] placeholderImage:[UIImage imageNamed:@"LoseIcon"]];
    self.nameLabel.text = dynamic.name;
    self.timeLabel.text = dynamic.time;
    self.dyId = dynamic.dyId;
}
@end
