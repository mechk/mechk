//
//  Home.m
//  ShuGeShow
//
//  Created by iMobile on 16/2/25.
//  Copyright © 2016年 iMobile. All rights reserved.
//

#import "OrgSelect.h"
//#import "HomeDetail.h"
#import "SDCycleScrollView.h"
#import "Home.h"
#import "HomeTableViewCell0.h"
#import "HomeTableViewCell1.h"
#import "CollectionViewCell.h"
#import "ViewController.h"

#import "HomeCategory.h"

#import "Login.h"
#import "AppDelegate.h"

static NSString * const CellReuseIdentify = @"CellReuseIdentify";
static NSString * const SupplementaryViewHeaderIdentify = @"SupplementaryViewHeaderIdentify";
static NSString * const SupplementaryViewFooterIdentify = @"SupplementaryViewFooterIdentify";
@interface OrgSelect ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableString *reString;
    
    SBJsonParser * parser;
    NSMutableArray *list;
   // NSMutableArray *list0;

    NSMutableDictionary *dic;
    NSMutableDictionary *cDic;

    NSMutableDictionary *nextDic;

    int page;
    BOOL isHead;

    NSDateFormatter* formatter ;
    
    int tag;
    
    NSMutableArray *catalogList;
    NSMutableArray *contentList100Number;
    NSMutableArray *contentList100Content;

    NSMutableArray *contentList100TableView;
    NSMutableArray *contentList100Total;
    NSMutableArray *contentList100Carousel;
    int cIndex;
//    NSArray *list;
    NSMutableArray *collect1;
    CGFloat cellHeight;//cell的高度
}

@end

@implementation OrgSelect

//@synthesize list;


//http://www.shugeshow.com//getAuth.php

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
//    ////////NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
//    [self performSelectorInBackground:@selector(getResourceList0) withObject:nil];
//    [self performSelectorInBackground:@selector(getResourceList1) withObject:nil];
}
-(IBAction)gotoBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    list = [[ NSArray alloc] initWithArray:[DataManager mutableArrayFromFile:@"orgList"]];
    list = [[NSMutableArray alloc]init];
    
    list = [[NSUserDefaults standardUserDefaults]objectForKey:@"org"];
    
    NSLog(@"%@", list);
    
    parser = [[SBJsonParser alloc]init];
    ////////NSLog(@"list %@",list);
//    _topView.frame =CGRectMake(0, 64, kLayoutScreenWidth, kLayoutScreenWidth/2);
    
    
//    _tableView.frame= CGRectMake(0, 64+kLayoutScreenWidth/2, kLayoutScreenWidth, self.view.frame.size.height-64-kLayoutScreenWidth/2);

//        [self performSelectorInBackground:@selector(getResourceList0) withObject:nil];
//        [self performSelectorInBackground:@selector(getResourceList1) withObject:nil];

    
//    [self setupRefresh];

    
//    NSString *filePath = [[NSBundle mainBundle ] pathForResource:@"data" ofType:@"json"];
//    NSString *file = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    
//    catalogList  = [[NSArray alloc] initWithArray: [parser objectWithString:file ]];
    
    contentList100Number =[[NSMutableArray alloc] init];
    contentList100TableView =[[NSMutableArray alloc] init];
    contentList100Total =[[NSMutableArray alloc] init];
    contentList100Content  =[[NSMutableArray alloc] init];
    contentList100Carousel  =[[NSMutableArray alloc] init];
    catalogList  =[[NSMutableArray alloc] init];
    
    collect1 =[[NSMutableArray alloc] init];
//    ////////NSLog(@"viewDidLoad");
    
    [self  performSelectorInBackground:@selector(getResourceList) withObject:nil];
//    [self setupRefresh];

    
    
//    ////////NSLog(@"resDic %d",resDic.count);
    
    // Do any additional setup after loading the view.
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
//    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //  [_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    _tableView.headerPullToRefreshText = @"下拉刷新...";
//    _tableView.headerReleaseToRefreshText = @"释放刷新...";
//    _tableView.headerRefreshingText = @"正在加载...";
    
    _tableView.footerPullToRefreshText = @"上拉刷新...";
    _tableView.footerReleaseToRefreshText = @"释放刷新...";
    _tableView.footerRefreshingText = @"正在加载...";
}
- (void)footerRereshing
{
    //    isHead = NO;
    
    [self performSelectorInBackground:@selector(getResourceList) withObject:nil];;
    
    //    // 1.添加假数据
    //    for (int i = 0; i<5; i++) {
    //        [self.fakeData addObject:MJRandomData];
    //    }
    //
    //    // 2.2秒后刷新表格UI
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        // 刷新表格
    //        [self.tableView reloadData];
    //
    //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    //        [self.tableView footerEndRefreshing];
    //    });
}



