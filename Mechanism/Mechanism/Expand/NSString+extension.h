//
//  NSString+extension.h
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/8.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (extension)
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font reducedWidth:(CGFloat)floatWidth;
@end
