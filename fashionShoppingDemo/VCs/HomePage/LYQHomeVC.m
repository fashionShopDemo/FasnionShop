//
//  LYQHomeVC.m
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//
#import "LYQHomeVC.h"
#import "UICollectionViewFlowWaterLayout.h"
@interface LYQHomeVC ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{

    UIScrollView *_bgScroll;
    UIScrollView *_headerScroll;
    UIPageControl *_page;
    UITableView *_tableView;
    CGFloat endHeight;
    NSInteger buttonTag;
    NSArray *dataSourceArr;

}
@property (retain,nonatomic)NSMutableArray *dataArr;
@property (retain,nonatomic)NSMutableArray *twoDataArr;
@property (retain,nonatomic)NSMutableArray *bottomDataArr;
@end

@implementation LYQHomeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataArr = [NSMutableArray array];
    self.twoDataArr = [NSMutableArray array];
    self.bottomDataArr = [NSMutableArray array];
    [self getDataSourceArr];
    [self createBgScrollView];
    
    
    }
#pragma mark -背景scrollView
- (void)createBgScrollView {
    UIScrollView *bgScroll = [[UIScrollView alloc]initWithFrame:kMainBounds];
    
//    bgScroll.pagingEnabled = YES;
    bgScroll.delegate = self;
     _bgScroll = bgScroll;
    [_tableView reloadData];
    bgScroll.contentSize = CGSizeMake(0, 4000);
    
    
    [self.view addSubview:bgScroll];
    [self createHeader];
    [self createTwoModule];
    [self createSixModuleView];
    
     [self createBottomView];
     }

#pragma mark - 创建头scrollView
- (void)createHeader {
    endHeight = 200;
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
                if (i==_dataArr.count-1) {
                    HomeHeaderModel *model = self.dataArr[0];
                   
                    [headerImage sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
                }
                [headerScroll addSubview:headerImage];
            }
        }
        headerScroll.contentSize = CGSizeMake(kMainBoundsW*self.dataArr.count, 0);
        
        UIPageControl *page =[[UIPageControl alloc]initWithFrame:CGRectMake(0, 160, kMainBoundsW, 40)];
        page.numberOfPages = self.dataArr.count-1;
        page.currentPageIndicatorTintColor = [UIColor redColor];
        page.pageIndicatorTintColor = [UIColor whiteColor];
        [page addTarget:self action:@selector(change) forControlEvents:UIControlEventEditingChanged];
        _page = page;
        [_bgScroll bringSubviewToFront:view];
        [view addSubview:page];
    }];
    