-(void)updateViewConstraints
{
    
//    ////////NSLog(@"updateViewConstraints");
    
    [super updateViewConstraints];
    
//    [self setupView];
    
    
    
//    [self getResourceList2];
    
    
//    ////////NSLog(@"updateViewConstraints");
//    [self performSelectorInBackground:@selector(getResourceList2) withObject:nil];
//    [self performSelectorInBackground:@selector(getResourceList1) withObject:nil];
}

/*

-(void)getResourceList2
{
    NSString *filePath = [[NSBundle mainBundle ] pathForResource:@"category" ofType:@"json"];
    NSString *file = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    ////////NSLog(@"file0 %@",file );

//    ////////NSLog(@"file1 %@",[parser objectWithString:file ]  );
    catalogList  = [[NSArray alloc] initWithArray: [[parser objectWithString:file ] objectForKey:@"res"]  ];
    
//    ////////NSLog(@"catalogList %@",catalogList);


    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
//    NSMutableArray *buttonArray = [NSMutableArray array];
    
    if (catalogList.count<4&&catalogList.count>0)
    {
        
        
        for (int i=0; i<catalogList.count; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame =CGRectMake((kLayoutScreenWidth/catalogList.count)*i, 0,kLayoutScreenWidth/catalogList.count, 44);
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
            button.tag = i;
            
            //                    ////////NSLog(@"!!!%@",[[catalogList objectAtIndex:i] objectForKey:@"catalogName"]);
            [button setTitle:[[catalogList objectAtIndex:i] objectForKey:@"catalogName"]  forState:UIControlStateNormal];
            [button addTarget:self action:@selector(view0_1_catalog_action:) forControlEvents:UIControlEventTouchUpInside];
            [_view0_1_sel_scrollView addSubview:button];
            
            UITableView *tableView = [[UITableView alloc] initWithFrame: CGRectMake(kLayoutScreenWidth*i,0, kLayoutScreenWidth,_view0_1_scrollView.frame.size.height)];
            tableView.dataSource = self;
            tableView.delegate = self;
            
            tableView.tag = 100+i;
            
            [_view0_1_scrollView addSubview:tableView];
            
            
            
            
            [contentList100TableView addObject:tableView];
            
            
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"竖直的下划线"]];
            imageView.frame =CGRectMake((kLayoutScreenWidth/catalogList.count)*i, 11, 1, 22);
            if (i!=0) {
                [_view0_1_sel_scrollView addSubview:imageView];
            }
            //            [imageView release];
            
        }
        
        _view0_1_CatalogLine.frame =CGRectMake(0, 42, kLayoutScreenWidth/catalogList.count, 2);
        
        
        _view0_1_sel_scrollView.contentSize = CGSizeMake(kLayoutScreenWidth, 44);
        
        
        
    }
    
    
    
    
    else
        if(catalogList.count>=4){
            
            for (int i=0; i<catalogList.count; i++) {
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame =CGRectMake(80*i, 0,80, 44);
                button.titleLabel.font = [UIFont systemFontOfSize:15];
                [button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
                button.tag = i;
                
                //                    ////////NSLog(@"!!!%@",[[catalogList objectAtIndex:i] objectForKey:@"catalogName"]);
                [button setTitle:[[catalogList objectAtIndex:i] objectForKey:@"catalogName"]  forState:UIControlStateNormal];
                [button addTarget:self action:@selector(view0_1_catalog_action:) forControlEvents:UIControlEventTouchUpInside];
                [_view0_1_sel_scrollView addSubview:button];
 
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"竖直的下划线"]];
                imageView.frame =CGRectMake(80*i, 11, 1, 22);
                if (i!=0) {
                    [_view0_1_sel_scrollView addSubview:imageView];
                }
                //                [imageView release];
                
            }
            
            
            
            _view0_1_CatalogLine.frame =CGRectMake(0, 42,80, 2);
            
            _view0_1_sel_scrollView.contentSize = CGSizeMake(80*catalogList.count+catalogList.count%3+(int)(catalogList.count/3)*2, 44);
            
            //            ////////NSLog(@"what %d",80*catalogList.count+catalogList.count%3+(int)(catalogList.count/3)*2);
            
            
            
        }
    
    
    
    
    for (int i=0; i<catalogList.count; i++) {
        [contentList100Number addObject:[NSString stringWithFormat:@"%d",1]];
    }
    
    for (int i=0; i<catalogList.count; i++) {
        [contentList100Total addObject:[NSString stringWithFormat:@"%d",0]];
    }
    for (int i=0; i<catalogList.count; i++) {
        NSMutableArray *array = [NSMutableArray  array];
        
        [contentList100Content addObject:array];
    }
    for (int i=0; i<catalogList.count; i++) {
        NSMutableArray *array = [NSMutableArray  array];
        
        [contentList100Carousel addObject:array];
    }

    
    for (int i=0; i<catalogList.count; i++) {
//        nsmu *array = [NSMutableArray  array];
        
        [contentList100TableView addObject:[NSNull null]];
    }

    [_view0_1_sel_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    [_view0_1_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    _view0_1_scrollView.contentSize = CGSizeMake(kLayoutScreenWidth*catalogList.count, frame.size.height-44-44-53);
    
    
    
//    ////////NSLog(@"0what %ld!!",[_view0_1_sel_scrollView.subviews count]);
//    ////////NSLog(@"1what %ld!!",(long)[(UIButton *)[_view0_1_sel_scrollView.subviews objectAtIndex:1] tag]);

    
//    [self view0_1_catalog_action:[_view0_1_sel_scrollView.subviews objectAtIndex:0]];
    
//    [self updateContentView:0];
    
    
}


 */
