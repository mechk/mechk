//
//  OrganizationListVC.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/8/8.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "OrganizationListVC.h"
#import "Contant.h"
#import "OrgDetail.h"
#import "SelectConditionView.h"
#import "OrgListCell.h"
#import <CoreLocation/CoreLocation.h>

@interface OrganizationListVC () <UITableViewDelegate, UITableViewDataSource, SearchViewDelegate, SelectConditionViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) UIView *noContentView;
@property (nonatomic, strong) NoContentView *noNetWorkView;

// 筛选条件
@property (nonatomic, strong) UILabel *areaLabel;
@property (nonatomic, strong) UIImageView *areaImageView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIImageView *typeImageView;
@property (nonatomic, strong) UILabel *sortLabel;
@property (nonatomic, strong) UIImageView *sortImageView;

@property (nonatomic, strong) NSMutableArray *areaArray;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) NSMutableArray *orderArray;

@property (nonatomic, copy) NSString *area1;
@property (nonatomic, copy) NSString *area2;
@property (nonatomic, copy) NSString *type1;
@property (nonatomic, copy) NSString *type2;
@property (nonatomic, copy) NSString *orderby;

@property (nonatomic, strong) SelectConditionView *conditionView;
@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UIView *rightLine;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) CLLocationManager *locationManager; // 定位
@property (nonatomic, copy) NSString *strlatitude;//经度
@property (nonatomic, copy) NSString *strlongitude;//纬度

@end

static NSInteger ButtonTag = 400;
static NSString *ORGLIST_CELL_ID = @"orglis_cell_id";

@implementation OrganizationListVC
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)areaArray {
    if (!_areaArray) {
        _areaArray = [[NSMutableArray alloc] init];
    }
    return _areaArray;
}

- (NSMutableArray *)typeArray {
    if (!_typeArray) {
        _typeArray = [[NSMutableArray alloc] init];
    }
    return _typeArray;
}

- (NSMutableArray *)orderArray {
    if (!_orderArray) {
        _orderArray = [[NSMutableArray alloc] init];
    }
    return _orderArray;
}

- (UIView *)noContentView {
    if (!_noContentView) {
        _noContentView = [[NoContentView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, kLayoutScreenHeight - KHEIGHT(101) - 64) ImageFrame:CGRectMake(kLayoutScreenWidth / 2 - KWIDTH(125), KHEIGHT(220), KWIDTH(250), KHEIGHT(290)) NoContentImage:@"Perform_noData" NocontentString:@"空空如也~"];
        [self.tableView addSubview:_noContentView];
    }
    return _noContentView;
}

- (NoContentView *)noNetWorkView {
    if (!_noNetWorkView) {
        _noNetWorkView = [[NoContentView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, kLayoutScreenHeight - KHEIGHT(101) - 64) ImageFrame:CGRectMake(kLayoutScreenWidth / 2 - KWIDTH(125), KHEIGHT(220), KWIDTH(250), KHEIGHT(290)) NoContentImage:@"Common_noNetWork" NocontentString:@"网络连接故障啦"];
        [self.tableView addSubview:_noNetWorkView];
    }
    return _noNetWorkView;
}

- (SelectConditionView *)conditionView {
    if (!_conditionView) {
        _conditionView = [[SelectConditionView alloc] initWithFrame:CGRectMake(0, KHEIGHT(70), kLayoutScreenWidth, kLayoutScreenHeight - 64)];
        _conditionView.delegate = self;
        [self.view addSubview:_conditionView];
        [self.view bringSubviewToFront:_conditionView];
    }
    return _conditionView;
}

- (SearchView *)searchView {
    if (!_searchView) {
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT(70), kLayoutScreenWidth, kLayoutScreenHeight)];
        self.backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self.view addSubview:self.backView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewTaped:)];
        [self.backView addGestureRecognizer:tap];
        _searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, KHEIGHT(70), kLayoutScreenWidth, KHEIGHT(210))];
        _searchView.delegate = self;
        _searchView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_searchView];
    }
    return _searchView;
}

