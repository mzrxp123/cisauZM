//
//  ZMHomePageModel.h
//  ZM
//
//  Created by com.chinazmglass.www on 2017/2/24.
//  Copyright © 2017年 com.MaZengrui.www. All rights reserved.
//

#import "MZRAppModel.h"

#pragma mark - 空协议
@class ResultPageP;
@protocol ResultPageP
@end
@class ResultProductInfo;
@protocol ResultProductInfo
@end

@interface ZMHomePageModel : MZRAppModel

@property (nonatomic, assign) NSInteger imageNum;    //轮播图图片数量
@property (nonatomic, strong) NSArray * imageUrl;     //轮播图片
@property (nonatomic, strong) ResultPageP * resultPageP;   //商品collection

@end

@interface ResultPageP : JSONModel

@property (nonatomic, assign) NSInteger pageSize;    //单页商品数量
@property (nonatomic, strong) NSArray<ResultProductInfo> * resultProductInfo;
//@property (nonatomic, strong) ResultProductInfo * resultProductInfo;  //商品信息

@end

@interface ResultProductInfo : JSONModel

@property (nonatomic, copy) NSString * brand;   //品牌名称
@property (nonatomic, assign) NSInteger brandId;    //品牌id
@property (nonatomic, assign) NSInteger categoryId; //分类id
@property (nonatomic, assign) NSInteger displaySequence; //商品顺序
@property (nonatomic, assign) BOOL hasSku; //库存规格
@property (nonatomic, copy) NSString * imageUrl;    //不知道是什么图片的url 原图URL？
@property (nonatomic, assign) CGFloat lowestSalePrice; //最低售价
@property (nonatomic, copy) NSString * mainCategoryPath; //主分类路径
@property (nonatomic, assign) CGFloat marketPrice; //市场价
@property (nonatomic, assign) NSInteger points;     //美豆
@property (nonatomic, copy) NSString * productCode; //产品编码
@property (nonatomic, assign) NSInteger productId; //产品id
@property (nonatomic, copy) NSString * productName; //产品名称
@property (nonatomic, copy) NSString * productType; //产品类型
@property (nonatomic, assign) NSInteger regionId;   //底层地址id
@property (nonatomic, assign) NSInteger saleCounts;  //销售数量
@property (nonatomic, assign) NSInteger saleStatus;  //销售状态
@property (nonatomic, assign) NSInteger salesType;   //销售类型
@property (nonatomic, assign) NSInteger stock;      //库存数量
@property (nonatomic, copy) NSString * thumbnailUrl1;  //商品图片
@property (nonatomic, assign) NSInteger typeId; //类型id 我也不知道是什么类型的id
@property (nonatomic, copy) NSString * unit;    //单位
@property (nonatomic, assign) NSInteger vistiCounts;  //不知道


@end