-(void)view0_1_catalog_action:(UIButton *)button
{
    if (button) {
        cIndex =  button.tag;
        
    }
    else{
        cIndex = 0;
    }
    
    [self catalogAction];
}


-(void)catalogAction
{
    for (UIButton *button in _view0_1_sel_scrollView.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            
            if (  button.tag ==cIndex) {
                button.selected = YES;
            }
            else{
                button.selected = NO;

            }
        }
    }
   
    
    
    
    
//    ////////NSLog(@"button.tag %d",cIndex);
    
    if (catalogList.count<4&&catalogList.count>0) {
        [UIView animateWithDuration:0.1 animations:^{
            //        imageView.frame =CGRectMake(80*i+i%3+(int)(i/3)*2, 11, 1, 22);
            
            
            _view0_1_CatalogLine.frame =CGRectMake(cIndex*kLayoutScreenWidth/catalogList.count, 42, kLayoutScreenWidth/catalogList.count, 2);
        } completion:nil];
    }
    else if(catalogList.count>=4){
        [UIView animateWithDuration:0.1 animations:^{
            //        imageView.frame =CGRectMake(80*i+i%3+(int)(i/3)*2, 11, 1, 22);
            
            _view0_1_CatalogLine.frame =CGRectMake( cIndex *kLayoutScreenWidth/4, 42, kLayoutScreenWidth/4, 2);
        } completion:nil];
    }
    
    [_view0_1_scrollView setContentOffset:CGPointMake(kLayoutScreenWidth*cIndex, 0) animated:YES];
//    if (<#condition#>) {
//        <#statements#>
//    }

    if (contentList100Content.count>cIndex) {
        if ([[contentList100Content objectAtIndex:cIndex] count]==0) {
            
            [self getListDate:cIndex];
            //        [self updateContentView:cIndex];
        }
    }
//    switch (cIndex) {
//        case 0:
//            
//            break;
//            
//        default:
//            break;
//    }
}

-(void)getListDate:(int)nn
{
    
    
    if([[[catalogList objectAtIndex:cIndex ] objectForKey:@"catalogId"] intValue]==1)
    {
        return;
    }
    
    //http://www.app.com:8005/index.php?cmd=information|getlist&params={%22nid%22:3,%22page%22:1}
    
    
    int numberv = [[contentList100Number objectAtIndex:cIndex] intValue];

    NSDictionary *resDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",numberv  ],@"page",[[catalogList objectAtIndex:cIndex ] objectForKey:@"catalogId"] ,@"nid",nil];
    
    
    NSString *string = [Util postAction:resDic cmd:@"information|getlist"];
    
    
    if ([contentList100TableView objectAtIndex:cIndex] !=[NSNull null]) {
        [ [contentList100TableView objectAtIndex:cIndex]   footerEndRefreshing];

    }
 //    ////////NSLog(@"cover %@",string);
    
    [self performSelectorOnMainThread:@selector(requestFinished1:) withObject:string waitUntilDone:YES];
}


