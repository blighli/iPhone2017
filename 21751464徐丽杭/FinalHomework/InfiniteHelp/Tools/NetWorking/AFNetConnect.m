//
//  AFNetConnect.m
//  CooperateHappily
//
//  Created by 余盛褚 on 16/7/19.
//  Copyright © 2015年 sands.yu. All rights reserved.
//

#import "AFNetConnect.h"
#import <Foundation/Foundation.h>
#import "CommonCrypto/CommonDigest.h"

@implementation AFNetConnect


#define  BaseURL  [NSString stringWithFormat:@"http://rap.taobao.org/mockjsdata/13203/girls"]

/*
 NSString *httpUrl = @";
 NSString *httpArg = @"num=10";
 */
+ (AFNetConnect *)connect
{
    return [[AFNetConnect alloc] init];
}

-(AFHTTPSessionManager*)GetAFHTTPSessionManagerObject{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return session;
}


- (void)AFNetGet:(NSString *)method params:(NSDictionary *)params result:(AFNetRequestResultBlock)result{
    
    AFHTTPSessionManager *session = [self GetAFHTTPSessionManagerObject];
    
    NSString* url = BaseURL;
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url = %@",url);
    [session GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(YES,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(NO,error);
    }];
    
}

-(void)AFNetPOST:(NSString *)method params:(NSDictionary*)params result:(AFNetRequestResultBlock)result{
    
    AFHTTPSessionManager *session = [self GetAFHTTPSessionManagerObject];
    
//    NSString* url = [NSString stringWithFormat:@"%@/%@",BaseURL,method];
    NSString* url = [NSString stringWithFormat:@"%@",BaseURL];
    
    [session POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(YES,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(NO,error);
    }];
}


@end
