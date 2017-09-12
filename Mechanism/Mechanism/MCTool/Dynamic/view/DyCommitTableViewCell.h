//
//  DyCommitTableViewCell.h
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/11.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"



@protocol deleCommit <NSObject>



- (void)delecommit;
//service/delExperiencesComment
@end


@interface DyCommitTableViewCell : UITableViewCell
- (void)selectDynamic:(DynamicModel *)dynamic;
@end
