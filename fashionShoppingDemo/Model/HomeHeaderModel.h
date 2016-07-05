//
//  HomeHeaderModel.h
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeHeaderModel : NSObject
@property (retain,nonatomic)NSString *picUrl;
@property (retain,nonatomic)NSString *twoPicUrl;
- (instancetype)initHeaderWithDic:(NSDictionary *)dic;
+ (instancetype)createHeaderWithDic:(NSDictionary *)dic;
@end
