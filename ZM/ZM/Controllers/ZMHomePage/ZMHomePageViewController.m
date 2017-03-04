//
//  ZMHomePageViewController.m
//  ZM
//
//  Created by com.chinazmglass.www on 2017/2/24.
//  Copyright © 2017年 com.MaZengrui.www. All rights reserved.
//
#define TRAVEL_CELL @"travelCell"
#define HEADER_ID @"kHeaderID"
#import "MZRCollectionView.h"
#import "Contant.h"
#import "NetInterface.h"
#import <MJRefresh/MJRefresh.h>
#import "ScrollCircle.h"
#import "MZRSearchBar.h"

#import "ZMHomePageViewController.h"
#import "ZMHomePageViewCell.h"
#import "ZMHomePageModel.h"
#import "ZMHomePageProductModel.h"

/** 头部视图 */
#import "MZRHeaderFlowLayout.h"
#import "MZRHeaderReusableView.h"

#define SCROLL_TIME 4

@interface ZMHomePageViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate>
@property (nonatomic, strong) MZRCollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) NSMutableArray * dataSourceScrollImages;
@property (nonatomic, strong) NSDictionary * parameters;
@property (nonatomic, strong) ZMHomePageModel * modelScroll;

@property (nonatomic, strong) MZRSearchBar * searchBar;

@end

@implementation ZMHomePageViewController {
    id dataMZR;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = STRING_ZM_HOMEPAGE;
    self.page = 1;
    self.method = @"POST";
    self.url = PATH_ZM_HOMEPAGE;
    self.parameters = @{@"appid":APPID_WX,CURRENT_PAGE:@(self.page)};
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self createCollectionView];
    [self addRefresh];
}
- (void)createCollectionView {
    //流布局
    MZRHeaderFlowLayout * layout = [[MZRHeaderFlowLayout alloc] init];
//    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.headerReferenceSize = CGSizeMake(MZR_SCREEN_WIDTH, MZR_SCREEN_HEIGHT / 3);
//    layout.headerReferenceSize = CGSizeMake(MZR_SCREEN_WIDTH, 300);
    //每个元素大小
    layout.itemSize = CGSizeMake((MZR_SCREEN_WIDTH - PADDING * 3) / 2, MZR_SCREEN_HEIGHT / 3);
    //垂直方向最小间距
    layout.minimumLineSpacing = PADDING;
    //设置水平方向最小距离
    layout.minimumInteritemSpacing = PADDING;
    //滚动方向 (垂直滚动)
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置元素与边界的间距
    layout.sectionInset = UIEdgeInsetsMake(PADDING, PADDING, PADDING, PADDING);
    //实例化collectionView
    self.collectionView = [[MZRCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell
    [self registerXibCell];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //添加到视图上
    [self.view addSubview:self.collectionView];
}

/** 注册复用 */
- (void)registerXibCell {
    UINib *nib = [UINib nibWithNibName:@"ZMHomePageViewCell" bundle:nil];
    //注册cell
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:TRAVEL_CELL];
    //注册组头视图
    [self.collectionView registerClass:[MZRHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_ID];
//    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MZRHeaderReusableView class]) bundle:nil]
//          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_ID];
}

#pragma mark - 请求数据
- (void)loadData {
    self.isLoadIndicator = YES;
    [self showIndicatorInView:self.view isDisplay:YES];
    
    [self request:self.method url:self.url para:self.parameters];
    
}

//集成下拉刷新上拉加载
-(void)addRefresh
{
    // 1.集成下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //刷新事件,其实就是重新执行的数据请求这个方法，拿到最新的数据，显示到界面上来
        self.status = refreshStatusRefresh;
        self.page = 1;
        self.parameters = @{@"appid":APPID_WX,CURRENT_PAGE:@(self.page)};
        [self request:self.method url:self.url para:self.parameters];
        
    }];
    self.collectionView.mj_header = header;
    
    // 2.集成上拉加载
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //这里是上拉加载需要执行的事件
        self.status = refreshStatusLoadMore;
        self.page += 1;
        //在此处把修改后的page代入para中
        self.parameters = @{@"appid":APPID_WX,CURRENT_PAGE:@(self.page)};
        [self request:self.method url:self.url para:self.parameters];
        
    }];
    self.collectionView.mj_footer = footer;
}

