//
//  MCDynamicCell.h
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/8.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"

@protocol deleOrGuanli <NSObject>


@required
- (void)deleL:(NSString *)dyId;

- (void)guanL:(NSString *)dyId;
@end
@interface MCDynamicCell : UITableViewCell
- (void)selectDynamic:(DynamicModel *)dynamic;
@property(nonatomic,weak)id<deleOrGuanli>DGdelegate;
@end