- (void)backViewTaped:(UITapGestureRecognizer *)sender {
    self.backView.hidden = YES;
    self.searchView.hidden = YES;
    [self resetLineFrame];
}

- (void)setUpViews {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, KHEIGHT(70))];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    NSArray *titlesArray = @[@"区域", @"全部类型", @"智能排序"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kLayoutScreenWidth / 3 * i, 0, kLayoutScreenWidth / 3 - KWIDTH(2), KHEIGHT(70));
        button.tag = ButtonTag + i;
        [button addTarget:self action:@selector(conditionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:button];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kLayoutScreenWidth / 3 * i - KWIDTH(2), KHEIGHT(15), KWIDTH(2), KHEIGHT(40))];
        line.backgroundColor = KLineBackgroundColor;
        [topView addSubview:line];
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:KWIDTH(28)];
        label.textColor = kDarkLabelColor;
        label.text = titlesArray[i];
        [button addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(KWIDTH(-10));
            make.centerY.offset(0);
        }];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImage:[UIImage imageNamed:@"Search_arrow_down"]];
        [button addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(label);
            make.left.equalTo(label.mas_right).offset(KWIDTH(5));
            make.width.offset(KWIDTH(16));
            make.height.offset(KHEIGHT(8));
        }];
        if (i == 0) {
            self.areaLabel = label;
            self.areaImageView = imageView;
        } else if (i == 1) {
            self.typeLabel = label;
            self.typeImageView = imageView;
        } else {
            self.sortLabel = label;
            self.sortImageView = imageView;
        }
    }
    self.leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT(68), kLayoutScreenWidth, KWIDTH(1))];
    self.leftLine.backgroundColor = KLineBackgroundColor;
    [topView addSubview:self.leftLine];
    self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kLayoutScreenWidth, KHEIGHT(60), KWIDTH(16), KWIDTH(10))];
    [self.arrowImageView setImage:[UIImage imageNamed:@"Search_Arrow"]];
    [topView addSubview:self.arrowImageView];
    [topView bringSubviewToFront:self.arrowImageView];
    self.rightLine = [[UIView alloc] initWithFrame:CGRectMake(kLayoutScreenWidth, KHEIGHT(68), 0, KWIDTH(1))];
    self.rightLine.backgroundColor = KLineBackgroundColor;
    [topView addSubview:self.rightLine];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KHEIGHT(69), self.view.bounds.size.width, kLayoutScreenHeight - 64 - KHEIGHT(70)) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = kCommonBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[OrgListCell class] forCellReuseIdentifier:ORGLIST_CELL_ID];
    [self.view addSubview:self.tableView];
}

