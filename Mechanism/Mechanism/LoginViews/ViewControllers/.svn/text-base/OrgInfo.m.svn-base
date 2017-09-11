//
//  OrgInfo.m
//  MusicSchool
//
//  Created by iMobile on 16/9/2.
//  Copyright © 2016年 iMobile. All rights reserved.
//

#import "OrgInfo.h"

@interface OrgInfo ()

@end

@implementation OrgInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://www.8lingling.com/staticmusic/orgApplication.html"]] ;
    //

       NSURLRequest  *URLRequest =[NSURLRequest  requestWithURL:url];
        [_webView loadRequest:URLRequest];
    // Do any additional setup after loading the view.
}

-(IBAction)gotoBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
