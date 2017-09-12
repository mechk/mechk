//
//  MCDySecViewController.m
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/9.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import "MCDySecViewController.h"
#import "DyPictureTableViewCell.h"
#import "DyVideoTableViewCell.h"
#import "DynamicModel.h"
#import "WMPlayer.h"
#import "MCCommitViewController.h"
@interface MCDySecViewController ()<UITableViewDelegate,UITableViewDataSource,HomeVideoCellDelegate>
{
    
        NSMutableArray *dataSource;
      ;
        NSIndexPath *currentIndexPath;
        BOOL isSmallScreen;
    
}
@property(nonatomic,strong)UITableView *Dtable;
@property(nonatomic,retain) DyVideoTableViewCell *currentCell;
@property(nonatomic,strong)WMPlayer *wmPlayer;


@end

@implementation MCDySecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"动态详情";
    [self createBack];

    [self initTable];
    
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
    
    //关闭通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeTheVideo:)
                                                 name:@"closeTheVideo"
                                               object:nil
     ];
}
- (void)initTable{
    self.Dtable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, def_width, def_height -64-100*scaleH)];
    self.Dtable.backgroundColor = [UIColor clearColor];
    self.Dtable.delegate = self;
    self.Dtable.dataSource = self;
    self.Dtable.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    self.Dtable.separatorStyle = UITableViewCellSeparatorStyleNone;
    DynamicModel *dy = self.dataArr[0];
    if (dy.picOrMov) {
           [self.Dtable registerClass:[DyPictureTableViewCell class] forCellReuseIdentifier:@"DyPictureTableViewCell"];
    }else{
 
    [self.Dtable registerClass:[DyVideoTableViewCell class] forCellReuseIdentifier:@"DyVideoTableViewCell"];
    }
   
    [self createFoot];
    [self.view addSubview:_Dtable];
}
- (void)createFoot{
    UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, def_height-100*scaleH-64, def_width, 100*scaleH)];
    footview.backgroundColor = [UIColor whiteColor];
    
    UIButton *guanliBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    guanliBtn.frame = CGRectMake(80*scaleW, 20*scaleH, 200*scaleW, 60*scaleH);
    [guanliBtn setTitle:@"管理评论" forState:UIControlStateNormal];
    guanliBtn.backgroundColor = [UIColor colorWithHexString:@"#00aff6"];
    guanliBtn.clipsToBounds = YES;
    guanliBtn.titleLabel.font = [UIFont systemFontOfSize:def_width<375?13:14];
    guanliBtn.layer.cornerRadius = 4;
    [guanliBtn addTarget:self action:@selector(guanliBtn:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:guanliBtn];
    
    UIButton *deleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleBtn.frame = CGRectMake(470*scaleW, 20*scaleH, 200*scaleW, 60*scaleH);
    [deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleBtn.backgroundColor = [UIColor colorWithHexString:@"#e14a3b"];
    deleBtn.titleLabel.font = [UIFont systemFontOfSize:def_width<375?13:14];
    deleBtn.clipsToBounds = YES;
    deleBtn.layer.cornerRadius = 4;
    [deleBtn addTarget:self action:@selector(deleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:deleBtn];
    [self.view addSubview:footview];
}
- (void)deleBtn:(id)sender{
    //删除
}
- (void)guanliBtn:(id)sender{
    //管理
    DynamicModel *dy = [self.dataArr objectAtIndex:0];
    MCCommitViewController *commit = [[MCCommitViewController alloc]init];
    commit.dyId =[NSString stringWithFormat:@"%ld",dy.dyId];
    [self.navigationController pushViewController:commit animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
       DynamicModel *dy = self.dataArr[indexPath.row];
    if (dy.picOrMov) {
        DyPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DyPictureTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        

        [cell select:dy];
        //    
        return cell;
    }else{
       DyVideoTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"DyVideoTableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.delegate = self;
      
        [cell select:dy];
        if (self.wmPlayer&&self.wmPlayer.superview) {
            if (indexPath==currentIndexPath) {
                [cell.playButton.superview sendSubviewToBack:cell.playButton];
            }else{
                [cell.playButton.superview bringSubviewToFront:cell.playButton];
            }
            NSArray *indexpaths = [tableView indexPathsForVisibleRows];
            if (![indexpaths containsObject:currentIndexPath]) {//复用
                
                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:self.wmPlayer]) {
                    self.wmPlayer.hidden = NO;
                    
                }else{
                    self.wmPlayer.hidden = YES;
                    
                    [cell.playButton.superview bringSubviewToFront:cell.playButton];
                }
            }else{
                if ([cell.videoImageView.subviews containsObject:self.wmPlayer]) {
                    [cell.videoImageView addSubview:self.wmPlayer];
                    
                    [self.wmPlayer.player play];
                    self.wmPlayer.playOrPauseBtn.selected = NO;
                    self.wmPlayer.hidden = NO;
                }
                
            }
        }
        
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   DynamicModel *dy= self.dataArr[indexPath.row];
    NSString *disc = dy.content;
    CGSize discSize = [disc boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - KWIDTH(60), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:KWIDTH(28)]} context:nil].size;
    if (!dy.picOrMov) {
        return KWIDTH(450) + discSize.height + KWIDTH(270);
    } else {
        NSArray *array = dy.resourceList;
        if (array.count == 1) {
            return KWIDTH(450) + discSize.height + KWIDTH(270);
        } else if (array.count == 2) {
            return KWIDTH(372) + discSize.height + KWIDTH(270);
        } else {
            return KWIDTH(248) + discSize.height + KWIDTH(270);
        }
    }
}
- (void)homeViedoCellPlayButtonClicked:(DyVideoTableViewCell *)cell {
    //    currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    NSLog(@"currentIndexPath.row = %ld",currentIndexPath.row);
    currentIndexPath = [self.Dtable indexPathForCell:cell];
    self.currentCell = cell;
    //    VideoModel *model = [dataSource objectAtIndex:sender.tag];
    
    DynamicModel *dy = self.dataArr[currentIndexPath.row];
    
    isSmallScreen = NO;
    
    NSArray *array = dy.resourceList;
    if (self.wmPlayer) {
        [_wmPlayer removeFromSuperview];
        [_wmPlayer setVideoURLStr:array[0]];
        [_wmPlayer.player play];
        
    }else{
        if (array.count > 0) {
            self.wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.videoImageView.bounds videoURLStr:array[0]];
            
            [_wmPlayer.player play];
        } else {
            [Util showMesssage:@"视频不存在"];
        }
        
    }
    [self.currentCell.videoImageView addSubview:_wmPlayer];
    
    [self.currentCell.videoImageView bringSubviewToFront:_wmPlayer];
    
    [self.currentCell.playButton.superview sendSubviewToBack:self.currentCell.playButton];
    [self.Dtable reloadData];
}
#pragma mark - 视频播放
-(void)videoDidFinished:(NSNotification *)notice{
    //    HomeVideoCell *currentCell = (HomeVideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [self.currentCell.playButton.superview bringSubviewToFront:self.currentCell.playButton];
    [self.wmPlayer removeFromSuperview];
    
}