- (void)conditionButtonAction:(UIButton *)sender {
    switch (sender.tag - ButtonTag) {
        case 0: {
            self.leftLine.frame = CGRectMake(0, KHEIGHT(68), kLayoutScreenWidth / 6 - KWIDTH(8), KWIDTH(1));
            self.arrowImageView.frame = CGRectMake(kLayoutScreenWidth / 6 - KWIDTH(8), KHEIGHT(59), KWIDTH(16), KWIDTH(10));
            self.rightLine.frame = CGRectMake(kLayoutScreenWidth / 6 + KWIDTH(8), KHEIGHT(68), kLayoutScreenWidth - kLayoutScreenWidth / 6, KWIDTH(1));
            self.searchView.hidden = YES;
            self.conditionView.hidden = NO;
            self.backView.hidden = YES;
            self.areaLabel.textColor = KLabelBlueColor;
            self.typeLabel.textColor = kDarkLabelColor;
            self.sortLabel.textColor = kDarkLabelColor;
            [self.areaImageView setImage:[UIImage imageNamed:@"Search_arrow_up"]];
            [self.typeImageView setImage:[UIImage imageNamed:@"Search_arrow_down"]];
            [self.sortImageView setImage:[UIImage imageNamed:@"Search_arrow_down"]];
            self.conditionView.type = 0;
            self.conditionView.leftArray = self.areaArray;
        }
            break;
        case 1: {
            self.leftLine.frame = CGRectMake(0, KHEIGHT(68), kLayoutScreenWidth / 2 - KWIDTH(8), KWIDTH(1));
            self.arrowImageView.frame = CGRectMake(kLayoutScreenWidth / 2 - KWIDTH(8), KHEIGHT(59), KWIDTH(16), KWIDTH(10));
            self.rightLine.frame = CGRectMake(kLayoutScreenWidth / 2 + KWIDTH(8), KHEIGHT(68), kLayoutScreenWidth - kLayoutScreenWidth / 2, KWIDTH(1));
            self.searchView.hidden = YES;
            self.conditionView.hidden = NO;
            self.backView.hidden = YES;
            self.areaLabel.textColor = kDarkLabelColor;
            self.typeLabel.textColor = KLabelBlueColor;
            self.sortLabel.textColor = kDarkLabelColor;
            [self.areaImageView setImage:[UIImage imageNamed:@"Search_arrow_down"]];
            [self.typeImageView setImage:[UIImage imageNamed:@"Search_arrow_up"]];
            [self.sortImageView setImage:[UIImage imageNamed:@"Search_arrow_down"]];
            self.conditionView.type = 1;
            self.conditionView.leftArray = self.typeArray;
        }
            break;
        case 2: {
            self.leftLine.frame = CGRectMake(0, KHEIGHT(68), kLayoutScreenWidth / 6 * 5 - KWIDTH(8), KWIDTH(1));
            self.arrowImageView.frame = CGRectMake(kLayoutScreenWidth / 6 * 5 - KWIDTH(8), KHEIGHT(59), KWIDTH(16), KWIDTH(10));
            self.rightLine.frame = CGRectMake(kLayoutScreenWidth / 6 * 5 + KWIDTH(8), KHEIGHT(68), kLayoutScreenWidth - kLayoutScreenWidth / 6, KWIDTH(1));
            self.conditionView.hidden = YES;
            self.searchView.hidden = NO;
            self.backView.hidden = NO;
            self.areaLabel.textColor = kDarkLabelColor;
            self.typeLabel.textColor = kDarkLabelColor;
            self.sortLabel.textColor = KLabelBlueColor;
            [self.areaImageView setImage:[UIImage imageNamed:@"Search_arrow_down"]];
            [self.typeImageView setImage:[UIImage imageNamed:@"Search_arrow_down"]];
            [self.sortImageView setImage:[UIImage imageNamed:@"Search_arrow_up"]];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in self.orderArray) {
                NSLog(@"%@", [NSString stringWithFormat:@"%@", dict[@"orderName"]]);
                [array addObject:[NSString stringWithFormat:@"%@", dict[@"orderName"]]];
            }
            self.searchView.titlesArray = array;
            [self.searchView reloadData];
        }
            break;
        default:
            break;
    }
}

- (void)setUpConditionData {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[NSString stringWithFormat:@"%ld",(long)self.page] forKey:@"pageNum"];
    [MusicNetWorkTool POST:@"service/getSearch" parameters:dict success:^(id responseObject) {
        NSLog(@"search condition %@ %@", responseObject[@"msg"], responseObject);
        [self.areaArray addObjectsFromArray:responseObject[@"data"][@"area"]];
        [self.typeArray addObjectsFromArray:responseObject[@"data"][@"type"]];
        [self.orderArray addObjectsFromArray:responseObject[@"data"][@"order"]];

    } failure:^(NSError *error) {
        NSLog(@"search condition error %@ ", error);
    }];
}

