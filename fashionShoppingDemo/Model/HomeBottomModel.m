//
//  HomeBottomModel.m
//  fashionShoppingDemo
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import "HomeBottomModel.h"

@implementation HomeBottomModel
- (instancetype)initBottomModuleWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.nationalFlag = dic[@"component"][@"nationalFlag"];
        self.picUrl = dic[@"component"][@"picUrl"];
        self.price =dic[@"component"][@"price"];
        self.origin_price = dic[@"component"][@"origin_price"];
       self.describe = dic[@"component"][@"description"];
        self.country = dic[@"component"][@"country"];
    }
    return self;
    
}
+ (instancetype)createBottomModuleWithDic:(NSDictionary *)dic {
    return [[self alloc]initBottomModuleWithDic:dic];
    
}

@end
