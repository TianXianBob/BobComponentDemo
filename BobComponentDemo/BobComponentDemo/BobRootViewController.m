//
//  BobRootViewController.m
//  BobComponentDemo
//
//  Created by tugou on 2019/3/28.
//  Copyright © 2019年 陈星辰. All rights reserved.
//

#import "BobRootViewController.h"
#import "ZFTabBar.h"

@interface BobRootViewController ()<ZFTabBarDelegate>
/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) ZFTabBar *customTabBar;
@end

@implementation BobRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}

- (void)initialize {
    self.view.backgroundColor = [UIColor whiteColor];
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    ZFTabBar *customTabBar = [[ZFTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}


/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(ZFTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    if (self.selectedIndex == to && to == 0 ) {//双击刷新制定页面的列表
        UINavigationController *nav = self.viewControllers[0];
        FirstViewController *firstVC = nav.viewControllers[0];
        [firstVC refrshUI];
    }
    self.selectedIndex = to;
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.首页
    FirstViewController *home = [[FirstViewController alloc] init];
    home.tabBarItem.badgeValue = @"N";
    [self setupChildViewController:home title:@"首页" imageName:@"shouye" selectedImageName:@"shouye_s"];
    
    // 2.消息
    SecondViewController *message = [[SecondViewController alloc] init];
    message.tabBarItem.badgeValue = @"8";
    [self setupChildViewController:message title:@"消息" imageName:@"quanzi" selectedImageName:@"quanzi_s"];
    
    // 3.首页
    FirstViewController *home1 = [[FirstViewController alloc] init];
    home1.tabBarItem.badgeValue = @"19";
    [self setupChildViewController:home1 title:@"发现" imageName:@"shouye" selectedImageName:@"shouye_s"];
    
    // 4.消息
    SecondViewController *message1 = [[SecondViewController alloc] init];
    message1.tabBarItem.badgeValue = @"99";
    [self setupChildViewController:message1 title:@"广场" imageName:@"quanzi" selectedImageName:@"quanzi_s"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 2.包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

@end
