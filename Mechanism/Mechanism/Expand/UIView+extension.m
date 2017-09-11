//
//  UIView+extension.m
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/9.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import "UIView+extension.h"

@implementation UIView (extension)
+(UIView *)oneline:(CGRect)frame{
    UIView *lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    return lineView;
}
@end
