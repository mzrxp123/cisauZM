//
//  AppDelegate.m
//  ZM
//
//  Created by com.chinazmglass.www on 2017/2/23.
//  Copyright © 2017年 com.MaZengrui.www. All rights reserved.
//

#import "AppDelegate.h"
#import "MZRNavigationViewController.h"
#import "MZRScrollPageViewController.h"
#import "MZRAppearance.h"
#import "MZRTabBarController.h"
#import "MZRloadViewController.h"
//#import <BmobSDK/Bmob.h>
// 友盟分享
//#import "UMSocial.h"
//// QQ分享
//#import "UMSocialQQHandler.h"
//// 微信分享
//#import "UMSocialWechatHandler.h"
//// 微博分享
//#import "UMSocialSinaHandler.h"
@interface AppDelegate ()
@property (nonatomic, strong) MZRTabBarController * tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initWindow];
//    [Bmob registerWithAppKey:@"ecc9f063c62174060254c8c3e031f80e"];
    //友盟初始化方法调用
//    [self UmengInit];
    //设置根视图控制器
    [self loadViewController];
    //UIAppearance 设置整体显示风格
    [MZRAppearance setupAppearance];
    return YES;
}

- (void)UmengInit {
#if 0
    //初始化友盟社会化组件
    [UMSocialData setAppKey:UMENGAPPKEY];
    //初始化微信
    [UMSocialWechatHandler setWXAppId:@"wxe6b5b748cdcff60f" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:@"http://www.umeng.com/social"];
    //初始化qq
    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@"MnGtpPN5AiB6MNvj" url:@"http://www.umeng.com/social"];
    //隐藏未安装客户端
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToTencent,UMShareToWechatSession,UMShareToQQ]];
#endif
}

- (void)initWindow {
    //1.实例化一个window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //2.使窗口可见
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

- (void)loadViewController {
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLoading"] isEqualToString:@"Firstload"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"Firstload" forKey:@"FirstLoading"];
        MZRloadViewController * loadVC = [[MZRloadViewController alloc] init];
        self.window.rootViewController = loadVC;
    } else {
        [self createAppFrame];
    }
}

//搭建应用框架
- (void)createAppFrame {
    //创建标签栏控制器
    _tabBarController = [[MZRTabBarController alloc] init];
    
    //增加标签1
    [_tabBarController addItem:@"首页" normalImage:[UIImage imageNamed:@"TabBarIconFeaturedNormal@3x"] highLightImage:[UIImage imageNamed:@"TabBarIconFeatured@3x"] controller:@"ZMHomePageViewController"];
    
    //增加标签2
    [_tabBarController addItem:@"全部分类" normalImage:[UIImage imageNamed:@"TabBarIconDestinationNormal@3x"] highLightImage:[UIImage imageNamed:@"TabBarIconDestination@3x"] controller:@"ZMAllCategoriesViewController"];
    
    //增加标签3
    [_tabBarController addItem:@"购物车" normalImage:[UIImage imageNamed:@"TabBarIconToolboxNormal@3x"] highLightImage:[UIImage imageNamed:@"TabBarIconToolbox@3x"] controller:@"ZMShoppingCartViewController"];
    
    //增加标签4
    [_tabBarController addItem:@"会员中心" normalImage:[UIImage imageNamed:@"TabBarIconMyNormal@3x"] highLightImage:[UIImage imageNamed:@"TabBarIconMy@3x"] controller:@"ZMPersonalCenterViewController"];
    
    //设置标签栏的viewControllers数组
    _tabBarController.viewControllers = _tabBarController.controllers;
    
    //设置window的rootviewcontroller
    self.window.rootViewController = _tabBarController;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
