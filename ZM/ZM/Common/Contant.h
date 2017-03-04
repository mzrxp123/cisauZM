//
//  Contant.h
//  HelloWorld
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 mzr. All rights reserved.
//

#ifndef Contant_h
#define Contant_h
#import <UIKit/UIKit.h>
#import "UIView+frame.h"
#import "UIImageView+WebCache.h"
//#import "MZRTraveCollectionView.h"
//#import <BmobSDK/Bmob.h>
#import "Auxiliary.h"
#import "MBProgressHUD.h"
#import "CSLClearCache.h"

#define ZM_MAIN_URL @"http://www.zhongguozhaomei.com"
#define PLACE_HOLDER_IMAGE [UIImage imageNamed:@"aviary_iap_workspace_shadow_top"]
//屏幕宽,高
#define MZR_SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define MZR_SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

//自定义颜色
#define getColorRGBA(_r,_g,_b,_a) [UIColor colorWithRed:_r/255.0 green:_g/255.0f blue:_b/255.0f alpha:_a]

/** 将服务器返回的数据写成plist */
#define JHAFNWriteToPlist(filename) [responseObject writeToFile:[NSString stringWithFormat:@"/Users/laijinhao/Desktop/%@.plist", filename] atomically:YES];

//新特性界面跳转的通知
#define kNewFeatureNotify @"newFeature2TabBar"
//Home里面的每组头部点击跳转的通知
#define kShark @"kHeader2Shark"
//屏幕的高度和宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//默认导航栏的高度
#define JHNavHeight 64


//颜色
/** 随机色 */
#define MZR_RandomColor JHColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define MZR_RGBColor(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

/** 灰色 */
#define MZR_GrayColor(v) JHColor((v),(v),(v))
#define MZR_CommonBgColor JHGrayColor(215);

// 快速创建弱指针
#define __weakSelf __weak typeof(self) weakSelf = self;

//边距
#define PADDING 8
#define NAME_HEIGHT 40
#define DETAIL_HEIGHT 30
#define USERIMAGE_WIDTH 45
#define CORNER_RADIUS 5
#define USER_PADDING 2
#define NAME_FONT 23
#define DETAIL_FONT 15


/*****************************************************************************************************/

/** 判断iOS版本 */
#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)

/** 判断是否为iPhone6,6s,7,7s */
#ifndef iPhone6//﻿
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#endif
/** 判断是否为iPhone6p,6sp,7p */
#ifndef iPhone6P
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

/** 判断是否为iPhone5系列机型 */
#ifndef iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

/** 判断是否为iPhone4系列机型 */
#ifndef iPhone4
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#endif


/*****************************************************************************************************/

#endif /* Contant_h */
