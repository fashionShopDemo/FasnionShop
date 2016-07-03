//
//  LYQHomeVC.m
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import "LYQHomeVC.h"

@interface LYQHomeVC ()<UIScrollViewDelegate>
{

    UIScrollView *_bgScroll;

    UIScrollView *_headerScroll;
    UIPageControl *_page;

}
@property (retain,nonatomic)NSMutableArray *dataArr;
@property (retain,nonatomic)NSMutableArray *twoDataArr;
@end

@implementation LYQHomeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataArr = [NSMutableArray array];
    self.twoDataArr = [NSMutableArray array];
    [self createBgScrollView];
    
    }
#pragma mark -背景scrollView
- (void)createBgScrollView {
    UIScrollView *bgScroll = [[UIScrollView alloc]initWithFrame:kMainBounds];
    
    bgScroll.pagingEnabled = YES;
    bgScroll.delegate = self;
    _bgScroll = bgScroll;
    [self.view addSubview:bgScroll];
    [self createHeader];
    [self createTwoModule];
    [self createSixModule];

}
#pragma mark - 创建头scrollView
- (void)createHeader {
        [HomeTool getHomeHeaderDatawithBlock:^(NSMutableArray *dataArr) {
        [self.dataArr addObjectsFromArray:dataArr];
         NSLog(@"lyq%lu",(unsigned long)self.dataArr.count);
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 200)];
        [_bgScroll addSubview:view];
        UIScrollView *headerScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 200)];
        headerScroll.scrollEnabled = YES;
        headerScroll.delegate = self;
        headerScroll.backgroundColor = [UIColor grayColor];
        _headerScroll = headerScroll;
       [_bgScroll addSubview:headerScroll];
        if (self.dataArr.count>0) {
            
            for (int i=0; i<_dataArr.count; i++) {
                UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(kMainBoundsW*i, 0, kMainBoundsW, 200)];
                HomeHeaderModel *model = self.dataArr[i];
                [headerImage sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
//                if (i==_dataArr.count-1) {
//                    HomeHeaderModel *model = self.dataArr[0];
//                    [headerImage sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
//                }
                [headerScroll addSubview:headerImage];
            }
        }
        headerScroll.contentSize = CGSizeMake(kMainBoundsW*self.dataArr.count, 0);
        
        UIPageControl *page =[[UIPageControl alloc]initWithFrame:CGRectMake(0, 160, kMainBoundsW, 40)];
        page.numberOfPages = self.dataArr.count;
        page.currentPageIndicatorTintColor = [UIColor redColor];
        page.pageIndicatorTintColor = [UIColor whiteColor];
        [page addTarget:self action:@selector(change) forControlEvents:UIControlEventEditingChanged];
        _page = page;
        [_bgScroll bringSubviewToFront:view];
        [view addSubview:page];

        
    }];
    
[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
  
}
#pragma mark - 创建两模块
- (void)createTwoModule {
    
    [HomeTool getHomeTwoModuleDatawithBlock:^(NSMutableArray *dataArr) {
        [self.twoDataArr addObjectsFromArray:dataArr];
        for (int i=0; i<2; i++) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(i*kMainBoundsW/2+10, 220, kMainBoundsW/2-30, 200)];
            
            HomeHeaderModel *model = self.twoDataArr[i];
            [image sd_setImageWithURL:[NSURL URLWithString:model.twoPicUrl]];
            [_bgScroll addSubview:image];
        }

        
    }];


}
#pragma mark - 创建六模块
- (void)createSixModule {
    
    
[HomeTool getHomeSixModuleDatawithBlock:^(NSMutableArray *dataArr) {
    HomeSixModel *model = [dataArr[1]firstObject];
    NSLog(@"%@",model.picUrl);
    
} withUrl:@"http://api-v2.mall.hichao.com/mall/region/new?region_id=1&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=5243F177-D4FD-4E4C-9B60-6E1E954CB1E2&gs=640x1136&gos=8.4&access_token="];



}
#pragma mark - UIPageControl的实现方法
- (void)change{
    
    [_headerScroll setContentOffset:CGPointMake(_page.currentPage, 0) animated:YES];
    
}
#pragma mark - 定时器的实现
- (void)run {
    static int speed = 1;
    if (_page.currentPage==_dataArr.count-1||_page.currentPage==0) {
        speed = -speed;
        
      }
    _page.currentPage += speed;
    
    
    [_headerScroll setContentOffset:CGPointMake(kMainBoundsW*_page.currentPage, 0) animated:YES];

 }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
