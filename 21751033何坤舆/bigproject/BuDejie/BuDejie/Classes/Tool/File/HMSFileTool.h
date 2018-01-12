//
//  HMSFileTool.h
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/10.
//  Copyright © 2018年 何坤舆. All rights reserved.
//  处理文件缓存

#import <Foundation/Foundation.h>

@interface HMSFileTool : NSObject

/**
 获取文件夹尺寸
 
 @param directoryPath 文件夹路径
 @param completion block
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;

/**
 删除文件夹内所有文件
completion:((void)(^)(NSInteger))completion
 @param directoryPath 文件夹路径
 */
+(void)removeDirectoryPath:(NSString *) directoryPath;
@end
