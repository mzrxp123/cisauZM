//
//  MZRRootViewController.h
//  HelloWorld
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 mzr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZRNetRequest.h"
typedef NS_ENUM(NSInteger, refreshStatus) {
    refreshStatusUnKnow = 0,   //未知状态
    refreshStatusRefresh,      //下拉刷新
    refreshStatusLoadMore,     //上拉加载
};
@interface MZRRootViewController : UIViewController

- (void)parserData:(id)data;//数据解析
- (void)request:(NSString*)method url:(NSString*)urlString para:(NSDictionary*)dict;

- (void)showIndicatorInView:(UIView*)parentView isDisplay:(BOOL)show;

@property(nonatomic,assign) BOOL isLoadIndicator;//是否显示加载指示器
@end
