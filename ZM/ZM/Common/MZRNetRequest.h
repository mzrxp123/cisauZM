//
//  MZRNetRequest.h
//  HelloWorld
//
//  Created by MaZengrui on 16/3/18.
//  Copyright © 2016年 mzr. All rights reserved.
//

#define kTimeOutInterval 30 //请求超时的时间
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef void (^CompleteCallBack)(id data);//请求完成时的回调
typedef void (^FailureCallBack)(NSError* error);//请求出错的回调

@interface MZRNetRequest : NSObject

//功能：get方式请求数据
//参数：urlString 网址
//     complete 请求完成时的回调
//     failure  请求出错的回调
//返回值：无
+ (void) get:(NSString*)urlString para:(NSDictionary*)paras  complete:(CompleteCallBack)complete fail:(FailureCallBack)failure;

//功能：post方式请求数据
//参数：urlString 网址
//     paras 一个字典，请求参数
//     complete 请求完成时的回调
//     failure  请求出错的回调
//返回值：无
+ (void) post:(NSString*)urlString para:(NSDictionary*)paras complete:(CompleteCallBack)complete fail:(FailureCallBack)failure;


//获取网络状态
- (void) AFNetworkStatus;
@end