//子类是实现
- (void)parserData:(id)data{
#if 0
    //根据不同的状态,对数据进行不同的处理
    if (self.status == refreshStatusRefresh) {
        //先把原来的所有数据都移除了
        [self.dataSource removeAllObjects];
    }
    NSArray * allData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary * dic in allData) {
        ZMHomePageModel * model = [[ZMHomePageModel alloc] initWithDictionary:dic error:nil];
        [self.dataSource addObject:model];
    }
    //刷新表格
    [self.collectionView reloadData];
    [self showIndicatorInView:self.view isDisplay:NO];
    [self doneLoading];
#endif
    //根据不同的状态,对数据进行不同的处理
    if (self.status == refreshStatusRefresh) {
        //先把原来的所有数据都移除了
        [self.dataSource removeAllObjects];
    }
    NSDictionary * allData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",allData);
    //数据封装模型
    ZMHomePageModel * model = [[ZMHomePageModel alloc] initWithDictionary:allData error:nil];
    //单独封装组头模型获取imgs
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.modelScroll = [[ZMHomePageModel alloc] initWithDictionary:allData error:nil];
        for (NSString * strImg in model.imageUrl) {
            [self.dataSourceScrollImages addObject:strImg];
        }
    });

    //轮播图插入数据源
//    self.dataSourceScrollImages = [NSMutableArray arrayWithArray:self.modelScroll.imageUrl];
    
    NSDictionary * resultPage = [NSDictionary dictionaryWithDictionary:(NSDictionary *)model.resultPageP];
    NSArray * resultProductInfoProduct = [NSArray arrayWithArray:[resultPage objectForKey:@"resultProductInfo"]];
    //商品模型加入数据源
    for (NSDictionary * productDic in resultProductInfoProduct) {
        //模型数据二次封装
        ZMHomePageProductModel * model = [[ZMHomePageProductModel alloc] initWithDictionary:productDic error:nil];
        [self.dataSource addObject:model];
    }
    //刷新表格
    [self.collectionView reloadData];
    [self showIndicatorInView:self.view isDisplay:NO];
    [self doneLoading];
#if 0
    //测试用数据
    NSLog(@"%lu",(unsigned long)self.dataSource.count);
    NSLog(@"%@",self.dataSource);
#endif
    
}
- (void)doneLoading{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    
    //    [self showIndicatorInView:self.view isDisplay:NO];
}

#pragma mark - 懒加载数据源
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
#pragma mark - 懒加载头部滚动视图数据源
- (NSMutableArray *)dataSourceScrollImages {
    if (_dataSourceScrollImages == nil) {
        _dataSourceScrollImages = [[NSMutableArray alloc] init];
    }
    return _dataSourceScrollImages;
}

#pragma mark - UICollectionView DataSource里面的协议方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
//每组多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //第0组组头为滚动视图,所以没有item
    if (section == 0) {
        return 0;
    }
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZMHomePageViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TRAVEL_CELL forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aviary_iap_workspace_shadow_bottom"]];
    cell.layer.borderColor = getColorRGBA(114, 56, 31, 0.1).CGColor;
    cell.layer.borderWidth = 1;
    cell.model = self.dataSource[indexPath.row];
    return cell;
    
    
}


#pragma mark - UICollectionViewDelegate
//选中回调
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    MZRTraveModel * model = self.dataSource[indexPath.row];
//    MZRTravelDetialViewController * tdVC = [[MZRTravelDetialViewController alloc] init];
//    tdVC.block =  ^NSInteger(){
//        return model.ID;
//    };
//    [self.navigationController pushViewController:tdVC animated:YES];
}

