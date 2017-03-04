//
//  ScrollCircle.m
//  ZM
//
//  Created by com.chinazmglass.www on 2017/2/27.
//  Copyright © 2017年 com.MaZengrui.www. All rights reserved.
//

#import "ScrollCircle.h"
#import "Contant.h"
@interface ScrollCircle () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation ScrollCircle {
    
    UIPageControl * _pageControl;
    NSInteger _imagesArrayCount;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initScrollView];
//    [self createPageControl];
}

- (NSMutableArray *)dataImagesURL {

    if (_dataImagesURL == nil) {
        _dataImagesURL = [[NSMutableArray alloc] init];
    }
    return _dataImagesURL;
}

- (UIView *)scrollCircle:(NSInteger)currentPage imagesDataSource:(NSMutableArray *)imagesArray scrollTimes:(NSInteger)loopTime {
    
//    [self viewDidLoad];
    self.view.frame = CGRectMake(0, 0, MZR_SCREEN_WIDTH, MZR_SCREEN_HEIGHT / 3);
    _imagesArrayCount = [imagesArray count];
    [self initScrollView:currentPage imagesDataSource:imagesArray];
    [self autoScroll:loopTime];
    [self createPageControl];
    
    return self.view;
}

- (void)initScrollView:(NSInteger)currentPage imagesDataSource:(NSMutableArray *)imagesArray {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    float width = self.scrollView.bounds.size.width;
    float height = self.scrollView.bounds.size.height;
    
    NSInteger imagesArrayCount = [imagesArray count];
    
    for (int i = 0; i < imagesArrayCount + 2; i ++) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        
        if (i == 0) {
            /** 根据后台图片类型，是否拼接域名 */
//            NSString * imgUrl = [NSString stringWithFormat:@"%@%@",ZM_MAIN_URL,imageURL];
            //最左边
            //imageURL为数组中最后一张图片
            NSString * imageURL = [imagesArray objectAtIndex:imagesArrayCount - 1];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:PLACE_HOLDER_IMAGE];
//            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"火影06"]];
        }
        else if (i == imagesArrayCount + 1) {
            //最右边
            //imageURL为数组中第一张图片
            NSString * imageURL = [imagesArray objectAtIndex:0];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:PLACE_HOLDER_IMAGE];
//            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"火影01"]];
        }
        else {
            //中间
#warning 测试index是否为i-1 若图片紊乱 换i尝试
            NSString * imageURL = [imagesArray objectAtIndex:i - 1];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:PLACE_HOLDER_IMAGE];
//            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"火影%02d",i]];
        }
        [self.scrollView addSubview:imageView];
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame), 0);
    }
    //设置一个初始偏移量,让用户第一眼看到大王
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    //自动滚动
//    [self autoScroll];
}

//自动滚动(向右)
- (void)autoScroll:(NSInteger)loopTime {
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:loopTime target:self selector:@selector(showTimer) userInfo:nil repeats:YES];
    [timer fire];
    
}

- (void)showTimer {
    
    NSInteger pages = self.scrollView.contentOffset.x / MZR_SCREEN_WIDTH;
    
    static NSInteger count = 1;
    if (count == _imagesArrayCount + 2) {
        [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.frame), 0) animated:NO];
#warning 注意count = 2 轮播紊乱请修改 ---Ma
        count = 2;
        [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * count, 0) animated:YES];
        count ++;
    } else {
        count = pages + 1;
        [self.scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * count, 0) animated:YES];
        count ++;
    }
}


#pragma mark - 创建PageControl
- (void)createPageControl {
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.height - 30, self.view.width, 30)];
    
    //设置背景颜色
    _pageControl.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.7];
    
    //核心属性：设置页数
    _pageControl.numberOfPages = _scrollView.contentSize.width / MZR_SCREEN_WIDTH - 2;
    //    _scrollView.contentOffset.x / SCREEN_SIZE.width  当前处于页数的下标
    //修改当前页数                                                        1 - 1 = 0
    _pageControl.currentPage = _scrollView.contentOffset.x / MZR_SCREEN_WIDTH - 1;
    
    //    _pageControl.currentPage = _scrollView.contentOffset.x / SCREEN_SIZE.width - 0;
    //修改颜色
    //选中的小圆点的颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //未选中的小圆点的颜色
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    //当只有一页的时候，是否隐藏PageControl
    _pageControl.hidesForSinglePage = YES;
    
    //绑定事件
    [_pageControl addTarget:self action:@selector (pagging:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:_pageControl];
    
}

- (void)pagging:(UIPageControl *)pageControl {
    
    //滚动视图发生滚动,其实只是contentOffset在改变
    NSInteger index = pageControl.currentPage;
    [self.scrollView setContentOffset:CGPointMake(index * MZR_SCREEN_WIDTH, 0) animated:YES];
    
    
}

#pragma mark - UIScrollViewDelegate

//滚动视图发生滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSUInteger currentPage = (_scrollView.contentOffset.x - MZR_SCREEN_WIDTH / 2) / MZR_SCREEN_WIDTH + 1;
    //    NSUInteger currentPage = _scrollView.contentOffset.x / SCREEN_SIZE.width;
    if (_imagesArrayCount) {
        if (currentPage == _imagesArrayCount + 1) {
            _pageControl.currentPage = 0;
            return;
        }
        _pageControl.currentPage = currentPage - 1;
    }
//    if (currentPage == 7) {
//        _pageControl.currentPage = 0;
//        return;
//    }
//    _pageControl.currentPage = currentPage - 1;
}



//停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    float width = CGRectGetWidth(scrollView.frame);
    //contentOffset / 宽 = 页码
    NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    if (page == _imagesArrayCount + 1) {
        // 如果滚动到了最后一页,瞬间替回第一个大王
        [scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
        
    }
    else if (page == 0) {
        //如果滚动到了第一个方片,顺便替换回最后一个方片
        [scrollView setContentOffset:CGPointMake(width * 6, 0) animated:NO];
    }
    
}

//动画滚动完成后回调 setContentOffset: animated:YES
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