- (void)requestFinished1:(NSString *)string
{
    
    
//    ////////NSLog(@"requestFinished1  %@",string);
    if (string) {
        NSDictionary *resDic = [parser objectWithString:string ];
        if (![resDic objectForKey:@"err_num"] ) {
            
            
            if ([[resDic objectForKey:@"res"] count]>0) {
                
                [[contentList100Content objectAtIndex:cIndex] addObjectsFromArray:[resDic objectForKey:@"res"] ] ;
                
                int numberv = [[contentList100Number objectAtIndex:cIndex] intValue];
                numberv+=1;
                [contentList100Number replaceObjectAtIndex:cIndex withObject:[NSString stringWithFormat:@"%d",numberv  ]];

                
                [[contentList100TableView objectAtIndex:cIndex] reloadData];
            }
        }
    }
    

}
         
-(void)updateContentView:(int)number{
    
    switch (number) {
        case 0:
        {
            NSString *filePath = [[NSBundle mainBundle ] pathForResource:@"data0" ofType:@"json"];
            NSString *file = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            
            NSArray *carouselList  = [[NSArray alloc] initWithArray: [[parser objectWithString:file ] objectForKey:@"carouselList"]];
            

            UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0*kLayoutScreenWidth, 0, kLayoutScreenWidth, _view0_1_scrollView.frame.size.height)];
            
            
            UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, kLayoutScreenWidth/2)];
            
            NSMutableArray *imageArray = [ NSMutableArray array];
            
            
            [[contentList100Carousel objectAtIndex:number] setArray:carouselList];

            if (carouselList.count>0) {
                
                
                //                return;
                for (int i= 0; i<carouselList.count; i++) {
                    [imageArray addObject:[[carouselList objectAtIndex:i] objectForKey:@"coverImgUrl"]];
                }
                SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, kLayoutScreenWidth/2) delegate:self placeholderImage:[UIImage imageNamed:@"cover_holder"]];
                
                
                
                cycleScrollView.delegate = self;
                
                cycleScrollView.imageURLStringsGroup = imageArray;
                
                
                cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
                [topView addSubview:cycleScrollView];
                
                
                
                [cycleScrollView.delegate cycleScrollView:cycleScrollView didScrollToIndex:0];

                
                
//                UIView *view =
                
            }

            
            [contentView addSubview:topView];
            [_view0_1_scrollView addSubview:contentView];
            
            NSArray *resourceList  = [[NSArray alloc] initWithArray: [[parser objectWithString:file ] objectForKey:@"resourceList"]];
            
            
            [[contentList100Content objectAtIndex:number] setArray:resourceList];
            
            
            
            
            UITableView *tableView = [[UITableView alloc] initWithFrame: CGRectMake(0,topView.frame.size.height, kLayoutScreenWidth,_view0_1_scrollView.frame.size.height-topView.frame.size.height)];
            tableView.dataSource = self;
            tableView.delegate = self;
            
            tableView.tag = number;
            [contentView addSubview:tableView];
            
//            NSArray *array =list ;
            
//            ////////NSLog(@"what %@",array);
            
            
            /*
             
             
             MJRefreshFooterView *footer = [MJRefreshFooterView footer];
             footer.scrollView = tableView;
             footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
             //[self startGetList];
             
             type =102;
             
             
             if ([[contentList100Total objectAtIndex:cIndex] intValue]==0   ||[[[catalogList objectAtIndex:cIndex] objectForKey:@"resourceList"] count]  <[[contentList100Total objectAtIndex:cIndex] intValue]) {
             [self startGetList];
             
             }
             
             
             [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
             
             };
             
             */
            [contentList100TableView replaceObjectAtIndex:number withObject :tableView];
            [tableView reloadData];

            
            
        }
            
            break;
            
        default:
            break;
    }
}

