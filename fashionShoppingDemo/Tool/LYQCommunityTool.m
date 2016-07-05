//
//  LYQCommunityTool.m
//  fashionShoppingDemo
//
//  Created by mac on 16/7/5.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import "LYQCommunityTool.h"

@implementation LYQCommunityTool
+ (void)getHeaderScrollViewDataWithBlock:(void(^)(NSMutableArray *dataArr))block {
[NetRequestClass netRequestGETWithRequestURL:@"http://api-v2.mall.hichao.com/forum/banner?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=AD889938-F007-43F8-BC74-482F96CBADA0&gs=640x1136&gos=8.4&access_token=" WithParameter:nil WithReturnValeuBlock:^(id responseObject, NSError *error) {
    NSArray *arr = responseObject[@"data"][@"items"];
    if (block) {
        block(arr);
    }
}];





}
@end
