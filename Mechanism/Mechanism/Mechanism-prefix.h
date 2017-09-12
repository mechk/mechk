//
//  Mechanism-prefix.h
//  Mechanism
//
//  Created by 赵博宇 on 2017/9/8.
//  Copyright © 2017年 赵博宇. All rights reserved.
//

#ifndef Mechanism_prefix_h
#define Mechanism_prefix_h


#import "UIColor+extension.h"
#import "NSString+extension.h"
#import "UIView+extension.h"
#import "MBProgressHUD.h"
#import <MJRefresh.h>
#import <View+MASAdditions.h>
#import "DataAfn.h"
#import <util.h>

//颜色
#define BlueColor [UIColor colorWithHexString:@"#55c7f4"]
#define BackColor [UIColor colorWithHexString:@"#EEEEEE"]
#define kDarkLabelColor [UIColor colorWithHexString:@"#4a4a4a"]
//长宽比例
#define scaleW [UIScreen mainScreen].bounds.size.width/375/2
#define scaleH [UIScreen mainScreen].bounds.size.height/667/2

#define  kLayoutScreenWidth             ([UIScreen mainScreen].bounds.size.width)
#define  kLayoutScreenHeight            ([UIScreen mainScreen].bounds.size.height)

#define def_width [UIScreen mainScreen].bounds.size.width
#define def_height [UIScreen mainScreen].bounds.size.height
#define MainFontOfSize(fontSize) [UIFont systemFontOfSize:fontSize]
// 宽高计算
#define KWIDTH(WIDTH) (WIDTH / 750.0 * ([UIScreen mainScreen].bounds.size.width))
#define KHEIGHT(HEIGHT) (HEIGHT / 1334.0 * ([UIScreen mainScreen].bounds.size.height))


#import <UIImageView+WebCache.h>
#endif /* Mechanism_prefix_h */
