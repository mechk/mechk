//
//  OrganizationDetailVC.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/8/23.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "OrganizationDetailVC.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

@interface OrganizationDetailVC () <UITableViewDelegate, UITableViewDataSource, CourseDetailVCDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *orgDictionary;
@property (nonatomic, strong) NSMutableArray *courseArray;
@property (nonatomic, strong) NSMutableArray *teachersArray;

@property (nonatomic, copy) NSArray *titlesArray;

@end

static NSString *ORGDETAIL_CELL_ID = @"orgdetail_cell_id";
static NSString *TEACHERS_CELL_ID = @"teachers_cell_id";
static NSString *COURSE_CELL_ID = @"course_cell_id";

@implementation OrganizationDetailVC

- (NSMutableDictionary *)orgDictionary {
    if (!_orgDictionary) {
        _orgDictionary = [[NSMutableDictionary alloc] init];
    }
    return _orgDictionary;
}

- (NSMutableArray *)courseArray {
    if (!_courseArray) {
        _courseArray = [[NSMutableArray alloc] init];
    }
    return _courseArray;
}

- (NSMutableArray *)teachersArray {
    if (!_teachersArray) {
        _teachersArray = [[NSMutableArray alloc] init];
    }
    return _teachersArray;
}

- (void)setUpViews {
    
    UIButton *rightNavButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightNavButton setImage:[UIImage imageNamed:@"tittle_shear"] forState:UIControlStateNormal];
    rightNavButton.frame = CGRectMake(kLayoutScreenWidth - KHEIGHT(73), KHEIGHT(27), KWIDTH(50), KHEIGHT(50));
    [rightNavButton addTarget:self action:@selector(rightNavButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    rightNavButton.selected = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightNavButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kLayoutScreenHeight - 64 - KHEIGHT(70)) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = kCommonBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[OrgDetailCell class] forCellReuseIdentifier:ORGDETAIL_CELL_ID];
    [self.tableView registerClass:[TeachersCell class] forCellReuseIdentifier:TEACHERS_CELL_ID];
    [self.tableView registerClass:[CourseCell class] forCellReuseIdentifier:COURSE_CELL_ID];
    [self.view addSubview:self.tableView];
}

- (void)setUpData {
    // service/getDetails
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.orgDict[@"id"] forKey:@"id"];
//    [dict setValue:@"71" forKey:@"id"];

    [dict setValue:[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"userId"] forKey:@"userId"];
    [MusicNetWorkTool POST:@"service/getDetails" parameters:dict success:^(id responseObject) {
        NSLog(@"get orgDetail %@", responseObject);
        NSDictionary *dataDict = responseObject[@"data"];
        if ([dataDict count] > 0) {
            self.orgDictionary = dataDict[@"org"];
            [self.courseArray addObjectsFromArray:dataDict[@"clist"]];
            [self.teachersArray addObjectsFromArray:dataDict[@"ulist"]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"get orgDetail error %@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kCommonBackgroundColor;
    self.navigationItem.title = @"机构详情";
    self.titlesArray = @[@"", @"机构简介", @"老师简介", @"课程"];
    [self setUpData];
    [self setUpViews];
    

    
}

#pragma mark - tableView delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.teachersArray.count > 0 && self.courseArray.count > 0) {
        return 4;
    } else if (self.teachersArray.count > 0 && self.courseArray.count <= 0) {
        return 3;
    } else if (self.teachersArray.count <= 0 && self.courseArray.count > 0) {
        return 3;
    } else {
        return 2;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            return 1;
        }
            break;
        case 1: {
            return 1;
        }
            break;
        case 2: {
            if (self.teachersArray.count <= 0 && self.courseArray.count > 0) {  // 没有师资有课程
                return self.courseArray.count;
            } else {
                return 1;
            }
        }
            break;
        case 3: {
            return self.courseArray.count;
        }
            break;
        default:
            return self.courseArray.count;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            NSString *phone = [NSString stringWithFormat:@"%@", self.orgDictionary[@"phone"]];
//            NSString *phone = @"";
            CGFloat height;
            if (phone.length > 0) {
                height = KWIDTH(410);
            } else {
                height = KWIDTH(350);
            }
            
            NSString *picStr = [NSString stringWithFormat:@"%@", self.orgDictionary[@"pic"]];
            NSArray *temp=[picStr componentsSeparatedByString:@","];
            if (temp.count == 1) {
                return KWIDTH(450) + height;
            } else if (temp.count == 2) {
                return KWIDTH(372) + height;
            } else {
                return KWIDTH(248) + height;
            }
        }
            break;
        case 1: {
            NSString *disc = [NSString stringWithFormat:@"%@", self.orgDictionary[@"disc"]];
            NSLog(@"%@", disc);
            CGSize discSize = [disc boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - KWIDTH(60), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:KWIDTH(28)]} context:nil].size;
            return discSize.height + KHEIGHT(60);
        }
            break;
        case 2: {
            if (self.teachersArray.count <= 0 && self.courseArray.count > 0) {  // 没有师资有课程
                return KHEIGHT(240);
            } else {
                return KHEIGHT(230);
            }
        }
            break;
        case 3: {
            return KHEIGHT(240);
        }
            break;
        default:
            return KHEIGHT(240);
            break;
    }