////返回这个UICollectionView是否可以被选择
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

#pragma mark - UICollectionViewDelegateFlowLayout
/*
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(96, 100);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
*/


/*
#注意: 这里的JHHeaderReusableView 是我自定义的头部视图的类
#头部视图的类自定义必须继承UICollectionReusableView
#我上面的是通过xib 所以注册的时候需要注意 (一般界面没上面大的改变推荐使用xib实现)

#下面是头部视图的代理方法:
*/
#pragma mark - 头部或者尾部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
    }
    //如果是头部视图 (因为这里的kind 有头部和尾部所以需要判断  默认是头部,严谨判断比较好)
    /*
     MZRHeaderReusableView 头部的类
     HeaderID  重用标识
     */
    if (kind == UICollectionElementKindSectionHeader) {
        MZRHeaderReusableView *headerRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEADER_ID forIndexPath:indexPath];
        headerRV.clipsToBounds = YES;
        
//        headerRV.model = self.dataSourceScrollImages[indexPath.section];
//        headerRV.homeModel = self.bodyArray[indexPath.section];
        if (indexPath.section == 0) {
            if ([self.dataSourceScrollImages count] == 0) {
                return headerRV;
            }
            [headerRV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            ScrollCircle * scrollCView = [[ScrollCircle alloc] init];
            [headerRV addSubview:[scrollCView scrollCircle:[self.dataSourceScrollImages count] imagesDataSource:self.dataSourceScrollImages scrollTimes:SCROLL_TIME]];
            headerRV.backgroundColor = [UIColor whiteColor];
            
            return headerRV;
        } else if (indexPath.section == 1){
            //移除所有子视图
            [headerRV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            self.searchBar = [[MZRSearchBar alloc] initWithFrame:CGRectMake(0, 0, MZR_SCREEN_WIDTH, MZR_SCREEN_HEIGHT / 16)];
            self.searchBar.delegate = self;
            self.searchBar.barStyle = UISearchBarStyleDefault;
            [self.searchBar setTintColor:[UIColor whiteColor]];
            
            //遮罩层
            UIView *blackView = [UIView new];
            blackView.frame = CGRectMake(0, 64, MZR_SCREEN_WIDTH, MZR_SCREEN_HEIGHT);
            blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
            UITapGestureRecognizer * tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
            [blackView addGestureRecognizer:tgr];
            [self.searchBar setInputAccessoryView:blackView];
            
            
            self.searchBar.placeholder = @"请输入要搜索的商品";
//            self.searchBar.barTintColor = [UIColor whiteColor];
            self.searchBar.tintColor = [UIColor redColor];
            
            [headerRV addSubview:self.searchBar];
//            headerRV.backgroundColor = [UIColor greenColor];
            return headerRV;
        }
        
        return nil;
        
    }else //添加尾部视图
    {
        return nil;
    }
}

- (void)tapped:(UITapGestureRecognizer *)tgr{

    [self.searchBar resignFirstResponder];
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return CGSizeMake(MZR_SCREEN_WIDTH,MZR_SCREEN_HEIGHT / 3);
    } else {
        return CGSizeMake(MZR_SCREEN_WIDTH,MZR_SCREEN_HEIGHT / 16);
    }
    
//    return CGSizeMake(MZR_SCREEN_WIDTH,MZR_SCREEN_HEIGHT / 3);
    // 垂直滚动 宽无意义
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(PADDING, PADDING, PADDING, PADDING);
    } if (section == 1) {
        return UIEdgeInsetsMake(PADDING, PADDING, 0, PADDING);
    } else {
        return UIEdgeInsetsMake(PADDING, PADDING, 0, PADDING);//分别为上、左、下、右
    }
    
}
#pragma mark -------------  UISearchDelegate  -----------------
//搜索按钮点击的回调
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    NSLog(@"%@",searchBar.text);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
