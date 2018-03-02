//
//  AFNetConnect.h
//  CooperateHappily
//
//  Created by 余盛褚 on 16/7/19.
//  Copyright © 2016年 sands.yu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AFNetRequestResultBlock)(bool success, id result);

@interface AFNetConnect : NSObject

@property (nonatomic, strong) NSArray *userCookies;
@property (nonatomic, strong, readonly) NSHTTPCookie *userCookie;

+ (AFNetConnect *)connect;

/**
 *  AFNet GET
 *
 *  @param method 方法名
 *  @param params 请求参数
 *  @param result 请求结果
 */
- (void)AFNetGet:(NSString *)method params:(NSDictionary *)params result:(AFNetRequestResultBlock)result;


/**
 *  AFNet POST
 *
 *  @param method 方法名
 *  @param params 请求参数
 *  @param result 请求结果
 */
- (void)AFNetPOST:(NSString *)method params:(NSDictionary*)params result:(AFNetRequestResultBlock)result;

@end
