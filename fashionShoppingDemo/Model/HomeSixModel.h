//
//  HomeSixModel.h
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeSixModel : NSObject
@property (nonatomic,retain)NSString *picUrl;
@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)NSString *price;
@property (nonatomic,retain)NSString *origin_price;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)createWithDic:(NSDictionary *)dic;
@end
