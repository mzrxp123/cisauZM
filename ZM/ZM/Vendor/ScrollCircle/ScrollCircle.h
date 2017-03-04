//
//  ScrollCircle.h
//  ZM
//
//  Created by com.chinazmglass.www on 2017/2/27.
//  Copyright © 2017年 com.MaZengrui.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollCircle : UIViewController

@property (nonatomic, assign) NSInteger * images; //图片总数
@property (nonatomic, strong) NSMutableArray * dataImagesURL; //图片数组,数组元素是轮播图url
/** 
 (NSInteger)currentPage  为图片总数
 
 */
- (UIView *)scrollCircle:(NSInteger)currentPage imagesDataSource:(NSMutableArray *)imagesArray scrollTimes:(NSInteger)loopTime;

@end
