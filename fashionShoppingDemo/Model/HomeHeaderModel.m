//
//  HomeHeaderModel.m
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import "HomeHeaderModel.h"

@implementation HomeHeaderModel
- (instancetype)initHeaderWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.picUrl = dic[@"component"][@"picUrl"];
        self.twoPicUrl = dic[@"component"][@"img_index"];
    }
    return self;

}
+ (instancetype)createHeaderWithDic:(NSDictionary *)dic {
    return [[self alloc]initHeaderWithDic:dic];

}
@end
