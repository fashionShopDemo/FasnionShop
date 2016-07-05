//
//  TabBarVC.m
//  fashionShoppingDemo
//
//  Created by mac on 16/7/3.
//  Copyright © 2016年 lyq. All rights reserved.
//

#import "TabBarVC.h"
#import "BXTabBar.h"
#import "LYQCollocativeVC.h"
#import "LYQCommunityVC.h"
#import "LYQHomeVC.h"
#import "FHMVC.h"
#import "MainVC.h"
#import "NavVC.h"

#define kTabbarHeight 49
#define  kContentFrame  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-kTabbarHeight)
#define  kDockFrame CGRectMake(0, self.view.frame.size.height-kTabbarHeight, self.view.frame.size.width, kTabbarHeight)



@interface TabBarVC ()<UITabBarControllerDelegate,UINavigationControllerDelegate,BXTabBarDelegate>

@property (nonatomic, assign) BOOL jump;
@property (nonatomic, assign) NSInteger lastSelectIndex;
@property (nonatomic, strong) UIView *redPoint;
/** view */
@property (nonatomic, strong) UIView *mytabbar;

@property (nonatomic, strong) id popDelegate;
/** 保存所有控制器对应按钮的内容（UITabBarItem）*/
@property (nonatomic, strong) NSMutableArray *items;


@end

@implementation TabBarVC
- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBar.hidden = YES;
    for (UIView *childView in self.tabBar.subviews) {
        if (![childView isKindOfClass:[BXTabBar class]]) {
            [childView removeFromSuperview];
        }
        
    }


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    // 添加所有子控制器
    [self addAllChildVc];
    // 自定义tabBar
    [self setUpTabBar];
  
}
- (void)setUpTabBar
{
    
    
    BXTabBar *tabBar = [[BXTabBar alloc] init];
    
    // 存储UITabBarItem
    tabBar.items = self.items;
    
    tabBar.delegate = self;
    
    tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_backgroud"]];;
    
    //    tabBar.frame = self.tabBar.bounds;
    //
    //    [self.tabBar addSubview:tabBar];
    tabBar.frame = self.tabBar.frame;
    [self.view addSubview:tabBar];
    self.mytabbar = tabBar;
}

- (void)addAllChildVc {
    // 添加初始化子控制器
    LYQHomeVC *home = [[LYQHomeVC alloc] init];
        home.view.backgroundColor = Global_mainBackgroundColor;
    [self addOneChildVC:home title:@"首页" imageName:@"bottom_home_icon@2x" selectedImageName:@"bottom_home_icon_on@2x"];
     
    LYQCollocativeVC *collocation = [[LYQCollocativeVC alloc] init];
    [self addOneChildVC:collocation title:@"搭配" imageName:@"bottom_dapei_icon@2x" selectedImageName:@"bottom_dapei_icon_on@2x"];
    collocation.view.backgroundColor = Global_mainBackgroundColor;
    
    LYQCommunityVC *community = [[LYQCommunityVC alloc] init];
    [self addOneChildVC:community title:@"社区" imageName:@"bottom_bbs_icon@2x" selectedImageName:@"bottom_bbs_icon_on@2x"];
    community.view.backgroundColor = Global_mainBackgroundColor;
    
    FHMVC *fhmVC = [[FHMVC alloc] init];
    [self addOneChildVC:fhmVC title:@"男人邦" imageName:@"clothes-detail-like1@2x" selectedImageName:@"clothes-detail-like-on@2x"];
    fhmVC.view.backgroundColor = Global_mainBackgroundColor;
    
    MainVC *mainVC = [[MainVC alloc]init];
    [self addOneChildVC:mainVC title:@"我的" imageName:@"bottom_like_icon@2x" selectedImageName:@"bottom_like_icon_on@2x"];
    mainVC.view.backgroundColor = Global_mainBackgroundColor;
    
}

/**
 *  添加一个自控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中时的图标
 */

- (void)addOneChildVC:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 设置标题
    childVc.tabBarItem.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置tabbarItem的普通文字
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [[UIColor alloc]initWithRed:113/255.0 green:109/255.0 blue:104/255.0 alpha:1];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = BXColor(51, 135, 255);
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 不要渲染
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 记录所有控制器对应按钮的内容
    [self.items addObject:childVc.tabBarItem];
    
    // 添加为tabbar控制器的子控制器
    NavVC *nav = [[NavVC alloc] initWithRootViewController:childVc];
    
    nav.delegate = self;
    [self addChildViewController:nav];
}

#pragma mark - BXTabBarDelegate方法
// 监听tabBar上按钮的点击
- (void)tabBar:(BXTabBar *)tabBar didClickBtn:(NSInteger)index
{
    self.selectedIndex = index;
}

#pragma mark navVC代理
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *root = navigationController.viewControllers.firstObject;
    if (viewController != root) {
        //更改导航控制器的高度
        navigationController.view.frame = self.view.bounds;
        //从HomeViewController移除
        [self.mytabbar removeFromSuperview];
        // 调整tabbar的Y值
        CGRect dockFrame = self.mytabbar.frame;
        
        if ([root.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollview = (UIScrollView *)root.view;
            dockFrame.origin.y = scrollview.contentOffset.y + root.view.frame.size.height - kTabbarHeight;
        } else {
            // dockFrame.origin.y -= kDockHeight;
            
            dockFrame.origin.y = root.view.frame.size.height - kTabbarHeight;
        }
        _mytabbar.frame = dockFrame;
        
        
        //添加dock到根控制器界面
        [root.view addSubview:_mytabbar];
    }
}

// 完全展示完调用
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *root = navigationController.viewControllers.firstObject;
    NavVC *nav = (NavVC *)navigationController;
    if (viewController == root) {
        // 更改导航控制器view的frame
        navigationController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kTabbarHeight);
        
        navigationController.interactivePopGestureRecognizer.delegate = nav.popDelegate;
        // 让Dock从root上移除
        [_mytabbar removeFromSuperview];
        
        //_mytabbar添加dock到HomeViewController
        _mytabbar.frame = self.tabBar.frame;
        [self.view addSubview:_mytabbar];
    }
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
