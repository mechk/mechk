//
//  TeachersCell.m
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/8/24.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import "TeachersCell.h"
#import "TeacherIntroduceCell.h"

@interface TeachersCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *teachersCollectionView;

@end

static NSString *TEACHERINTRODUCE_CELL_ID = @"teacherIntroduce_cell_id";

@implementation TeachersCell

- (UICollectionView *)teachersCollectionView {
    if (!_teachersCollectionView) {
        
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        layout.sectionInset = UIEdgeInsetsMake(10, 10, 20, 10);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = KWIDTH(40);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _teachersCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _teachersCollectionView.backgroundColor = [UIColor whiteColor];
        [_teachersCollectionView registerClass:[TeacherIntroduceCell class] forCellWithReuseIdentifier:TEACHERINTRODUCE_CELL_ID];
        
        _teachersCollectionView.delegate = self;
        _teachersCollectionView.dataSource = self;
        _teachersCollectionView.showsHorizontalScrollIndicator = NO;
        _teachersCollectionView.showsVerticalScrollIndicator = NO;
        [self addSubview:_teachersCollectionView];
        [_teachersCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.top.offset(0);
            make.bottom.offset(0);
        }];
    }
    return _teachersCollectionView;
}

#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%@  %ld", self.teachersArray, self.teachersArray.count);
    return self.teachersArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.teachersArray[indexPath.item];
    NSLog(@"%@", dict);
    TeacherIntroduceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TEACHERINTRODUCE_CELL_ID forIndexPath:indexPath];
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", dict[@"pic"]]] placeholderImage:[UIImage imageNamed:@"Common_noheadimage"]];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", dict[@"name"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Collection view flow layout delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%f %f", [TeacherIntroduceCell size].height, [TeacherIntroduceCell size].width);
    return [TeacherIntroduceCell size];
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, KWIDTH(20), 0, KWIDTH(20));
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return KWIDTH(20);
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return KWIDTH(20);
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeMake(kLayoutScreenWidth, KHEIGHT(30));
//}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        //        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        self.backgroundColor = kCommonBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.teachersCollectionView.hidden = NO;
    }
    return self;
}

@end
