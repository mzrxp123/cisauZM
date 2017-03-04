//
//  MZRNetRequest.m
//  HelloWorld
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 mzr. All rights reserved.
//


#import "MZRNetRequest.h"

@implementation MZRNetRequest

+ (AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    // 超时时间
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    // 请求接受类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", @"text/html;charset=utf-8", nil];
    //AFN 默认情况下就是支持 HTTPS 访问的，但是如果用 HTTPS 的方式访问未受信任的网站便会报错，解决方案:
    //修改对 SSL 的检测:
    manager.securityPolicy.validatesDomainName = NO;
    
    // 声明上传的是json格式的参数，需要和后台约定好，不然会出现后台无法获取到你上传的参数问题
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
        manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式 (从后台返回二进制数据)
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
//        manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    

    return manager;
}

+ (void) get:(NSString*)urlString para:(NSDictionary*)paras complete:(CompleteCallBack)complete fail:(FailureCallBack)failure {
    
/**********************************************************************************/
#if 0
#pragama mark ------------- IPV4 NSURLConnection --------------
    // 得到AFHTTPRequestOperationManager请求的单例
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    // 设置返回数据格式（二进制）
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 请求
    [manager GET:urlString parameters:paras success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (complete) {
            complete(responseObject);//调用block将请求数据返回
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);//将错误信息返回
        }
    }];
#endif
/***********************************************************************************/
    
#pragma mark ------------- AFNetWorking 3.0 --------------
    //得到AFHTTPRequestOperationManager请求的单例
    AFHTTPSessionManager * manager = [self manager];
    
    [manager GET:urlString parameters:paras progress:^(NSProgress * _Nonnull downloadProgress) {
        //这里可以获取目前数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (complete) {
            complete(responseObject);//调用block将请求数据返回
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
        if (failure) {
            failure(error);//将错误信息返回
        }
    }];
}

+ (void) post:(NSString*)urlString para:(NSDictionary*)paras complete:(CompleteCallBack)complete fail:(FailureCallBack)failure{

/***********************************************************************************/
#if 0
    //得到AFHTTPRequestOperationManager请求的单例
    AFHTTPRequestOperationManager * requestManager = [AFHTTPRequestOperationManager manager];
    
    //设置返回数据格式（二进制）
    requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //请求
    [requestManager POST:urlString parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject){
        if (complete) {
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * __nullable operation, NSError *error){
        if (failure) {
            failure(error);
        }
    }];
    
#endif
/***********************************************************************************/
    
#pragma mark ------------- AFNetWorking 3.0 --------------
    AFHTTPSessionManager *manager = [self manager];
    
//   NSMutableDictionary *parameters = @{@"appid":@"154125256",@"currentPage":@"1"};
    
    [manager POST:urlString parameters:paras progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (complete) {
            complete(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}







#pragma mark ---------------- AFNetworking 下载任务 ---------------------
/**
 *  AFN3.0 下载
 */
- (void)downLoad{
    
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.确定请求的URL地址
    NSURL *url = [NSURL URLWithString:@""];
    
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下下载进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //下载地址
        NSLog(@"默认下载地址:%@",targetPath);
        
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL fileURLWithPath:filePath];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //下载完成调用的方法
        NSLog(@"下载完成：");
        NSLog(@"%@--%@",response,filePath);
        
    }];
    
    //开始启动任务
    [task resume];
    
}
#pragma mark ---------------- AFNetworking 上传 ---------------------
- (void)uploadWithUser:(NSString *)userId UrlString:(NSString *)urlString upImg:(UIImage *)upImg
{
    // 创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 参数
    NSDictionary *param = @{@"user_id":userId};
    [manager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        // 把图片转换成data
        NSData *data = UIImagePNGRepresentation(upImg);
        // 拼接数据到请求体中
        [formData appendPartWithFileData:data name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}

/******************************************************************************************/
#pragma mark - 获取网络状态
- (void) AFNetworkStatus {
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
            default:
                break;
        }
        
    }] ;
}

@end
