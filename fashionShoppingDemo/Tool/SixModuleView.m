

//
//  SixModuleView.m
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import "SixModuleView.h"
@interface SixModuleView (){
    
    UILabel *_text;

}

@end
@implementation SixModuleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *styleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 20)];
    styleLable.text = @"";
    styleLable.textColor = [UIColor darkGrayColor];
    styleLable.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:styleLable];
    _text = styleLable;
}

@end
