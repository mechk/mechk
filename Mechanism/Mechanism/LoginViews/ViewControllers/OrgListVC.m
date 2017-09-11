//
//  OrgListVC.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/6/30.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "OrgListVC.h"
#import "RPRingedPages.h"

#import "OrgListView.h"
#import "OtherDetail.h"
#import "Login.h"

@interface OrgListVC () <RPRingedPagesDelegate, RPRingedPagesDataSource>
{
    SBJsonParser * parser;
    NSInteger selectIndex;
}

@property (nonatomic, strong) RPRingedPages *pages;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *totalCountLabel;
@property (nonatomic, strong) UILabel *currentIndexLabel;

@end

@implementation OrgListVC

- (RPRingedPages *)pages {
    if (_pages == nil) {
//        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGRect pagesFrame = CGRectMake(0, KHEIGHT(202), kLayoutScreenWidth, kLayoutScreenHeight * 0.75);
        
        RPRingedPages *pages = [[RPRingedPages alloc] initWithFrame:pagesFrame];
//        CGFloat height = pagesFrame.size.height - pages.pageControlHeight - pages.pageControlMarginTop - pages.pageControlMarginBottom;
        pages.carousel.mainPageSize = CGSizeMake(KWIDTH(640), KWIDTH(640) / 16 * 25);
        pages.carousel.autoScrollInterval = 0;
        pages.carousel.pageScale = 0.93;
        pages.showPageControl = NO;
        pages.dataSource = self;
        pages.delegate = self;
        
        _pages = pages;
    }
    return _pages;
}
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)setUpViews {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(KWIDTH(20), KHEIGHT(60), KWIDTH(50), KHEIGHT(50));
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH(8), KHEIGHT(9), KHEIGHT(19), KHEIGHT(36))];
    [backImageView setImage:[UIImage imageNamed:@"Org_list_arrow_back"]];
    [backButton addSubview:backImageView];
    [self.view addSubview:backButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - KWIDTH(100), KHEIGHT(65), KWIDTH(200), KHEIGHT(50))];
    self.titleLabel.font = [UIFont systemFontOfSize:KWIDTH(33)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = self.navTitle;
    [self.view addSubview:self.titleLabel];
    
    self.currentIndexLabel = [[UILabel alloc] init];
    self.currentIndexLabel.textColor = [UIColor whiteColor];
    self.currentIndexLabel.font = [UIFont systemFontOfSize:KWIDTH(72)];
    [self.view addSubview:self.currentIndexLabel];
    [self.currentIndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(KHEIGHT(-20));
        make.right.offset(-kLayoutScreenWidth / 2);
    }];
    self.totalCountLabel = [[UILabel alloc] init];
    self.totalCountLabel.textColor = [UIColor whiteColor];
    self.totalCountLabel.font = [UIFont systemFontOfSize:KWIDTH(36)];
    [self.view addSubview:self.totalCountLabel];
    __weak typeof(self) weakSelf = self;
    [self.totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.currentIndexLabel.mas_right);
        make.bottom.offset(KHEIGHT(-29));
    }];
}

- (void)backButtonAction:(UIButton *)sender {
    self.pages.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, kLayoutScreenHeight)];
    [backImageView setImage:[UIImage imageNamed:@"Org_list_backImage"]];
    [self.view addSubview:backImageView];
    parser = [[SBJsonParser alloc]init];
    self.showNavi = NO;
    [self.view addSubview:self.pages];
    [self setUpViews];
    [self makeDataSource];
//    [self getResourceList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.showNavi = NO;

    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor clearColor];
    }
}

- (void)makeDataSource {
    if (self.type == 2) {
        self.dataSource = [DataManager mutableArrayFromFile:@"orgList"];
//        self.dataSource = [[NSUserDefaults standardUserDefaults] objectForKey:@"org"];
        [self.pages reloadData];
        self.totalCountLabel.text = [NSString stringWithFormat:@"/%ld", self.dataSource.count];
        self.currentIndexLabel.text = @"1";
    } else {
        NSDictionary *dict = @{@"pageNum":@"1"};
        [MusicNetWorkTool POST:@"service/getOrgList" parameters:dict success:^(id responseObject) {
            NSLog(@"getOrgList %@  ,%@", responseObject, responseObject[@"msg"]);
            if ([responseObject[@"status"] integerValue] == 0) {
                for (NSDictionary *item in responseObject[@"data"]) {
                    [self.dataSource addObject:item];
                    NSLog(@"%@", [NSString stringWithFormat:@"%@", item[@"name"]]);
                }
                [self.pages reloadData];
                self.totalCountLabel.text = [NSString stringWithFormat:@"/%ld", self.dataSource.count];
                self.currentIndexLabel.text = @"1";
            }  
        } failure:^(NSError *error) {
            
        }];
    }
//    for (int i=0; i<9; i++) {
//        NSString *s = [NSString stringWithFormat:@"%c", i + 'A'];
//        [self.dataSource addObject:s];
//    }
//    [self.pages reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfItemsInRingedPages:(RPRingedPages *)pages {
    return self.dataSource.count;
}

