//
//  MZRloadViewController.m
//  MaZengrui
//
//  Created by qianfeng on 16/3/11.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import "MZRloadViewController.h"
#import "AppDelegate.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height


@interface MZRloadViewController() <UIScrollViewDelegate, UIApplicationDelegate>

@property (nonatomic, strong) UIPageControl * pageContorl;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation MZRloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataSource];
    [self createScrollView];
    [self createPageContorl];
    
}

- (NSArray *)dataSource {
    
    if (_dataSource == nil) {
        
//        _dataSource = @[@"guide1.jpg",@"guide10.jpg",@"guide2.jpg",@"guide5.jpg",@"guide3.jpg",@"guide6.jpg"];
        _dataSource = @[@"guide1.jpg",@"guide2.jpg",@"guide3.jpg"];
        
    }
    
    return _dataSource;
    
}

- (void)createScrollView {
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    //设置滚动视图能否滚动
    _scrollView.scrollEnabled = YES;
    //设置是否能够超出子视图滚动
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    //取消水平滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    //设置代理
    self.scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH * self.dataSource.count, SCREENHEIGHT);
    [self.view addSubview:_scrollView];
    
    [self createImageView];
}

- (void)createPageContorl {
    self.pageContorl=[[UIPageControl alloc]initWithFrame:CGRectMake(SCREENWIDTH / 2 - 50, SCREENHEIGHT - 50, 100, 30)];
    self.pageContorl.numberOfPages = self.dataSource.count;
    self.pageContorl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageContorl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:_pageContorl];
}

- (void)createImageView {
    
    for (int i = 0 ; i < self.dataSource.count; i++) {
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH * i, 0, SCREENWIDTH, SCREENHEIGHT)];
        
        imageview.userInteractionEnabled = YES;
        
        if (i == self.dataSource.count - 1) {
 
            UITapGestureRecognizer * tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
            [imageview addGestureRecognizer:tgr];
            
        }
            
        imageview.image = [UIImage imageNamed:self.dataSource[i]];
        
        
        [_scrollView addSubview:imageview];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger currentPage = scrollView.contentOffset.x /SCREENWIDTH;
    _pageContorl.currentPage = currentPage;
    
}

- (void)tapped:(UITapGestureRecognizer *)tgr {
    
    
    //点击屏幕从引导页进入主页面
    AppDelegate * delegate = (id)[UIApplication sharedApplication].delegate;
    
    [UIView animateWithDuration:2 animations:^{
        
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [delegate createAppFrame];
        
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    self.dataSource = nil;
    
}

@end