/*
- (void)headerRereshing
{
    isHead = YES;
//    [self getResourceList1];
    [self performSelectorInBackground:@selector(getResourceList1) withObject:nil];
//    [self startGetData];
    
    //    // 2.2秒后刷新表格UI
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        // 刷新表格
    //        [self.tableView reloadData];
    //
    //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    //        [_tableView headerEndRefreshing];
    //    });
}
 */


/*
- (void)footerRereshing
{
    isHead = NO;
    
    ////////NSLog(@"footerRereshing");
    
//    [self getListDate:cIndex];
//    [self performSelectorInBackground:@selector(getResourceList1) withObject:nil];
    [self performSelectorInBackground:@selector(getListDate:) withObject:nil];

//    [self startGetData];
//    :
    //    // 1.添加假数据
    //    for (int i = 0; i<5; i++) {
    //        [self.fakeData addObject:MJRandomData];
    //    }
    //
    //    // 2.2秒后刷新表格UI
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        // 刷新表格
    //        [self.tableView reloadData];
    //
    //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    //        [self.tableView footerEndRefreshing];
    //    });
}
 */
-(CGFloat)calculateTextWidth:(NSString *)strContent{
    //    CGSize constraint = CGSizeMake(heightInput, heightInput);
    CGFloat constrainedSize = 26500.0f; //其他大小也行
    CGSize size = [strContent sizeWithFont: [ UIFont fontWithName:FontB size:19] constrainedToSize:CGSizeMake(constrainedSize, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    //    CGFloat height = MAX(size.height, 44.0f);
    return size.width;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    
    
//    ////////NSLog(@"contentList100Carousel %f",[self calculateTextWidth: [[[contentList100Carousel objectAtIndex:cycleScrollView.tag] objectAtIndex:index] objectForKey:@"title"]]);
    
    if ([self calculateTextWidth: [[[contentList100Carousel objectAtIndex:cycleScrollView.tag] objectAtIndex:index] objectForKey:@"title"]]>kLayoutScreenWidth) {
        cycleScrollView.titleLabel.textAlignment =  NSTextAlignmentLeft;
        
    }
    
    else{
        cycleScrollView.titleLabel.textAlignment =  NSTextAlignmentCenter;

    }
    
    cycleScrollView.titleLabel.text = [[[contentList100Carousel objectAtIndex:cycleScrollView.tag] objectAtIndex:index] objectForKey:@"title"];
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    int number = [[[[contentList100Carousel objectAtIndex:cycleScrollView.tag] objectAtIndex:index] objectForKey:@"id"] intValue];
//    ////////NSLog(@"---点击了第%ld张图片", (long)number);
    [nextDic setDictionary:[[contentList100Carousel objectAtIndex:cycleScrollView.tag] objectAtIndex:index] ];

    [self performSegueWithIdentifier:@"HomeDetail" sender:nil];

    /*
    
    [dic setDictionary: [list0 objectAtIndex:index]];
    
    tag =1;
 
    
    [self performSegueWithIdentifier:@"HomeDetail" sender:nil];
     
     
     */
    
//    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender
{
    
    
    if (sender ==_view0_1_scrollView) {
        CGFloat pageWidth = _view0_1_scrollView.frame.size.width;
        int page = floor((_view0_1_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        cIndex =  page;
        
        ////////NSLog(@"cIndex %d",cIndex);
        
        //        ////////NSLog(@"button.tag %d",button.tag);
        
        //        CGRect frame =[[_view0_1_sel_scrollView.subviews objectAtIndex:cIndex+1] frame];
        if (catalogList.count<4&&catalogList.count>0) {
            [UIView animateWithDuration:0.1 animations:^{
                _view0_1_CatalogLine.frame =CGRectMake((kLayoutScreenWidth/catalogList.count)*cIndex, 42, kLayoutScreenWidth/catalogList.count, 2);
            } completion:nil];
            
        }
        else if(catalogList.count>=4)
        {
            [UIView animateWithDuration:0.1 animations:^{
                //        imageView.frame =CGRectMake(106*i+i%3+(int)(i/3)*2, 11, 1, 22);
                
                //            int number =cIndex-3;
                // [_view0_1_sel_scrollView setContentOffset:CGPointMake(106*cIndex+1+cIndex+1%3+(int)(cIndex/3)*2, 0) animated:YES];
                
                //  ////////NSLog(@"dao <3 %d",106*cIndex+1+cIndex+1%3+(int)(cIndex/3)*2);
                
                if (cIndex>=4) {
                    [_view0_1_sel_scrollView setContentOffset:CGPointMake((cIndex-3) *(int)( kLayoutScreenWidth/4), 0) animated:YES];
                    
                    //                ////////NSLog(@"dao >3 %d",106*number+1+number+1%3+(int)(number/3)*2);
                    
                }
                else{
                    [_view0_1_sel_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];

                    //                ////////NSLog(@"dao <3 %d",06*cIndex+1+cIndex+1%3+(int)(cIndex/3)*2);
                    
                    //                [_view0_1_sel_scrollView setContentOffset:CGPointMake(106*cIndex+1+cIndex+1%3+(int)(dacIndex/3)*2, 0) animated:YES];huang
                    //
                }
                
                
                //            _view0_1_CatalogLine.frame =CGRectMake(106*cIndex+cIndex%3+(int)(cIndex/3)*2, 42, kLayoutScreenWidth/4, 2);
                
                //            ////////NSLog(@"hhww%d",number*kLayoutScreenWidth/4);
                
                //            
                _view0_1_CatalogLine.frame =CGRectMake( (int)( kLayoutScreenWidth/4) *cIndex, 42, (int)( kLayoutScreenWidth/4), 2);
                
                
            } completion:nil];
            
            
        }
        
        
        [self catalogAction];

    }
    
  
}
-(void)startGetData
{
    
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    //    HUD.frame =CGRectMake(0, 0, 240, 240);
    HUD.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"加载中...";
    [self.view addSubview:HUD];
    [HUD showWhileExecuting:@selector(getResourceList) onTarget:self withObject:nil animated:YES];
    
}

-(void)getResourceList{
    
    NSURL *url = [ NSURL URLWithString :@"http://www.8lingling.com/ms/service/getOrgList"];
    
    ASIFormDataRequest *request= [ ASIFormDataRequest requestWithURL :url];
    page = 1;
    [request addPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNum"];
    
//    if ([DataManager getNSStringForKey:KUserKey].length > 0) {
//        [request addPostValue:[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"userId"] forKey:@"userId"];
//        [request addPostValue:[[DataManager mutableDictionaryFromFile:@"user"] objectForKey:@"key"] forKey:@"key"];
//    }
    [request startSynchronous];
    if (request.responseString.length>0) {
        
        NSString *string = [[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding];
        
        //        [reString  setString:[[NSString alloc] initWithBytes:[request.responseData bytes]length:[request.responseData length] encoding:NSUTF8StringEncoding]];
        [self performSelectorOnMainThread:@selector(requestFinished:) withObject:string waitUntilDone:YES];
        
    }
    else{
        [Util showMesssage:@"出现未知错误，请重试！"];
    }
}


- (void)requestFinished:(NSString *)aString
{
    
    NSLog(@"login%@",aString);
    if ([[parser objectWithString:aString ]  isKindOfClass: [NSDictionary class]])
        
    {
        NSDictionary *dict = [parser objectWithString:aString ];
        
        if ([[dict objectForKey:@"status"] intValue]==0) {
            
//            [list addObjectsFromArray:[dict objectForKey:@"data"]];
            
            [_tableView reloadData];
            page++;
            
        }
        
        else{
            [Util showMesssage:[dict objectForKey:@"msg"]];
        }
    }
    else{
        [Util showMesssage:@"请求失败，请稍后再试"];
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake((kLayoutScreenWidth-20)/3, 140);
    
    if (kLayoutScreenHeight-568>=0) {
        return CGSizeMake((kLayoutScreenWidth-20)/3,130+(kLayoutScreenHeight-568 )*0.20);

    }
    else{
        return CGSizeMake((kLayoutScreenWidth-20)/3,130);

    }

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  3;

    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    
    return collect1.count%3?(collect1.count/3+1): collect1.count/3;
    
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentify forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor lightGrayColor];
//    cell.textLabel.text = [NSString stringWithFormat:@"(%zd,%zd)", indexPath.section, indexPath.row];
    
    
    if (indexPath.section*3+indexPath.row<collect1.count) {
        [cell.coverView sd_setImageWithURL:[NSURL URLWithString:[[collect1 objectAtIndex:indexPath.section*3+indexPath.row] objectForKey:@"pic"]] placeholderImage:[UIImage imageNamed:@"Common_noheadimage"]];
        cell.textLabel.text =[[collect1 objectAtIndex:indexPath.section*3+indexPath.row]objectForKey:@"name"];
    }
    
   
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
 
   
    [self performSegueWithIdentifier:@"HomeCategory" sender:nil];
}


/*
-(void)getResourceList0
{
    NSDictionary *resDic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"activityid", nil];
    NSString *string = [Util postAction:resDic cmd:@"carousel|pic"];
    
  
    
    ////////NSLog(@"cover %@",string);
    
    [self performSelectorOnMainThread:@selector(requestFinished0:) withObject:string waitUntilDone:YES];
  }
- (void)requestFinished0:(NSString *)string
{
    if (string) {
        NSDictionary *resDic = [parser objectWithString:string ];
        if (![resDic objectForKey:@"err_num"] ) {
            
            
            NSArray *array = [NSArray arrayWithArray:[resDic objectForKey:@"res"]];
            
            [list0 setArray:array];
            NSMutableArray *imageArray = [ NSMutableArray array];
            
            
            if (array.count>0) {
                
                
//                return;
                for (int i= 0; i<array.count; i++) {
                    [imageArray addObject:[[array objectAtIndex:i] objectForKey:@"cover"]];
                }
                SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kLayoutScreenWidth, kLayoutScreenWidth/2) delegate:self placeholderImage:[UIImage imageNamed:@"cover_holder"]];
                
                
                
                cycleScrollView.delegate = self;
                
                cycleScrollView.imageURLStringsGroup = imageArray;
                
                
                cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;

            }
            
        }
        else{
            [Util showMesssage:[resDic objectForKey:@"err"] ];
        }
    }
    else{
        [Util showMesssage:@"请求失败，请稍后再试"];
    }

}
 
 */


/*

-(void)getResourceList1
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"activityid",[NSString stringWithFormat: @"%d",page],@"page", nil];
    NSString *string = [Util postAction:params cmd:@"information|getlist"];
    
    
    [_tableView headerEndRefreshing];
    [_tableView footerEndRefreshing];
    
//    ////////NSLog(@"getlist %@",string);
    
    [self performSelectorOnMainThread:@selector(requestFinished1:) withObject:string waitUntilDone:YES];

   }
- (void)requestFinished1:(NSString *)string
{
    
    ////////NSLog(@"stringhello");
    
    if (string) {
        NSDictionary *resDic = [parser objectWithString:string ];
        if (![resDic objectForKey:@"err_num"] ) {
            page++;
            
            [list addObjectsFromArray:[resDic objectForKey:@"res"]];
            [_tableView reloadData];
        }
        else{
            [Util showMesssage:[resDic objectForKey:@"err"] ];
        }
    }
    else{
        [Util showMesssage:@"请求失败，请稍后再试"];
    }

}
 
 */
-(IBAction)shareActon:(id)sender
{
    
    
    ////////NSLog(@"dic %@",dic);
    [Util showShareActionSheet:@"听听我的心里话，说说你的心里话" title:@"书歌官方App" shareUrl:@"http://www.shugechina.com/shugeshow/app/download.html" coverUrl:@"http://www.shugechina.com/shugeshow/image/logo.png" controller:self type:3 ];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    NSDictionary *dictionary =[list objectAtIndex:indexPath.row];
//    return 170;
//
//    
//    if ([[[dictionary objectForKey:@"author" ] objectForKey:@"name"] length]>0) {
//        
//        
//        //        (kLayoutScreenWidth/320)
//        return 170;
//        
//    }
//    else{
//        return 80;
//        
//    }
//
//    
//    
//    /*
//    if ([[[dictionary objectForKey:@"author" ] objectForKey:@"name"] length]>0) {
//        
//        
////        (kLayoutScreenWidth/320)
//        return 120+ (kLayoutScreenWidth/320-1)*100;
//        
//    }
//    else{
//        return 80+ (kLayoutScreenWidth/320-1)*70;
//        
//    }
//     
//     */
//}

-(void)inAction:(UIButton *)button
{
    NSLog(@"机构选择==%@",[DataManager  mutableDictionaryFromFile:@"org"]);
    NSLog(@"机构tag==%li,,,%@",button.tag,[list objectAtIndex:button.tag]);
    if (![[DataManager mutableDictionaryFromFile:@"org"] objectForKey:@"id"]) {
        [DataManager writeDictionary:[list objectAtIndex:button.tag] ToFile:@"org"];
        for (UIViewController *tempVC in self.navigationController.viewControllers) {
            if ([tempVC isKindOfClass:[Login class]]) {
                [tempVC dismissViewControllerAnimated:YES completion:nil];
            } else {
//                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        [DataManager writeDictionary:[list objectAtIndex:button.tag] ToFile:@"org"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [[UIApplication sharedApplication].keyWindow setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"NavVC"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotication" object:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dictionary =[list objectAtIndex:indexPath.row];
    
    HomeTableViewCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell0"];
    //    cell.headView.layer.masksToBounds=YES;
    //    cell.headView.layer.borderColor = [[UIColor clearColor] CGColor];
    cell.hintView.layer.masksToBounds=YES;
    cell.hintView.contentMode  =UIViewContentModeScaleAspectFill;
    cell.hintView.layer.cornerRadius= cell.hintView.frame.size.height/2;
    cell.hintView.backgroundColor = [UIColor grayColor];
    
    [cell.hintView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [dictionary objectForKey:@"logo"]]] placeholderImage:[CommonTool imageWithColor:KImageViewBackGroundColor]];
    
    
    cell.button0.tag = indexPath.row;
    
    [cell.button0 addTarget:self action:@selector(inAction:) forControlEvents:UIControlEventTouchUpInside];
    //    cell.hintView.layer.masksToBounds=YES;
    cell.showView.frame = CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width,([UIScreen mainScreen].bounds.size.width-40)*0.50);
    
    [cell.showView sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@", [dictionary objectForKey:@"pic"]]] placeholderImage:[CommonTool imageWithColor:KImageViewBackGroundColor]];
    // cell.imageView0.layer.cornerRadius=cell.imageView0.frame.size.height/2;
    //    cell.headView.layer.borderWidth =1;
    cell.compLabel.text =[dictionary  objectForKey:@"name"];
    cell.shareLabel.text =  [dictionary objectForKey:@"disc"];
    cell.shareLabel.numberOfLines = 0;
    
    CGSize shareLabelSize = [self sizeWithString:cell.shareLabel.text font:cell.shareLabel.font reducedWidth:60];
    cell.shareLabel.frame = CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width-60,shareLabelSize.height);
    cell.shareView.frame = CGRectMake(0, cell.showView.frame.size.height+cell.showView.frame.origin.y, [UIScreen mainScreen].bounds.size.width-20, shareLabelSize.height+40);
    cell.button0.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-75, cell.shareView.frame.size.height+cell.shareView.frame.origin.y+20, 150, 40);
    cell.backView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, cell.button0.frame.size.height+cell.button0.frame.origin.y+20);
    cellHeight = cell.backView.frame.size.height;
    
    if([UIScreen mainScreen].bounds.size.width==320)
    {
        cell.showView.frame = CGRectMake(10, 60, [UIScreen mainScreen].bounds.size.width-20,([UIScreen mainScreen].bounds.size.width-20)*0.50);
        cell.shareView.frame = CGRectMake(10, cell.showView.frame.size.height+cell.showView.frame.origin.y, [UIScreen mainScreen].bounds.size.width-20, shareLabelSize.height+40);
        cell.button0.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-75, cell.shareView.frame.size.height+cell.shareView.frame.origin.y+20, 150, 40);
    }
    return cell;
}

// 定义成方法方便多个label调用 增加代码的复用性
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font reducedWidth:(CGFloat)floatWidth
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-floatWidth, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
//    ////////NSLog(@"%d!!!",[list  count]);
    
    return [list  count];

    
  //  ////////NSLog(@"list.count %d",list.count);
//    return [[contentList100Content objectAtIndex: cIndex] count];
}


//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    //    NSMutableDictionary *dic = [typeArray objectAtIndex:indexPath.section];
//    //    NSMutableDictionary *infoDic = [dic objectForKey:@"dic"];
////    if (indexPath.row==[list count]-1)
//    {
//        cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
//        
////        cell.separatorInset = UIEdgeInsetsZero;
//    }
//}
// 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight+10;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"HomeCategory"]) {
        HomeCategory *vc =    segue.destinationViewController ;
        vc.dic = cDic;
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
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
