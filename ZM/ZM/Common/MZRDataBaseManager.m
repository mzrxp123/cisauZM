//
//  MZRDataBaseManager.m
//  MaZengrui
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//
#if 0
#import "MZRDataBaseManager.h"

@implementation MZRDataBaseManager


+ (instancetype)sharedManager {
    
    static MZRDataBaseManager * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _manager = [[MZRDataBaseManager alloc] initWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"/model12.db"]];
        //打开数据库
        [_manager open];
        //建表
        [_manager createTable];
    });
    
    return _manager;
    
}

- (void)createTable {
    
    NSString * sql = @"create table if not exists MZRApp(ID primary key, name, attraction_trips_count, user_score, desc, name_en, attraction_type, description_summary, image_url)";
    [self executeUpdate:sql];
    
}
//增
- (void)addRecord:(MZRDestinationModel *)model {
    
    NSString * sql = @"insert into MZRApp (ID, name, attraction_trips_count, user_score, desc, name_en, attraction_type, description_summary, image_url) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    [self executeUpdate:sql, [NSString stringWithFormat:@"%zd",model.ID], model.name, [NSString stringWithFormat:@"%zd",model.attraction_trips_count], model.user_score, model.desc, model.name_en, model.attraction_type, model.description_summary, model.image_url];
    ;
}

//删除
- (void)deleteRecord:(MZRDestinationModel *)model {
    
    NSString * sql = @"delete from MZRApp where ID = ?";
    
    [self executeUpdate:sql, [NSString stringWithFormat:@"%zd",model.ID]];
    
}

- (BOOL)isCollect:(MZRDestinationModel *)model {
    
    NSString * sql = @"select * from MZRApp where ID == ?";
    
    FMResultSet * set = [self executeQuery:sql,[NSString stringWithFormat:@"%zd",model.ID]];
    
    return set.next;
    
    
}

// 查询所有数据
- (NSArray *)findAll {
    NSString *sql = @"select * from MZRApp";
    
    FMResultSet *set = [self executeQuery:sql];
    
    // 实例化一个可变数组, 接收数据
    NSMutableArray *allData = [[NSMutableArray alloc] init];
    
    while (set.next) {
        MZRDestinationModel * model = [MZRDestinationModel modelWithResultSet:set];
        // 添加数据
        [allData addObject:model];
    }
    // 把所有结果返回
    
    return allData;
}


@end
#endif
