//
//  UIColor+extension.h
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/8.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (extension)
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)color;
@end
