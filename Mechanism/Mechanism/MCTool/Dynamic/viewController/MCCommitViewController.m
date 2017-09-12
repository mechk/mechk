//
//  MCCommitViewController.m
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/11.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import "MCCommitViewController.h"
#import "DyCommitTableViewCell.h"
#import "DynamicModel.h"
@interface MCCommitViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *commitTable;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation MCCommitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    [self createBack];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"评论";
    [self initCommit];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startRequest];
}
- (void)startRequest{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
 self.dataArr = [NSMutableArray array];
    [DataAfn POST:@"service/getExperiencesComment" params:[NSDictionary dictionaryWithObjectsAndKeys:self.dyId,@"activityId", nil] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *arr= [(NSDictionary *)responseObject objectForKey:@"data"];
        for (NSDictionary *smaDic in arr) {
            DynamicModel *dy = [DynamicModel new];
            dy.dyId = [smaDic[@"id"] integerValue];
            dy.content = smaDic[@"comment"];
            dy.time =  [self time:[NSString stringWithFormat:@"%@",smaDic[@"time"]]];
            dy.icon = smaDic[@"authorPic"];
            dy.name = smaDic[@"authorName"];
            [self.dataArr addObject:dy];
        }
        [self.commitTable reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
            [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
-(void)initCommit{
    self.commitTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, def_width, def_height -64)];
    //    self.Dtable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh:)];
    //    self.Dtable.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh:)];
    self.commitTable.delegate = self;
    self.commitTable.dataSource = self;
    self.commitTable.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    self.commitTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.commitTable registerClass:[DyCommitTableViewCell class] forCellReuseIdentifier:@"DyCommitTableViewCell"];
    [self.view addSubview:_commitTable];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DyCommitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DyCommitTableViewCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [cell selectDynamic:self.dataArr[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DynamicModel *dy = [self.dataArr objectAtIndex:indexPath.row];
    CGFloat hei =[dy.content sizeWithString:dy.content font:[UIFont systemFontOfSize:13] reducedWidth:135*scaleW].height;
    return hei +224/2-64+70*scaleH;
}
@end
