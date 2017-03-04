//
//  ZMHomePageViewController.h
//  ZM
//
//  Created by com.chinazmglass.www on 2017/2/24.
//  Copyright © 2017年 com.MaZengrui.www. All rights reserved.
//

#import "MZRRootViewController.h"

@interface ZMHomePageViewController : MZRRootViewController
//数据分页
@property(nonatomic, assign) int page;
//本界面网址
@property(nonatomic, copy) NSString * url;
//请求数据方法
@property(nonatomic, copy) NSString * method;
//刷新状态
@property(nonatomic, assign) refreshStatus status;
@end
