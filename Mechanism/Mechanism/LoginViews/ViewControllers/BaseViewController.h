//
//  BaseViewController.h
//  MusicSchool
//
//  Created by Mac02Nvisoft on 2017/6/6.
//  Copyright © 2017年 iMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL haveBack;
@property (nonatomic, assign) BOOL showNavi;

- (void)returnBtnTapped:(id)sender;

@end