- (void)setUpData {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    NSLog(@"page ====  %ld", self.page);
    if (self.area1.length > 0) {
        [dict setValue:self.area1 forKey:@"area1"];
        if (self.area2.length > 0) {
            [dict setValue:self.area2 forKey:@"area2"];
        }
    }
    if (self.type1.length > 0) {
        [dict setValue:self.type1 forKey:@"type1"];
        if (self.type2.length > 0) {
            [dict setValue:self.type2 forKey:@"type2"];
        }
    }
    if (self.orderby.length > 0) {
        [dict setValue:self.orderby forKey:@"orderby"];
    }
    if (self.strlatitude.length > 0) {
        [dict setValue:self.strlatitude forKey:@"latitude"];
    }
    if (self.strlongitude.length > 0) {
        [dict setValue:self.strlongitude forKey:@"longitude"];
    }
    [dict setValue:[NSString stringWithFormat:@"%ld",(long)self.page] forKey:@"pageNum"];

    [MusicNetWorkTool POST:@"service/getOrgListBySearch" parameters:dict success:^(id responseObject) {
        NSLog(@"orglistbysearch list %@ %@", responseObject[@"msg"], responseObject);
        NSLog(@"orglistbysearch dict %@", dict);
        self.noNetWorkView.hidden = YES;
        if ([responseObject[@"data"][@"orgList"] count]>0) {
            NSLog(@"page >>>>  %ld", self.page);
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:responseObject[@"data"][@"orgList"]];
            
            [self.tableView reloadData];
            _tableView.footerHidden = NO;
            _tableView.tableFooterView = nil;
            self.noContentView.hidden = YES;
        } else {
            if (self.page > 1) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _tableView.footerHidden = YES;
                    UILabel *footLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
                    footLabel.text = @"没有更多数据";
                    footLabel.textColor = [UIColor darkGrayColor];
                    footLabel.textAlignment = NSTextAlignmentCenter;
                    _tableView.tableFooterView = footLabel;
                });
            } else {
                [self.dataArray removeAllObjects];
                [self.tableView reloadData];
                self.noContentView.hidden = NO;
            }
        }
    } failure:^(NSError *error) {
        if ([CommonTool isConnectionUnreachableWithError:error]) {
            if (self.dataArray.count <= 0) {
                self.noNetWorkView.hidden = NO;
            }
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"机构";
    self.view.backgroundColor = kCommonBackgroundColor;
    [self startLocation];
    [self setUpViews];
    [self setupRefresh];
    [self setUpConditionData];
    self.page = 1;
    [self setUpData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - tableView delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return KWIDTH(220);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArray[indexPath.row];
    OrgListCell *cell = [tableView dequeueReusableCellWithIdentifier:ORGLIST_CELL_ID forIndexPath:indexPath];
    [cell.orgImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"logo"]] placeholderImage:[UIImage imageNamed:@""]];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", dict[@"name"]];
    NSString *typeStr = [NSString stringWithFormat:@"%@", dict[@"orgtype"][@"name"]];
    if ([typeStr containsString:@"null"]) {
        cell.typeLabel.text = @"";
    } else {
        cell.typeLabel.text = typeStr;
    }
    NSString *distanceStr = [NSString stringWithFormat:@"%@", dict[@"distance"]];
    if ([distanceStr containsString:@"null"]) {
        cell.distanceLabel.text = @"";
    } else {
        cell.distanceLabel.text = [NSString stringWithFormat:@"%@km", distanceStr];
    }
    cell.addressLabel.text = [NSString stringWithFormat:@"%@", dict[@"address"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//     UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    OrgDetail *orgDetailVC = (OrgDetail *)[sb instantiateViewControllerWithIdentifier:@"ORGDETAIL"];
//    orgDetailVC.dic = self.dataArray[indexPath.row];
//    orgDetailVC.shareImage = cell.orgHeadImageView.image;
    
    OrganizationDetailVC *orgDetailVC = [[OrganizationDetailVC alloc] init];
    orgDetailVC.orgDict = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:orgDetailVC animated:YES];
}

#pragma mark - selectConditionView delegate
- (void)selectConditionView:(SelectConditionView *)conditionView backViewDidClick:(UIView *)backView {
    [self resetLineFrame];
}

- (void)selectConditionView:(SelectConditionView *)conditionView didSelectLeftRowAtIndex:(NSInteger)index withAreaCode:(NSString *)areaCode AreaName:(NSString *)areaName {
    if (conditionView.type == 0) {
//        NSDictionary *dict = self.areaArray[index];
//        self.area1 = dict[@"areaCode"];
        self.area1 = areaCode;
        if (index == 0) {
            [self resetLineFrame];
            self.areaLabel.text = areaName;
            [self.tableView headerBeginRefreshing];
            self.page = 1;
            [self setUpData];
        }
    } else if (conditionView.type == 1) {
//        NSDictionary *dict = self.typeArray[index];
//        self.type1 = dict[@"areaCode"];
        self.type1 = areaCode;
        if (index == 0) {
            [self resetLineFrame];
            self.typeLabel.text = areaName;
            [self.tableView headerBeginRefreshing];
            self.page = 1;
            [self setUpData];
        }
    }
}

- (void)selectConditionView:(SelectConditionView *)conditionView didSelectRightRowAtIndex:(NSInteger)index withAreaCode:(NSString *)areaCode AreaName:(NSString *)areaName {
    [self resetLineFrame];
    NSLog(@"arename %@", areaName);
    if (conditionView.type == 0) {
        self.area2 = areaCode;
        self.areaLabel.text = areaName;

    } else if (conditionView.type == 1) {
        self.typeLabel.text = areaName;
        self.type2 = areaCode;
    }
    [self.tableView headerBeginRefreshing];
    self.page = 1;
    [self setUpData];
}

#pragma mark - searchView delegate 
- (void)searchView:(SearchView *)searchView didSelectRowAtIndex:(NSInteger)index SearchTitle:(NSString *)title {
    [self resetLineFrame];
    NSDictionary *dict = self.orderArray[index];
    self.orderby = [NSString stringWithFormat:@"%@", dict[@"orderflg"]];
    self.sortLabel.text = title;
    self.backView.hidden = YES;
    self.searchView.hidden = YES;
    [self.tableView headerBeginRefreshing];
    self.page = 1;
    [self setUpData];
}

- (void)resetLineFrame {
    self.areaLabel.textColor = kDarkLabelColor;
    self.typeLabel.textColor = kDarkLabelColor;
    self.sortLabel.textColor = kDarkLabelColor;
    [self.areaImageView setImage:[UIImage imageNamed:@"Search_arrow_down"]];
    [self.typeImageView setImage:[UIImage imageNamed:@"Search_arrow_down"]];
    [self.sortImageView setImage:[UIImage imageNamed:@"Search_arrow_down"]];
    self.leftLine.frame = CGRectMake(0, KHEIGHT(68), kLayoutScreenWidth, KWIDTH(1));
    self.arrowImageView.frame = CGRectMake(kLayoutScreenWidth, KHEIGHT(60), KWIDTH(16), KWIDTH(10));
    self.rightLine.frame = CGRectMake(kLayoutScreenWidth, KHEIGHT(69), kLayoutScreenWidth, KWIDTH(1));
}

#pragma mark - 定位
//开始定位
- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        //        CLog(@"--------开始定位");
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}
//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    self.strlatitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude]; // 经度
    self.strlongitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];// 纬度
    self.page = 1;
    [self setUpData];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}

#pragma mark - refresh
-(void)startGetData {
}

- (void)setupRefresh {
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新...";
    self.tableView.headerReleaseToRefreshText = @"释放刷新...";
    self.tableView.headerRefreshingText = @"正在加载...";
    
    self.tableView.footerPullToRefreshText = @"上拉刷新...";
    self.tableView.footerReleaseToRefreshText = @"释放刷新...";
    self.tableView.footerRefreshingText = @"正在加载...";
}

- (void)footerRereshing {
    self.page++;
    [self setUpData];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}

- (void)headerRereshing {
    self.page = 1;
    [self setUpData];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