//    return KWIDTH(220);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    } else {
        return KHEIGHT(90);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, KHEIGHT(90))];
        headView.backgroundColor = [UIColor whiteColor];
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, KHEIGHT(1))];
        topLine.backgroundColor = KLineBackgroundColor;
        [headView addSubview:topLine];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(KWIDTH(30), KHEIGHT(29), KWIDTH(6), KHEIGHT(32))];
        leftView.backgroundColor = KLabelBlueColor;
        [headView addSubview:leftView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) + KWIDTH(12), KHEIGHT(1), 200, KHEIGHT(88))];
        label.font = [UIFont systemFontOfSize:KWIDTH(32)];
        label.textColor = kDarkLabelColor;
        label.text = self.titlesArray[section];
        [headView addSubview:label];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT(89), kLayoutScreenWidth, KHEIGHT(1))];
        bottomLine.backgroundColor = KLineBackgroundColor;
        [headView addSubview:bottomLine];
        return headView;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            OrgDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ORGDETAIL_CELL_ID forIndexPath:indexPath];
            cell.orgDict = self.orgDictionary;
            
            [cell.joinButton addTarget:self action:@selector(connectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            break;
        case 1: {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:KWIDTH(28)];
            label.textColor = kDarkLabelColor;
            label.numberOfLines = 0;
            label.text = self.orgDictionary[@"disc"];
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(KHEIGHT(30));
                make.bottom.offset(KHEIGHT(-30));
                make.left.offset(KWIDTH(30));
                make.right.offset(KWIDTH(-30));
            }];
            return cell;
        }
            break;
        case 2: {
            if (self.teachersArray.count <= 0 && self.courseArray.count > 0) {  // 没有师资有课程
                NSDictionary *dict = self.courseArray[indexPath.row];
                CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:COURSE_CELL_ID forIndexPath:indexPath];
                [cell.courseImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", dict[@"imgsrc"]]]];
                cell.titleLabel.text = [NSString stringWithFormat:@"%@", dict[@"cname"]];
                cell.timeLabel.text = [NSString stringWithFormat:@"%@至%@", dict[@"startdate"], dict[@"enddate"]];
                cell.countLabel.text = [NSString stringWithFormat:@"%@节课", dict[@"chour"]];
                cell.priceLabel.text = [NSString stringWithFormat:@"¥%@", dict[@"cost"]];
                if ([[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"type"] isEqualToString:@"1"]) {
                    if ([dict[@"isjoin"] integerValue] == 1) {
                        cell.signUpButton.selected = YES;
                    } else {
                        cell.signUpButton.selected = NO;
                    }
                    [cell.signUpButton addTarget:self action:@selector(signUpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                } 
                return cell;
            } else {
                TeachersCell *cell = [tableView dequeueReusableCellWithIdentifier:TEACHERS_CELL_ID forIndexPath:indexPath];
                cell.teachersArray = self.teachersArray;
                return cell;
            }
        }
            break;
        default: {
            NSDictionary *dict = self.courseArray[indexPath.row];
            CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:COURSE_CELL_ID forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.courseImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", dict[@"imgsrc"]]]];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@", dict[@"cname"]];
            cell.timeLabel.text = [NSString stringWithFormat:@"%@至%@", dict[@"startdate"], dict[@"enddate"]];
            cell.countLabel.text = [NSString stringWithFormat:@"%@节课", dict[@"chour"]];
            cell.priceLabel.text = [NSString stringWithFormat:@"¥%@", dict[@"cost"]];
            if ([[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"type"] isEqualToString:@"1"]) {
                if ([dict[@"isjoin"] integerValue] == 1) {
                    cell.signUpButton.selected = YES;
                } else {
                    cell.signUpButton.selected = NO;
                }
                [cell.signUpButton addTarget:self action:@selector(signUpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            return cell;
        }
            break;
    }
}

- (void)signUpButtonAction:(UIButton *)sender {
    
}

- (void)connectButtonAction:(UIButton *)sender {
    HomeAuditionVC *auditionVC = [[HomeAuditionVC alloc] init];
    auditionVC.orgName = [NSString stringWithFormat:@"%@", self.orgDict[@"name"]];
    auditionVC.orgImageURL = [NSString stringWithFormat:@"%@", self.orgDict[@"logo"]];
    auditionVC.orgId = [NSString stringWithFormat:@"%@", self.orgDict[@"id"]];
    NSLog(@"/////////////%ld", self.navigationController.viewControllers.count);
    [self.navigationController pushViewController:auditionVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 2: {
            if (self.teachersArray.count <= 0 && self.courseArray.count > 0) {
                CourseCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                
                NSDictionary *dict = self.courseArray[indexPath.row];
                CourseDetailVC *courseDeatilVC = [[CourseDetailVC alloc] init];
                courseDeatilVC.delegate = self;
                courseDeatilVC.courseId = [dict[@"cid"] integerValue];
                courseDeatilVC.isSignUped = [dict[@"isjoin"] boolValue];
                courseDeatilVC.courseTitle = [NSString stringWithFormat:@"%@", dict[@"cname"]];
                courseDeatilVC.coursedesc = [NSString stringWithFormat:@"%@至%@ %@课时", dict[@"startdate"], dict[@"enddate"], dict[@"chour"]];
                courseDeatilVC.courseImage = cell.courseImageView.image;
                courseDeatilVC.courseIndex = indexPath.row;
                if ([[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"type"] isEqualToString:@"1"]) {
                    courseDeatilVC.type = 0;
                } else {
                    courseDeatilVC.type = 1;
                }
                [self.navigationController pushViewController:courseDeatilVC animated:YES];
            }
        }
            break;
        case 3: {
            CourseCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            NSDictionary *dict = self.courseArray[indexPath.row];
            CourseDetailVC *courseDeatilVC = [[CourseDetailVC alloc] init];
            courseDeatilVC.delegate = self;
            courseDeatilVC.courseId = [dict[@"cid"] integerValue];
            courseDeatilVC.isSignUped = [dict[@"isjoin"] boolValue];
            courseDeatilVC.courseTitle = [NSString stringWithFormat:@"%@", dict[@"cname"]];
            courseDeatilVC.coursedesc = [NSString stringWithFormat:@"%@至%@ %@课时", dict[@"startdate"], dict[@"enddate"], dict[@"chour"]];
            courseDeatilVC.courseImage = cell.courseImageView.image;
            courseDeatilVC.courseIndex = indexPath.row;
            if ([[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"type"] isEqualToString:@"1"]) {
                courseDeatilVC.type = 0;
            } else {
                courseDeatilVC.type = 1;
            }
            [self.navigationController pushViewController:courseDeatilVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - courseDetailVC delegate
- (void)courseDetailVC:(CourseDetailVC *)detailVC signedAtIndex:(NSInteger)index {
    if (index >= 0) {
        NSDictionary *dataDict = self.courseArray[index];
        NSMutableDictionary *signDict = [dataDict mutableCopy];
        [signDict setValue:@"1" forKey:@"isjoin"];
        [self.courseArray replaceObjectAtIndex:index withObject:signDict];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}


- (void)rightNavButtonAction:(UIButton *)sender {
    //    NSLog(@"`````````  %@\n %@", dic,[dic objectForKey:@"disc"]);
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        [self shareWebPageToPlatformType:platformType imgaeUrl:self.shareImage title:[NSString stringWithFormat:@"%@", self.orgDict[@"name"]] introlduction:@"" webUrl:[NSString stringWithFormat:@"http://www.8lingling.com/admin/orgDetail2.html?id=%@",[self.orgDict objectForKey:@"id"]]];
    }];
    
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType imgaeUrl:(UIImage *)img title:(NSString*)title introlduction:(NSString*)introl webUrl:(NSString*)web
{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    //    NSString* thumbURL = img;
    UMShareWebpageObject * shareObject;
    
    shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:introl thumImage:img];
    //设置网页地址
    shareObject.webpageUrl = web;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        
    }];
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
