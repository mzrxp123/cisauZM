//
//  MZRTabBarController.m
//  HelloWorld
//
//  Created by qianfeng on 16/3/26.
//  Copyright © 2016年 mzr. All rights reserved.
//

#import "MZRTabBarController.h"

@interface MZRTabBarController ()

@end

@implementation MZRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//初始化
-(instancetype)init{
    if (self=[super init]) {
        _controllers = [[NSMutableArray alloc] init];
    }
    return self;
}

//创建tabbaritem
-(void) addItem:(NSString*)title normalImage:(UIImage*)normal highLightImage:(UIImage*)highLight controller:(NSString*)controllerName {
    
    //创建tabBarItem
    normal = [normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    highLight = [highLight imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:title image:normal selectedImage:highLight];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    
    //得到控制器类
    Class controllerClass = NSClassFromString(controllerName);
    
    //创建控制器
    UIViewController *  controller = [[controllerClass alloc] init];
    controller.navigationItem.title = title;//设置导航栏标题
    
    //创建导航栏
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    //219为红色
    navigationController.navigationBar.barTintColor = [UIColor colorWithRed:219/255.0 green:0 blue:0 alpha:1.0];
    
    //设置item
    controller.tabBarItem = item;
    //    controller.tabBarController.tabBar.barTintColor = ;
    //    self.tabBar.barTintColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    
    //将控制器加入数组
    [_controllers addObject:navigationController];
    
}
@end
