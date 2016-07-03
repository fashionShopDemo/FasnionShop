//
//  HomeSixModel.m
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import "HomeSixModel.h"

@implementation HomeSixModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.picUrl = dic[@"component"][@"picUrl"];
        self.title = dic[@"component"][@"title"];
        self.price =dic[@"price"];
        self.origin_price =dic[@"origin_price"];
    }
    return self;
    
}
+ (instancetype)createWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
    
}

@end
