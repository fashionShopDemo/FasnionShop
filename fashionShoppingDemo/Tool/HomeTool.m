//
//  HomeTool.m
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import "HomeTool.h"
@interface HomeTool () {
    
   

}

@end

@implementation HomeTool
#pragma mark 头scrollView的数据
+ (void)getHomeHeaderDatawithBlock:(void(^)(NSMutableArray *dataArr))block {
    
[NetRequestClass netRequestGETWithRequestURL:@"http://api-v2.mall.hichao.com/mall/banner?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=AD889938-F007-43F8-BC74-482F96CBADA0&gs=640x1136&gos=8.4" WithParameter:nil WithReturnValeuBlock:^(id responseObject, NSError *error) {
    
    NSArray *arr = responseObject[@"data"][@"items"];
    NSMutableArray *dataArr = @[].mutableCopy;
    for (NSDictionary *dic in arr) {
        HomeHeaderModel *model = [HomeHeaderModel createWithDic:dic];
        [dataArr addObject:model];
//        NSLog(@"%@",model.picUrl);
    }
    if (block) {
        block(dataArr);
    }
    
}];
}
#pragma make -两个模块的数据
+ (void)getHomeTwoModuleDatawithBlock:(void(^)(NSMutableArray *dataArr))block {
    NSString *str = @"http://api-v2.mall.hichao.com/active/flash/list?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=AD889938-F007-43F8-BC74-482F96CBADA0&gs=640x1136&gos=8.4&access_token=";
    NSString *url = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
[NetRequestClass requestWithASIURL:url parmas:nil httpMethod:@"POST" completeBlock:^(id responseObject, NSError *error) {

    NSMutableArray *arr = responseObject[@"response"][@"data"][@"items"];
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        HomeHeaderModel *model = [HomeHeaderModel createWithDic:dic];
        [dataArr addObject:model];
     }
    if (block) {
        block(dataArr);
    }
}];
 
}

+ (void)getHomeSixModuleDatawithBlock:(void(^)(NSMutableArray *dataArr))block withUrl:(NSString *)urlStr {
    
    
[NetRequestClass netRequestGETWithRequestURL:urlStr WithParameter:nil WithReturnValeuBlock:^(id responseObject, NSError *error) {
//    NSLog(@"%@",responseObject);
    NSMutableArray *arr = @[@[].mutableCopy].mutableCopy;
   
    NSMutableArray *headerArr = responseObject[@"data"][@"region_name"];
    
    NSMutableArray *bottomArr = responseObject[@"data"][@"region_skus"];
    NSMutableArray *titleArr = responseObject[@"data"][@"region_brands"];
    NSMutableArray *imageArr = responseObject[@"data"][@"region_pictures"];
    
    [arr addObject:[self getSixModelWith:headerArr]];
    [arr addObject:[self getSixModelWith:titleArr]];
    [arr addObject:[self getSixModelWith:imageArr]];
    [arr addObject:[self getSixModelWith:bottomArr]];
       
    if (block) {
        block(arr);
    }
    
 }];
}
+ (NSMutableArray *)getSixModelWith:(NSMutableArray *)Arr {
    NSMutableArray *arr = @[].mutableCopy;
    for (NSDictionary *dic in Arr) {
        HomeSixModel *model = [HomeSixModel createWithDic:dic];
        [arr addObject:model];
    }
    return arr;
}














@end
