//
//  MyDataService.h
//  WXWeibo
//
//  Created by wei.chen on 15/7/22.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDataService : NSObject

+ (NSURLSessionDataTask *)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSDictionary *)params
        completion:(void(^)(id result, NSError *error))block;


//上传文件
+ (NSURLSessionDataTask *)uploadURL:(NSString *)urlstring
           params:(NSDictionary *)params  //文本参数
         fileData:(NSDictionary *)data    //图片
       completion:(void(^)(id result, NSError *error))block;


@end
