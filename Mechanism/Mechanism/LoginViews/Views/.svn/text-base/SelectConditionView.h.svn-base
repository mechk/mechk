//
//  SelectConditionView.h
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/8/8.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectConditionView;

@protocol SelectConditionViewDelegate <NSObject>

- (void)selectConditionView:(SelectConditionView *)conditionView didSelectLeftRowAtIndex:(NSInteger)index withAreaCode:(NSString *)areaCode AreaName:(NSString *)areaName;
- (void)selectConditionView:(SelectConditionView *)conditionView didSelectRightRowAtIndex:(NSInteger)index withAreaCode:(NSString *)areaCode AreaName:(NSString *)areaName;
- (void)selectConditionView:(SelectConditionView *)conditionView backViewDidClick:(UIView *)backView;
@end

@interface SelectConditionView : UIView

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSArray *leftArray;
@property (nonatomic, copy) NSArray *rightArray;

@property (nonatomic, assign) id <SelectConditionViewDelegate> delegate;

@end
