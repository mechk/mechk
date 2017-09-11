//
//  ForgetCodeNext.h
//  ShuGeShow
//
//  Created by iMobile on 16/2/21.
//  Copyright © 2016年 iMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ForgetCodeNextDelegate <NSObject>

-(void)ForgetCodeNextDelegateDone;

@end
@interface ForgetCodeNext : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *orgPwdText;

@property (weak, nonatomic) IBOutlet UITextField *pwdText;
//@property (weak, nonatomic) IBOutlet UITextField *rePwdText;

@property (assign, nonatomic) BOOL isForget;
@property (retain, nonatomic) NSString *account;

@property(nonatomic,assign) id< ForgetCodeNextDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextField *acountText;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;

@end
