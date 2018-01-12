//
//  HMSFileTool.m
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/10.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import "HMSFileTool.h"

@implementation HMSFileTool
//自己计算SDImageCache大小
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion{
    //NSFileManager
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if(!isExist || !isDirectory){
        //抛异常
        //name异常名称
        //reason:报错原因
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入文件夹路径且存在" userInfo:nil];
        [excp raise];
    }
    //开启异步
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //指定文件路径就能获取文件
        //把所有文件的尺寸加起来
        //获取所有文件下的子路径 遍历所有文件
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        NSInteger totalSize = 0;
        for (NSString *subPath in subPaths) {
            //获取文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            //忽视.DS文件
            if([filePath containsString:@".DS"])continue;
            //去除文件夹
            BOOL isDirectory;
            BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            //获取文件属性 可能只能获取文件尺寸，不能获取文件夹尺寸
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            //default尺寸
            NSInteger fileSize = [attr fileSize];
            totalSize += fileSize;
        }
        // 计算完成回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
    });
    //计算完成回调
    

}
+ (void)removeDirectoryPath:(NSString *) directoryPath {
    //清空缓存
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if(!isExist || !isDirectory){
        //抛异常
        //name异常名称
        //reason:报错原因
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"需要传入文件夹路径且存在" userInfo:nil];
        [excp raise];
    }
    //cache文件夹下所有文件，不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    for (NSString *subPath in subPaths) {
        //拼接成完整全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        //删除路径
        [mgr removeItemAtPath:filePath error:nil];
    }
}
@end
