//
//  LYQCommunityVC.m
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import "LYQCommunityVC.h"

@interface LYQCommunityVC ()<UIScrollViewDelegate>
{
    UIScrollView *_bgScroll;
    UIScrollView *_headerScroll;
    UIPageControl *_page;
    
    
}
@end

@implementation LYQCommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社区";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createBgScrollView];
    [LYQCommunityTool getHeaderScrollViewDataWithBlock:^(NSMutableArray *dataArr) {
        
    }];
    
    
}
- (void)createBgScrollView {
    UIScrollView *bgScroll = [[UIScrollView alloc]initWithFrame:kMainBounds];
    _bgScroll = bgScroll;
    [self.view addSubview:bgScroll];
    
    [self createHeaderScrollView];
    
    
    
    
}
- (void)createHeaderScrollView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 200)];
    [_bgScroll addSubview:view];
    UIScrollView *headerScroll = [[UIScrollView alloc]initWithFrame:view.frame];
    _headerScroll = headerScroll;
    headerScroll.pagingEnabled = YES;
    headerScroll.delegate = self;
    [view addSubview:headerScroll];
    
    UIPageControl *page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 160, kMainBoundsW, 40)];
    _page = page;
    page.currentPageIndicatorTintColor = [UIColor redColor];
    page.pageIndicatorTintColor = [UIColor whiteColor];
    [page addTarget:self action:@selector(linkage) forControlEvents:UIControlEventEditingChanged];
    [self.view bringSubviewToFront:page];
    [view addSubview:page];
    
    
    
    [LYQCommunityTool getHeaderScrollViewDataWithBlock:^(NSMutableArray *dataArr) {
        
        for (int i=0; i<dataArr.count; i++) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(kMainBoundsW*i, 0, kMainBoundsW, 200)];
            NSDictionary *dic = dataArr[i];
            NSString *string = dic[@"component"][@"picUrl"];
            NSString *urlStr = [[string componentsSeparatedByString:@"?"]firstObject];
            [image sd_setImageWithURL:[NSURL URLWithString:urlStr]];
            [headerScroll addSubview:image];
        }
        page.numberOfPages = dataArr.count;
        headerScroll.contentSize = CGSizeMake(kMainBoundsW*dataArr.count, 0);
    }];
    
    
    
    
    
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _page.currentPage = scrollView.contentOffset.x/kMainBoundsW;
}
- (void)linkage {
    [_headerScroll setContentOffset:CGPointMake(kMainBoundsW*_page.currentPage, 0) animated:YES];

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
