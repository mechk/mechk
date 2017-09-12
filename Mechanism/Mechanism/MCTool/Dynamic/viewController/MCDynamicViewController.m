//
//  MCDynamicViewController.m
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/8.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import "MCDynamicViewController.h"
#import "MCDynamicCell.h"
#import "DynamicModel.h"
#import "MCDySecViewController.h"
#import "MCCommitViewController.h"
@interface MCDynamicViewController ()<UITableViewDelegate,UITableViewDataSource,deleOrGuanli>
@property(nonatomic,strong)UITableView *Dtable;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation MCDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"动态管理";
    
    self.dataArr = [NSMutableArray array];
    [self createBack];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc]initWithTitle:@"发帖" style:UIBarButtonItemStylePlain target:self action:@selector(creat)];
    [self initTableView];
}
- (void)creat{
    //发帖
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startRequest];
    
}
- (void)startRequest{
    //    DynamicModel *model = [[DynamicModel alloc]init];
    //    model.name = @"啊哈";
    //    model.content =@"剧透好的骄傲还健康";
    //    model.picOrMov = YES;
    //    model.time = @"2017-5-10";
    //    model.dyId = 001;
    //    for (int i= 0; i< 5; i ++) {
    //        [self.dataArr addObject:model];
    //    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"41" forKey:@"orgId"];
    [DataAfn POST:@"service/getOrgActivityList3" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *arr = [NSArray array];
        arr = [(NSDictionary*)responseObject objectForKey:@"data"];
        for (NSDictionary *sdic in arr) {
            DynamicModel *model = [[DynamicModel alloc]init];
            model.content = sdic[@"disc"];
            model.name = [sdic[@"user"] objectForKey:@"name"];
            model.tittle = sdic[@"tittle"];
            model.icon = [sdic[@"user"] objectForKey:@"pic"];
            model.mailPic = sdic[@"mailPic"];
            model.dyId = [sdic[@"id"] integerValue];
            model.picOrMov = [sdic[@"type"] boolValue];
            model.time = [self time:[NSString stringWithFormat:@"%@",sdic[@"time"]]];
            model.commentNum= [NSString  stringWithFormat:@"%@",sdic[@"commentNum"]];
            model.resourceList =sdic[@"resourceList"];
            model.likedNum= [NSString  stringWithFormat:@"%@",sdic[@"likedNum"]];
            model.shearNum= [NSString  stringWithFormat:@"%@",sdic[@"shearNum"]];
            
            [self.dataArr addObject:model];
        }
        [self.Dtable reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //        [self.Dtable.mj_header endRefreshing];
        //        [self.Dtable.mj_footer endRefreshing];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //        [self.Dtable.mj_header endRefreshing];
        //        [self.Dtable.mj_footer endRefreshing];
        NSLog(@"%@",error);
    }];
}
- (void)initTableView{
    
    self.Dtable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, def_width, def_height -64)];
    //    self.Dtable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh:)];
    //    self.Dtable.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh:)];
    self.Dtable.delegate = self;
    self.Dtable.dataSource = self;
    self.Dtable.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    self.Dtable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.Dtable registerClass:[MCDynamicCell class] forCellReuseIdentifier:@"MCDynamicCell"];
    [self.view addSubview:_Dtable];
}
//- (void)headerRefresh:(id)sender{
//    self.dataArr = [NSMutableArray array];
//    [self startRequest];
//}
//- (void)footerRefresh:(id)sender{
//    [self startRequest];
//
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MCDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCDynamicCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.DGdelegate=self;
    
    [cell selectDynamic:self.dataArr[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MCDySecViewController *dySec = [[MCDySecViewController alloc]init];
    DynamicModel *model = [self.dataArr objectAtIndex:indexPath.row];
    NSArray *arr = [NSArray arrayWithObject:model];
    dySec.dataArr = (NSMutableArray *)arr;
    [self.navigationController pushViewController:dySec animated:YES];
}
-(void)deleL:(NSString *)dyId{
    
}
- (void)guanL:(NSString *)dyId{
    MCCommitViewController *commit = [[MCCommitViewController alloc]init];
    commit.dyId = dyId;
    [self.navigationController pushViewController:commit animated:YES];
}
@end
