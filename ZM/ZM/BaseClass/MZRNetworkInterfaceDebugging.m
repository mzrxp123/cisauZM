//
//  MZRNetworkInterfaceDebugging.m
//  ZM
//
//  Created by com.chinazmglass.www on 2017/2/24.
//  Copyright © 2017年 com.MaZengrui.www. All rights reserved.
//

#define PATH_INFORMERCIAL @"http://chanyouji.com/api/articles.json?destination_id=%zd&page=1"
#import "MZRNetworkInterfaceDebugging.h"

@interface MZRNetworkInterfaceDebugging ()
//测试用参数
@property (nonatomic, strong) NSDictionary * parameters;
@end

@implementation MZRNetworkInterfaceDebugging

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary * parameters = @{@"user":@"ZhaoMeiIOS",@"password":@"PW",@"token":@"token"};
    [self networkInterfacePostRequestURL:PATH_INFORMERCIAL para:parameters];
}

#pragma mark - Post Request Debugging
- (void)networkInterfacePostRequestURL:(NSString *)urlString para:(NSDictionary *)paradic {
    [self request:@"POST" url:urlString para:paradic];
}
#pragma mark - Get Request Debugging
- (void)networkInterfaceGetRequestURL:(NSString *)urlString para:(NSDictionary *)paradic {
    [self request:@"GET" url:urlString para:paradic];
}

//- (void)parserData:(id)data {
//    NSLog(@"%@", data);
//}

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
