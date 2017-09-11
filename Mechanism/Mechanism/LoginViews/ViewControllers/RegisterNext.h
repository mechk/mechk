//
//  RegisterNext.h
//  UCreate
//
//  Created by iMobile on 15/12/24.
//  Copyright © 2015年 imobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterNext : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *acountText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
@property (weak, nonatomic) IBOutlet UITextField *rePwdText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;

@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property ( nonatomic) NSString *codeString;

@property ( nonatomic) NSString *acountString;
@property ( nonatomic,retain) NSString *thirdID;

@end
