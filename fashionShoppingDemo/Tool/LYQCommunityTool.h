//
//  LYQCommunityTool.h
//  fashionShoppingDemo
//
//  Created by mac on 16/7/5.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYQCommunityTool : NSObject
+ (void)getHeaderScrollViewDataWithBlock:(void(^)(NSMutableArray *dataArr))block;
@end
