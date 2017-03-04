//
//  MZRRootViewController.m
//  HelloWorld
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 mzr. All rights reserved.
//

#import "MZRRootViewController.h"
#import "CSLClearCache.h"
#import "MBProgressHUD.h"
@interface MZRRootViewController ()

@end

@implementation MZRRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

//数据请求
- (void)request:(NSString*)method url:(NSString*)urlString para:(NSDictionary*)dict {
    
    if ([method isEqualToString:@"GET"]) {
        [MZRNetRequest get:urlString para:dict complete:^(id data) {
            //请求下来的data通过参数传入parserData中进行解析使用
            [self parserData:data];
        } fail:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    else{
        [MZRNetRequest post:urlString para:dict complete:^(id data) {
            [self parserData:data];
        } fail:^(NSError *error) {
            NSLog(@"%@",error.description);
        }];
    }
//    CSLClearCache * clearCache = [[CSLClearCache alloc] init];
//    [clearCache clearCache];
}

// data为请求下来的数据
- (void)parserData:(id)data {}

- (void)showIndicatorInView:(UIView*)parentView isDisplay:(BOOL)show{
    if (!_isLoadIndicator) {//如果加载标志为假，不显示加载标志
        return;
    }
    if (show) {
        [MBProgressHUD showHUDAddedTo:parentView animated:YES];
    }
    else{
        [MBProgressHUD hideHUDForView:parentView animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    CSLClearCache * clearCache = [[CSLClearCache alloc] init];
    [clearCache clearCache];
    // Dispose of any resources that can be recreated.
}

//- (void)viewWillDisappear:(BOOL)animated {
//
//    for (UIView * view in self.view.subviews) {
//        [view removeFromSuperview];
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
