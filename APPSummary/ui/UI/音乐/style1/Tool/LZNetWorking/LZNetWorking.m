//
//  LZNetWorking.m
//  LZMusicPlayerDemo
//
//  Created by 栗子 on 2017/12/20.
//  Copyright © 2017年 http://www.cnblogs.com/Lrx-lizi/.     https://github.com/lrxlizi/. All rights reserved.
//

#import "LZNetWorking.h"

@implementation LZNetWorking
/**
 get
 */
+ (void)sendGetNetWorkWithUrl:(NSString *)url parameters:(NSDictionary *)dict  successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id data = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        successBlock(data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failureBlock(error.localizedDescription);
    }];
}

/**
 post
 */
+(void)sendPostNetWorkWithUrl:(NSString *)url parameters:(NSDictionary *)dict successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id data = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        successBlock(data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error.localizedDescription);
    }];
    
}
@end
