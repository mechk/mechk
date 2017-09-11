//
//  NSString+extension.m
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/8.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#import "NSString+extension.h"

@implementation NSString (extension)
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font reducedWidth:(CGFloat)floatWidth
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-floatWidth, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}
@end
