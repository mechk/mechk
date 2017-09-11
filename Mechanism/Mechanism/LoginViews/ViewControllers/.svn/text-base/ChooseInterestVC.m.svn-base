//
//  ChooseInterestVC.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/7/25.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "ChooseInterestVC.h"

@interface ChooseInterestVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableDictionary *selectedDictionary;

@end

static NSString *CHOOSEINTEREST_CELL_ID = @"chooseInterest_cell_id";

@implementation ChooseInterestVC

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KHEIGHT(240), kLayoutScreenWidth, KHEIGHT(700)) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        [_collectionView registerClass:[ChooseInterestCell class] forCellWithReuseIdentifier:CHOOSEINTEREST_CELL_ID];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(KWIDTH(30), CGRectGetMaxY(_collectionView.frame) + KHEIGHT(100), kLayoutScreenWidth - KWIDTH(60), KHEIGHT(90));
        [button setBackgroundImage:[UIImage imageNamed:@"Org_Register_Button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"Org_Register_Button_Select"] forState:UIControlStateSelected];
        [button setTitle:@"选好了" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(registerWithInterests:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    return _collectionView;
}

- (void)setUpViews {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(kLayoutScreenWidth - KWIDTH(100), KHEIGHT(65), KWIDTH(70), KHEIGHT(42));
    rightButton.titleLabel.font = [UIFont systemFontOfSize:KWIDTH(30)];
    [rightButton setTitle:@"跳过" forState:UIControlStateNormal];
    [rightButton setTitleColor:kDarkLabelColor forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightNavButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, KHEIGHT(124), kLayoutScreenWidth, KWIDTH(40))];
    label.text = @"选择你感兴趣的频道";
    label.textColor = KLabelBlueColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:KWIDTH(36)];
    [self.view addSubview:label];
    
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - KHEIGHT(270), [UIScreen mainScreen].bounds.size.width, KHEIGHT(270))];
    [bottomImageView setImage:[UIImage imageNamed:@"Org_Register_Background"]];
    [self.view addSubview:bottomImageView];
}

- (void)setUpData {
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setValue:@"1" forKey:@"likelist"];
    [MusicNetWorkTool POST:@"service/getlikeList" parameters:dict1 success:^(id responseObject) {
        NSLog(@"interest list %@ %@", responseObject[@"msg"], responseObject);
        if ([responseObject[@"data"] count]>0) {
            [self.dataArray addObjectsFromArray:responseObject[@"data"]];
        }
        for (int i = 0; i < self.dataArray.count; i++) {
            self.selectedDictionary[@(i)] = @(1);
        }
        
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"interest list error %@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showNavi = NO;
    self.selectedDictionary = [[NSMutableDictionary alloc] init];
    [self setUpViews];
    [self setUpData];
    
}

#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArray[indexPath.item];
    ChooseInterestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CHOOSEINTEREST_CELL_ID forIndexPath:indexPath];
    [cell.backImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", dict[@"pic"]]] placeholderImage:[CommonTool imageWithColor:KImageViewBackGroundColor]];
    cell.selectButton.hidden = NO;
    NSNumber *key = @(indexPath.item);
    if ([self.selectedDictionary[key] integerValue] == 1) {
        cell.selectButton.selected = YES;
    } else {
        cell.selectButton.selected = NO;
    }
    return cell;
}

#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *key = @(indexPath.item);
    if ([self.selectedDictionary[key] integerValue] == 1) {
        self.selectedDictionary[key] = @(0);
    } else {
        self.selectedDictionary[key] = @(1);
    }
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

#pragma mark - Collection view flow layout delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [ChooseInterestCell size];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, KWIDTH(30), 0, KWIDTH(30));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return KWIDTH(80);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return KWIDTH(30);
}

#pragma mark - 按钮点击事件
- (void)registerWithInterests:(UIButton *)sender {  // 选好了
    [self upLoadData];
}

- (void)rightNavButtonAction:(UIButton *)sender {   // 跳过
    [self upLoadData];
}

- (void)upLoadData {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    NSMutableString *string =[[NSMutableString alloc] init];
    for (NSNumber *key in self.selectedDictionary.allKeys) {
        if ([self.selectedDictionary[key] integerValue] == 1) {
            NSInteger index = [key integerValue];
            NSDictionary *dict = self.dataArray[index];
            [string appendString:[NSString stringWithFormat:@"%@,", dict[@"id"]]];
        }
    }
    if (string.length>0) {
        [dict setValue:[string substringToIndex:string.length-1] forKey:@"slike"];
    }
    [dict setValue:[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"userId"] forKey:@"userId"];
    [dict setValue:[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"key"] forKey:@"key"];
    [MusicNetWorkTool POST:@"/service/addSlike" parameters:dict success:^(id responseObject) {
        NSLog(@"choose Interest %@ %@", responseObject[@"msg"], responseObject);
        NSLog(@"choose Interest dict %@", dict);
        [self dismissSelf];
    } failure:^(NSError *error) {
        NSLog(@"choose Interest error %@", error);
        NSLog(@"choose Interest dict %@", dict);
    }];
}

- (void)dismissSelf {
    [self dismissViewControllerAnimated:YES completion:nil];
    // 6.9更改
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //            [[UIApplication sharedApplication].keyWindow setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"NavVC"]];
    self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"NavVC"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotication" object:nil];
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
