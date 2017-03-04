//
//  MZRDataBaseManager.h
//  MaZengrui
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//
#if 0

#import "FMDatabase.h"
#import "Contant.h"
//#import "MZRDestinationModel.h"
@interface MZRDataBaseManager : FMDatabase


/** 数据库单例 */
+ (instancetype)sharedManager;

// 增
- (void)addRecord:(MZRDestinationModel *)model;
// 删
- (void)deleteRecord:(MZRDestinationModel *)model;

// 查询所有
- (NSArray *)findAll;

// 传入一个数据, 判断这条数据是否存在
- (BOOL)isCollect:(MZRDestinationModel *)model;


@end
#else
#endif
