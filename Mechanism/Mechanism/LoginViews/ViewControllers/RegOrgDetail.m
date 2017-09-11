//
//  RegOrgDetail.m
//  MusicSchool
//
//  Created by iMobile on 16/9/2.
//  Copyright © 2016年 iMobile. All rights reserved.
//

#import "RegOrgDetail.h"

@interface RegOrgDetail ()
{
    SBJsonParser * parser;

}

@end

@implementation RegOrgDetail

@synthesize dic;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://www.8lingling.com/admin/orgDetail.html?args=%@",[dic objectForKey:@"id"]]] ;
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
-(IBAction)inAction:(UIButton *)button
{
    
    
    
    //    ////////NSLog(@"%@",[DataManager  mutableDictionaryFromFile:@"org"]);
    
    //    if ([[DataManager mutableDictionaryFromFile:@"org"] objectForKey:@"id"]) {
    //        [DataManager writeDictionary:[list objectAtIndex:button.tag] ToFile:@"org"];
    //
    //
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }
    //    else{
    //        [DataManager writeDictionary:[list objectAtIndex:button.tag] ToFile:@"org"];
    //
    //        [self dismissViewControllerAnimated:YES completion:nil];
    //
    //    }
    
//    actionIndex= button.tag;
    [ [[UIAlertView alloc] initWithTitle:nil message:@"确定加入机构吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil] show];
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotication" object:nil];
    
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        
        
        [self getResourceList1];
        
    }
}
-(void)getResourceList1{
    
    NSURL *url = [ NSURL URLWithString :@"http://www.8lingling.com/ms/service/selfJoinOrg"];
    
    ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
    [request addPostValue:[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"userId"] forKey:@"userId"];
    [request addPostValue:[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"key"] forKey:@"key"];
    [request addPostValue:[dic  objectForKey:@"id"] forKey:@"orgId"];
    
    [request startSynchronous];
    if (request.responseString.length>0) {
        
        NSString *string = [[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding];
        
        //        [reString  setString:[[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding]];
        [self performSelectorOnMainThread:@selector(requestFinished1:) withObject:string waitUntilDone:YES];
        
    }
    else{
        [Util showMesssage:@"出现未知错误，请重试！"];
    }
}


- (void)requestFinished1:(NSString *)aString
{
    
    //////////NSLog(@"login%@",aString);
    if ([[parser objectWithString:aString ]  isKindOfClass: [NSDictionary class]])
        
    {
        NSDictionary *dict = [parser objectWithString:aString ];
        
        if ([[dict objectForKey:@"status"] intValue]==0) {
            //            [Util showMesssage:[dic objectForKey:@"msg"]];
            
            [DataManager writeDictionary:dic ToFile:@"org"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotication" object:nil];
            
            [self gotoBack:nil];
            
        }
        
        else{
            [Util showMesssage:[dict objectForKey:@"msg"] ];
            
        }
        
    }
    else{
        [Util showMesssage:@"请求失败，请稍后再试"];
    }
    
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