//[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(run) userInfo:nil repeats:YES];
}
#pragma mark - 创建两模块
- (void)createTwoModule {
    endHeight +=200;
    
    [HomeTool getHomeTwoModuleDatawithBlock:^(NSMutableArray *dataArr) {
        [self.twoDataArr addObjectsFromArray:dataArr];
        for (int i=0; i<2; i++) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(i*kMainBoundsW/2+10, 220, kMainBoundsW/2-30, 180)];
            
            HomeHeaderModel *model = self.twoDataArr[i];
            [image sd_setImageWithURL:[NSURL URLWithString:model.twoPicUrl]];
            [_bgScroll addSubview:image];
        }

        
    }];
}
#pragma mark - 创建六个模块
- (void)createSixModuleView {

    for (int i=0; i<6; i++) {
        endHeight+=500;
        NSString *url = [NSString stringWithFormat:@"http://api-v2.mall.hichao.com/mall/region/new?region_id=%d&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=5243F177-D4FD-4E4C-9B60-6E1E954CB1E2&gs=640x1136&gos=8.4&access_token=",i+1];
        
        
        [HomeTool getHomeSixModuleDatawithBlock:^(NSMutableArray *dataArr) {
#pragma mark  -- 六个image
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 410+500*i, kMainBoundsW, 50)];
            [_bgScroll addSubview:image];
            
            UIScrollView *titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 450+500*i, kMainBoundsW, 50)];
            titleScroll.pagingEnabled = YES;
            [_bgScroll addSubview:titleScroll];
            
            UIScrollView *imageScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 500+500*i, kMainBoundsW, 200)];
            imageScroll.pagingEnabled = YES;
            [_bgScroll addSubview:imageScroll];
            
            UIScrollView *bottomScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 700+500*i, kMainBoundsW, 200)];
            bottomScroll.pagingEnabled = YES;
            [_bgScroll addSubview:bottomScroll];
            
            for (HomeSixModel *model in dataArr[1]) {
                [image sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
                
            }
            
            for (int j=0; j<[dataArr[2]count]; j++) {
                HomeSixModel *model = dataArr[2][j];
                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10+100*j, 0, 90, 50)];
                [image sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
                 titleScroll.contentSize = CGSizeMake(100*j+100, 0);
                [titleScroll addSubview:image];
                }
            for (int k=0; k<[dataArr[3]count]; k++) {
                HomeSixModel *model = dataArr[3][k];
                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(kMainBoundsW*k, 0, kMainBoundsW, 200)];
                [image sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
               imageScroll.contentSize = CGSizeMake(kMainBoundsW*(k+1), 0);
                [imageScroll addSubview:image];
                
            }
            
            for (int l=0; l<[dataArr[4]count]; l++) {
                HomeSixModel *model = dataArr[4][l];
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10+110*l, 0, 100, 200)];
                [bottomScroll addSubview:view];
                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
                [image sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
                [view addSubview:image];
                UILabel *titltLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 100, 100, 40)];
                titltLabel.font = [UIFont systemFontOfSize:12];
                titltLabel.text = model.title;
                titltLabel.textAlignment = NSTextAlignmentCenter;
                [view addSubview:titltLabel];
                
                UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, 100, 30)];
                
                priceLabel.font = [UIFont systemFontOfSize:20];
                priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
                
                priceLabel.textColor = [UIColor redColor];
                priceLabel.textAlignment = NSTextAlignmentCenter;
               [view addSubview:priceLabel];
                
                UILabel *origin_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 170, 100, 30)];
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30, 15, 30, 1)];
                lineView.backgroundColor = [UIColor blackColor];
                [origin_priceLabel addSubview:lineView];
                origin_priceLabel.textColor = [UIColor grayColor];
                origin_priceLabel.text = model.origin_price;
                origin_priceLabel.font = [UIFont systemFontOfSize:12];
                origin_priceLabel.textAlignment = NSTextAlignmentCenter;
                [view addSubview:origin_priceLabel];
                bottomScroll.contentSize = CGSizeMake(100*(l+2), 0);
            }
            
        } withUrl:url];
    }
    endHeight +=200;
}
#pragma mark - 创建底部视图
- (void)createBottomView {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, endHeight+20, kMainBoundsW, kMainBoundsH) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    
    _tableView =tableView;
    [_bgScroll addSubview:tableView];
    tableView.tableFooterView = [UIView new];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
   }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   [HomeTool getHomeBottomModuleDatawithBlock:^(NSMutableArray *dataArr) {
       [self.bottomDataArr addObjectsFromArray:dataArr];
       _bgScroll.contentSize = CGSizeMake(0, 3400+kMainBoundsH);
       endHeight += _tableView.contentSize.height+kMainBoundsH;
       _bgScroll.contentSize = CGSizeMake(0, endHeight);

   } withUrl:dataSourceArr[0]];
    
    return self.bottomDataArr.count;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 70;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSArray *buttonArr = @[@"今日新上",@"上装",@"裙装",@"裤装"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 60)];
    
    view.backgroundColor = [UIColor whiteColor];
    for (int i=0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        button.frame = CGRectMake(10+kMainBoundsW/4*i , 0, (kMainBoundsW-50)/4, 44);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:buttonArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeDataSource:) forControlEvents:UIControlEventTouchUpInside];
       
         [view addSubview:button];
        
    }
    UIView *imageView = [[UIView alloc]init];
    imageView.tag = 1000;
    imageView.backgroundColor = [UIColor magentaColor];
    if (buttonTag) {
        imageView.frame =CGRectMake(10+kMainBoundsW/4*buttonTag , 40, (kMainBoundsW-50)/4, 5);
    }
    else {
    imageView.frame =CGRectMake(10 , 40, (kMainBoundsW-50)/4, 5);
    }
    
     [view addSubview:imageView];

    return view;
   }
