//
//  HomeSixModel.m
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import "HomeSixModel.h"

@implementation HomeSixModel
- (instancetype)initSixModuleWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.picUrl = dic[@"component"][@"picUrl"];
        self.title = dic[@"component"][@"title"];
        self.price =dic[@"component"][@"price"];
//        NSLog(@"%@",self.price);
        self.origin_price =dic[@"component"][@"origin_price"];
    }
    return self;
    
}
+ (instancetype)createSixModuleWithDic:(NSDictionary *)dic {
    return [[self alloc]initSixModuleWithDic:dic];
    
}

@end
