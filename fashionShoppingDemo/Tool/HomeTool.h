//
//  HomeTool.h
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HomeTool : NSObject
+ (void)getHomeHeaderDatawithBlock:(void(^)(NSMutableArray *dataArr))block;

+ (void)getHomeTwoModuleDatawithBlock:(void(^)(NSMutableArray *dataArr))block;

+ (void)getHomeSixModuleDatawithBlock:(void(^)(NSMutableArray *dataArr))block withUrl:(NSString *)urlStr;
+ (NSMutableArray *)getSixModelWith:(NSMutableArray *)Arr;


@end
