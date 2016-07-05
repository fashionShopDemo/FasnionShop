//
//  HomeBottomModel.h
//  fashionShoppingDemo
//
//  Created by mac on 16/7/4.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeBottomModel : NSObject
@property (retain,nonatomic)NSString *nationalFlag;
@property (retain,nonatomic)NSString *picUrl;
@property (retain,nonatomic)NSString *price;
@property (retain,nonatomic)NSString *origin_price;
@property (retain,nonatomic)NSString *describe;
@property (retain,nonatomic)NSString *country;
- (instancetype)initBottomModuleWithDic:(NSDictionary *)dic;
+ (instancetype)createBottomModuleWithDic:(NSDictionary *)dic;

@end
