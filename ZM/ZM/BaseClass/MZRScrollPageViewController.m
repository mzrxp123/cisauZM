//
//  MZRScrollPageViewController.m
//  HelloWorld
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 mzr. All rights reserved.
//

#import "MZRScrollPageViewController.h"
//#import "MZRTraveNotesViewController.h"
//#import "MZRTacticViewController.h"
#import "Contant.h"
//#import "MZRToolViewController.h"

@interface MZRScrollPageViewController ()

@end

@implementation MZRScrollPageViewController

- (instancetype)init {
    
    if (self = [super initWithTagViewHeight:49]) {
        
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置自定义属性
    self.tagItemSize = CGSizeMake(MZR_SCREEN_WIDTH / 3, 49);
    self.backgroundColor = [UIColor whiteColor];
    
    self.selectedIndicatorColor = getColorRGBA(126, 200, 235, 1);
    self.selectedTitleColor = getColorRGBA(126, 200, 235, 1);
    
    NSArray *titleArray = @[
                            @"游记",
                            @"攻略",
                            @"工具"
                            ];
    
    NSArray *classNames = @[
//                            [MZRTraveNotesViewController class],
//                            [MZRTacticViewController class],
//                            [MZRToolViewController class]
                            ];
    
    [self reloadDataWith:titleArray andSubViewdisplayClasses:classNames withParams:nil];
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
