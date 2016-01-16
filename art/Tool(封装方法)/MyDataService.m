//
//  MyDataService.m
//  WXWeibo
//
//  Created by wei.chen on 15/7/22.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MyDataService.h"
#import "AFNetworking.h"

#define BASE_URL @""

@implementation MyDataService

+ (NSURLSessionDataTask *)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSDictionary *)params
        completion:(void(^)(id result, NSError *error))block {
    

    
    //1.拼接URL
    NSString *url = [BASE_URL stringByAppendingString:urlstring];
    
    NSMutableDictionary *mParams = params.mutableCopy;
    if (mParams == nil) {
        mParams = [NSMutableDictionary dictionary];
    }
    
    //2.读取本地的token令牌
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
//    NSString *accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
//    [mParams setObject:accessToken forKey:@"access_token"];
    
    //3.创建SessionManager对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *task = nil;
    //4.判断是否是GET请求
    if ([method caseInsensitiveCompare:@"GET"] == NSOrderedSame) {
        
        //5.发送GET请求
        task = [manager GET:url parameters:mParams success:^(NSURLSessionDataTask *task, id responseObject) {
            /**
             *  null置换为nil
             */
            ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
            block(responseObject,nil);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            NSLog(@"网络请求失败：%@",error);
            block(nil,error);
        }];
        
    }
    else if ([method caseInsensitiveCompare:@"POST"] == NSOrderedSame) {
        
        
        //发送POST请求
        task = [manager POST:url parameters:mParams success:^(NSURLSessionDataTask *task, id responseObject) {
            /**
             *  null置换为nil
             */
            ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;

            block(responseObject,nil);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            NSLog(@"网络请求失败：%@",error);
            block(nil,error);
        }];
    }
    return task;
}

//上传文件
+ (NSURLSessionDataTask *)uploadURL:(NSString *)urlstring
           params:(NSDictionary *)params  //文本参数
         fileData:(NSDictionary *)data    //图片
       completion:(void(^)(id result, NSError *error))block {
    
    //1.拼接URL
    NSString *url = [BASE_URL stringByAppendingString:urlstring];
    
    NSMutableDictionary *mParams = params.mutableCopy;
    if (mParams == nil) {
        mParams = [NSMutableDictionary dictionary];
    }
    
//    //2.读取本地的token令牌
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
//    NSString *accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
//    [mParams setObject:accessToken forKey:@"access_token"];
    
    //3.创建SessionManager对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *task = [manager POST:url parameters:mParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        /**
         *  null置换为nil
         */
        ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
        [data enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
           
            [formData appendPartWithFileData:obj name:key fileName:@"img.jpg" mimeType:@"image/jpeg"];
            
        }];
        
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        /**
         *  null置换为nil
         */
        ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
            block(responseObject,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"网络请求失败：%@",error);
        block(nil,error);
    }];
    
    return task;
}


@end