-(void)closeTheVideo:(NSNotification *)obj{
    //    HomeVideoCell *currentCell = (HomeVideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [self.currentCell.playButton.superview bringSubviewToFront:self.currentCell.playButton];
    [self releaseWMPlayer];
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
    
}
-(void)fullScreenBtnClick:(NSNotification *)notice{
    UIButton *fullScreenBtn = (UIButton *)[notice object];
    if (fullScreenBtn.isSelected) {//全屏显示
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        if (isSmallScreen) {
            //放widow上,小屏显示
            [self toSmallScreen];
        }else{
            [self toCell];
        }
    }
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    
    if (self.wmPlayer==nil||self.wmPlayer.superview==nil){
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (self.wmPlayer.isFullscreen) {
                if (isSmallScreen) {
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }else{
                    [self toCell];
                }
                
            }
            
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            if (self.wmPlayer.isFullscreen == NO) {
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
            
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            if (self.wmPlayer.isFullscreen == NO) {
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
            
        }
            break;
        default:
            break;
    }
}

-(void)toCell{
    DyVideoTableViewCell *currentCell = [self currentCell];
    
    [self.wmPlayer removeFromSuperview];
    NSLog(@"row = %ld",currentIndexPath.row);
    [UIView animateWithDuration:0.5f animations:^{
        self.wmPlayer.transform = CGAffineTransformIdentity;
        self.wmPlayer.frame = currentCell.videoImageView.bounds;
        self.wmPlayer.playerLayer.frame =  self.wmPlayer.bounds;
        [currentCell.videoImageView addSubview:self.wmPlayer];
        [currentCell.videoImageView bringSubviewToFront:self.wmPlayer];
        [self.wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wmPlayer).with.offset(0);
            make.right.equalTo(self.wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.wmPlayer).with.offset(0);
            
        }];
        
        [self.wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(self.wmPlayer).with.offset(5);
            
        }];
        
        
    }completion:^(BOOL finished) {
        self.wmPlayer.isFullscreen = NO;
        isSmallScreen = NO;
        self.wmPlayer.fullScreenBtn.selected = NO;
        [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
        
    }];
    
}

