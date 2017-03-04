//
//  MZRStarView.m
//  HelloWorld
//
//  Created by qianfeng on 16/3/25.
//  Copyright © 2016年 mzr. All rights reserved.
//

#import "MZRStarView.h"

@interface MZRStarView ()

/** 背景 */
@property (nonatomic, strong) UIImageView *background;

/** 前景 */
@property (nonatomic, strong) UIImageView *foregreoud;

@end

@implementation MZRStarView


- (UIImageView *)background {
    if (!_background) {
        UIImage *image = [UIImage imageNamed:@"StarsBackground"];
        _background = [[UIImageView alloc] initWithImage:image];
        _background.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        
        [self addSubview:_background];
    }
    
    return _background;
}

- (UIImageView *)foregreoud {
    if (!_foregreoud) {
        // 先添加背景
        [self background];
        
        UIImage *image = [UIImage imageNamed:@"StarsForeground"];
        _foregreoud = [[UIImageView alloc] initWithImage:image];
        _foregreoud.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        
        // 设置超出部分裁剪
        _foregreoud.contentMode = UIViewContentModeLeft;
        
        _foregreoud.clipsToBounds = YES;
        
        
        [self addSubview:_foregreoud];
    }
    
    return _foregreoud;
}



- (void)setStar:(float)star {
    _star = star;
    
    UIImage *image = [UIImage imageNamed:@"StarsForeground"];
    
    float totalWidth = image.size.width;
    
    // 得到宽度
    float width = totalWidth * star / 5.f;
    
    self.foregreoud.frame = CGRectMake(0, 0, width, image.size.height);
}


@end