- (UIView *)ringedPages:(RPRingedPages *)pages viewForItemAtIndex:(NSInteger)index {
    NSDictionary *dict = self.dataSource[index];
    NSLog(@"%@", dict);
    NSLog(@"%@", [NSString stringWithFormat:@"%@", dict[@"name"]]);

    OrgListView *listView = [[OrgListView alloc] init];
    [listView.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", dict[@"logo"]]] placeholderImage:[UIImage imageNamed:@"Common_noheadimage"]];
    listView.nameLabel.text = [NSString stringWithFormat:@"%@", dict[@"name"]];
    [listView.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", dict[@"pic"]]] placeholderImage:[UIImage imageNamed:@"One_placehoder"]];
    listView.discLabel.text = [NSString stringWithFormat:@"%@", dict[@"disc"]];
    listView.addressLabel.text = [NSString stringWithFormat:@"%@", dict[@"address"]];
    [listView.joinButton setTitle:self.buttonTitle forState:UIControlStateNormal];
    listView.joinButton.tag = index + 200;
    [listView.joinButton addTarget:self action:@selector(joinButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return listView;
}

- (void)joinButtonAction:(UIButton *)sender {
    switch (self.type) {
        case 1: {
//            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            OtherDetail *otherDetailVC = (OtherDetail *)[sb instantiateViewControllerWithIdentifier:@"OTHERDETAIL"];
//            NSDictionary *dict = self.dataSource[sender.tag - 200];
//            otherDetailVC.dic = dict;
//            [self.navigationController pushViewController:otherDetailVC animated:YES];
        }
            break;
        case 2: {
            if (![[DataManager mutableDictionaryFromFile:@"org"] objectForKey:@"id"]) {
                [DataManager writeDictionary:self.dataSource[sender.tag - 200] ToFile:@"org"];
                for (UIViewController *tempVC in self.navigationController.viewControllers) {
                    if ([tempVC isKindOfClass:[Login class]]) {
                        [tempVC dismissViewControllerAnimated:YES completion:nil];
                    } else {
                        //                [self.navigationController popViewControllerAnimated:YES];
                    }
                }
                [self.navigationController popViewControllerAnimated:YES];
                
            } else {
                [DataManager writeDictionary:self.dataSource[sender.tag - 200] ToFile:@"org"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            [[UIApplication sharedApplication].keyWindow setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"NavVC"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotication" object:nil];

        }
            break;
        case 3: {
            selectIndex = sender.tag - 200;
            [[[UIAlertView alloc] initWithTitle:nil message:@"确定关注机构吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil] show];
        }
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self getResourceList1];
    }
}
-(void)getResourceList1{
    
    NSURL *url = [ NSURL URLWithString :@"http://www.8lingling.com/ms/service/selfJoinOrg"];
    
    ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
    [request addPostValue:[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"userId"] forKey:@"userId"];
    [request addPostValue:[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"key"] forKey:@"key"];
    [request addPostValue:[[self.dataSource objectAtIndex:selectIndex]  objectForKey:@"id"] forKey:@"orgId"];
    
    [request startSynchronous];
    if (request.responseString.length>0) {
        
        NSString *string = [[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding];
        
        //        [reString  setString:[[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding]];
        [self performSelectorOnMainThread:@selector(requestFinished1:) withObject:string waitUntilDone:YES];
        
    }
    else{
        [Util showMesssage:@"出现未知错误，请重试！"];
    }
}


- (void)requestFinished1:(NSString *)aString
{
    
    //////////NSLog(@"login%@",aString);
    if ([[parser objectWithString:aString ]  isKindOfClass: [NSDictionary class]])
        
    {
        NSDictionary *dict = [parser objectWithString:aString ];
        
        if ([[dict objectForKey:@"status"] intValue]==0) {
            //            [Util showMesssage:[dic objectForKey:@"msg"]];
            
            [DataManager writeDictionary:[self.dataSource objectAtIndex:selectIndex] ToFile:@"org"];
            
            //            [self.navigationController popToRootViewControllerAnimated:YES];
            //
            [self dismissViewControllerAnimated:YES completion:nil];
            // 6.9更改
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //            [[UIApplication sharedApplication].keyWindow setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"NavVC"]];
            self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"NavVC"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotication" object:nil];
        } else {
            [Util showMesssage:[dict objectForKey:@"msg"] ];
        }
        
    }
    else{
        [Util showMesssage:@"请求失败，请稍后再试"];
    }
    
}


- (void)didSelectedCurrentPageInPages:(RPRingedPages *)pages {
    NSLog(@"pages selected, the current index is %zd", pages.currentIndex);
}
- (void)pages:(RPRingedPages *)pages didScrollToIndex:(NSInteger)index {
    NSLog(@"pages scrolled to index: %zd", index);
    self.currentIndexLabel.text = [NSString stringWithFormat:@"%ld", index + 1];
}


- (CGSize)originMainPageSize {
    CGFloat height = [UIScreen mainScreen].bounds.size.width * 0.4;
    height -= (self.pages.pageControlHeight + self.pages.pageControlMarginTop + self.pages.pageControlMarginBottom);
    return CGSizeMake(height * 0.8, height);
}



@end