- (void)changeDataSource:(UIButton *)sender {
    buttonTag = sender.tag-100;
    
 [HomeTool getHomeBottomModuleDatawithBlock:^(NSMutableArray *dataArr) {
     NSLog(@"%ld",dataArr.count);
     [self.bottomDataArr removeAllObjects];
    [self.bottomDataArr addObjectsFromArray:dataArr];
    
       [_tableView reloadData];
     _bgScroll.contentOffset = CGPointMake(0, 3200+kMainBoundsH);
     _bgScroll.contentSize = CGSizeMake(0, 3400+kMainBoundsH);
      endHeight += _tableView.contentSize.height+kMainBoundsH;
     _bgScroll.contentSize = CGSizeMake(0, endHeight);

    
} withUrl:dataSourceArr[sender.tag-100]];
   }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.bottomDataArr.count>0) {

        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        for (int i=0; i<2; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((kMainBoundsW/2+5)*i, 0, kMainBoundsW/2-5, cell.height-80)];
            UIImageView *countryImage = [[UIImageView alloc]initWithFrame:CGRectMake(20+kMainBoundsW/2*i, image.frame.size.height+5, 15, 15)];
            UILabel *countryLabel = [[UILabel alloc]initWithFrame:CGRectMake(45+kMainBoundsW/2*i, countryImage.frame.origin.y+2, 50, 10)];
            countryLabel.font = [UIFont systemFontOfSize:12];
            UILabel *describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+kMainBoundsW/2*i, countryImage.frame.origin.y+25, kMainBoundsW/2-10, 5)];
            describeLabel.font = [UIFont systemFontOfSize:13];
            UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+kMainBoundsW/2*i, describeLabel.frame.origin.y+20, 100, 15)];
            priceLabel.textColor = [UIColor redColor];
            UILabel *origin_priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(priceLabel.frame.size.width+kMainBoundsW/2*i, describeLabel.frame.origin.y+25, 100, 10)];
            origin_priceLabel.font = [UIFont systemFontOfSize:12];
            UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(priceLabel.frame.size.width+kMainBoundsW/2*i, describeLabel.frame.origin.y+30, 30, 2)];
            blackView.backgroundColor = [UIColor blackColor];
            HomeBottomModel *model = self.bottomDataArr[indexPath.row*2+i];
            if (model.picUrl) {
                
           
           NSString *urlStr = [[model.picUrl componentsSeparatedByString:@"?"]firstObject];
            if (!urlStr) {
                continue;
                 }
            else {
                [image sd_setImageWithURL:[NSURL URLWithString:urlStr]];
                [countryImage sd_setImageWithURL:[NSURL URLWithString:model.nationalFlag]];
                countryLabel.text = model.country;
                describeLabel.text = model.describe;
                priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
                origin_priceLabel.text = model.origin_price;
               }
                

            }
            else {
            image.image = [UIImage imageNamed:@"1024-768-1"];
            }
           [cell.contentView addSubview:image];
            [cell.contentView addSubview:countryImage];
            [cell.contentView addSubview:countryLabel];
            [cell.contentView addSubview:describeLabel];
            [cell.contentView addSubview:priceLabel];
            [cell.contentView addSubview:origin_priceLabel];
            [cell.contentView addSubview:blackView];
        }
            }
        return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _bgScroll) {
        if (scrollView.contentOffset.y<=3400) {
            _tableView.frame = CGRectMake(0, 3400, kMainBoundsW, kMainBoundsH);
            _tableView.contentOffset = CGPointMake(0, 0);
          }
        _tableView.center = CGPointMake(_tableView.center.x, scrollView.contentOffset.y+self.view.center.y);
        CGPoint contentOffSet = scrollView.contentOffset;
        contentOffSet.y -=3400;
        _tableView.contentOffset = contentOffSet;
    }

}
#pragma mark - UIPageControl的实现方法
- (void)change{
    
    [_headerScroll setContentOffset:CGPointMake(_page.currentPage, 0) animated:YES];
    
}
#pragma mark - 定时器的实现
- (void)run {
    
    static float a = 0;
    a++;
    if (_headerScroll.contentOffset.x/kMainBoundsW == self.dataArr.count-1)
    {
        _headerScroll.contentOffset = CGPointMake(0, 0);
        a=1;
    }
        [_headerScroll setContentOffset:CGPointMake(a*kMainBoundsW, 0) animated:YES];
_page.currentPage =  _headerScroll.contentOffset.x/kMainBoundsW;
  }
- (void)getDataSourceArr {


dataSourceArr = @[@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=5243F177-D4FD-4E4C-9B60-6E1E954CB1E2&gs=640x1136&gos=8.4&access_token=",@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=&category_ids=38,33,34&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=AD889938-F007-43F8-BC74-482F96CBADA0&gs=640x1136&gos=8.4&access_token=",@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=&category_ids=39,40&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=5243F177-D4FD-4E4C-9B60-6E1E954CB1E2&gs=640x1136&gos=8.4&access_token=",@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=&category_ids=49,45,48,46,44&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=5243F177-D4FD-4E4C-9B60-6E1E954CB1E2&gs=640x1136&gos=8.4&access_token="];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