-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
    
    [self.wmPlayer removeFromSuperview];
    self.wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        self.wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        self.wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    self.wmPlayer.frame = CGRectMake(0, 0, self.view.frame.size.width, kLayoutScreenHeight);
    self.wmPlayer.playerLayer.frame =  CGRectMake(0,0, kLayoutScreenHeight,self.view.frame.size.width);
    
    [self.wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.view.frame.size.width-40);
        make.width.mas_equalTo(kLayoutScreenHeight);
    }];
    
    [self.wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.wmPlayer).with.offset((-kLayoutScreenHeight/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(self.wmPlayer).with.offset(5);
        
    }];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.wmPlayer];
    self.wmPlayer.isFullscreen = YES;
    self.wmPlayer.fullScreenBtn.selected = YES;
    [self.wmPlayer bringSubviewToFront:self.wmPlayer.bottomView];
    
}

-(void)toSmallScreen{
    //放widow上
    [self.wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        self.wmPlayer.transform = CGAffineTransformIdentity;
        self.wmPlayer.frame = CGRectMake(kLayoutScreenWidth/2,kLayoutScreenHeight-44-(kLayoutScreenWidth/2)*0.75, kLayoutScreenWidth/2, (kLayoutScreenWidth/2)*0.75);
        self.wmPlayer.playerLayer.frame =  self.wmPlayer.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:self.wmPlayer];
        
        [self.wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wmPlayer).with.offset(0);
            make.right.equalTo(self.wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.wmPlayer).with.offset(0);
        }];
        
        [self.wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(self.wmPlayer).with.offset(5);
            
        }];
        
    }completion:^(BOOL finished) {
        self.wmPlayer.isFullscreen = NO;
        self.wmPlayer.fullScreenBtn.selected = NO;
        isSmallScreen = YES;
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.wmPlayer];
        [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
    }];
    
}

//#pragma mark scrollView delegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if(scrollView == self.Dtable){
//        if (self.wmPlayer==nil) {
//            return;
//        }
//        
//        if (self.wmPlayer.superview) {
//            CGRect rectInTableView = [self.Dtable rectForRowAtIndexPath:currentIndexPath];
//            CGRect rectInSuperview = [self.Dtable convertRect:rectInTableView toView:[self.Dtable superview]];
//            
//            NSLog(@"rectInSuperview = %@",NSStringFromCGRect(rectInSuperview));
//            
//            
//            
//            if (rectInSuperview.origin.y<-self.currentCell.videoImageView.frame.size.height||rectInSuperview.origin.y>self.view.frame.size.height-44-49) {//往上拖动
//                
//                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:self.wmPlayer]&&isSmallScreen) {
//                    isSmallScreen = YES;
//                }else{
//                    //放widow上,小屏显示
//                    [self toSmallScreen];
//                }
//                
//                
//                
//            }else{
//                if ([self.currentCell.videoImageView.subviews containsObject:self.wmPlayer]) {
//                    
//                }else{
//                    [self toCell];
//                }
//            }
//        }
//        
//    }
//}

-(void)releaseWMPlayer{
    [self.wmPlayer.player.currentItem cancelPendingSeeks];
    [self.wmPlayer.player.currentItem.asset cancelLoading];
    
    [self.wmPlayer.player pause];
    [self.wmPlayer removeFromSuperview];
    [self.wmPlayer.playerLayer removeFromSuperlayer];
    [self.wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    self.wmPlayer = nil;
    self.wmPlayer.player = nil;
    self.wmPlayer.currentItem = nil;
    
    self.wmPlayer.playOrPauseBtn = nil;
    self.wmPlayer.playerLayer = nil;
    currentIndexPath = nil;
}

-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self releaseWMPlayer];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MCDySecViewController *dySec = [[MCDySecViewController alloc]init];
//    [self.navigationController pushViewController:dySec animated:YES];
}
@end
