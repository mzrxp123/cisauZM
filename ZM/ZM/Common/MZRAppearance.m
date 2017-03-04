//
//  MZRAppearance.m
//  HelloWorld
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 mzr. All rights reserved.
//

#import "MZRAppearance.h"
#import <UIKit/UIKit.h>
@implementation MZRAppearance

+ (void)setupAppearance {
    
    //设置导航栏
    [self setupNavigationBarAppearance];
    
}

//设置导航栏显示样式
+ (void)setupNavigationBarAppearance {
    
    //1.获取导航栏appearance对象
    UINavigationBar * bar = [UINavigationBar appearance];
    //有tabBar设置
    bar.barStyle = UIBarStyleBlackTranslucent;
#pragma mark - 图片拉伸
    /*
    UIImage * image = [UIImage imageNamed:@"list_pressed_holo_light.9"];
    //水平方向100 竖直方向22的这个像素点
    image = [image stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    //2.设置背景图片                                                         //详情
//    [bar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [bar setBackgroundImage:[UIImage imageNamed:@"list_pressed_holo_light.9"] forBarMetrics:UIBarMetricsDefault];
//    bar.backgroundColor = getColorRGBA(103, 201, 235, 1.0);
//    bar.translucent = NO;
     */
    [bar setBackgroundImage:[UIImage imageNamed:@"NavigationBarShadow@2x"] forBarMetrics:UIBarMetricsDefault];
    
    
}



@end
