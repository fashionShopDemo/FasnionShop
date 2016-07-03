//
//  IntroduceVC.m
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import "IntroduceVC.h"

@interface IntroduceVC ()

@end

@implementation IntroduceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    [self createIntroduce];
     [self enterButton];
//    [self createPlaceholder];
}
- (void)enterButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 100, 44);
    button.center = self.view.center;
    [button setTitle:@"Enter" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];




}
- (void)createPlaceholder {
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:kMainBounds];
    image.image = [UIImage imageNamed:@"1024-768-1"];
    [self.view addSubview:image];


}
- (void)createIntroduce {
  
    [NetRequestClass netRequestGETWithRequestURL:@"http://api-v2.mall.hichao.com/app/splash?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=27C3F6CE-7F12-493C-813C-DD71A58525A7&gs=640x1136&gos=9.2.1&access_token=" WithParameter:nil WithReturnValeuBlock:^(id responseObject, NSError *error) {
//        NSLog(@"%@",responseObject);
        if ([responseObject[@"data"][@"appApi"] isEqualToString:@""]) {
            [self createPlaceholder];
        }
        
    }];

//    
//    if ([NetRequestClass netWorkReachabilityWithURLString:@"http://api-v2.mall.hichao.com/app/splash?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=27C3F6CE-7F12-493C-813C-DD71A58525A7&gs=640x1136&gos=9.2.1&access_token="]) {
//        
//    }
//    else {
//        [self createPlaceholder];
//        NSLog(@"请链接网络");
//    }



}
- (void)enterRootVC:(DidSelectedEnter)newBlock {
    self.block = newBlock;
}
- (void)enter:(id)sender {
    self.block();
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
