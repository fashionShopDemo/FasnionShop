//
//  IntroduceVC.h
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DidSelectedEnter)();
@interface IntroduceVC : UIViewController

@property (nonatomic,copy) DidSelectedEnter block;
- (void)enterRootVC:(DidSelectedEnter)newBlock;
@end
