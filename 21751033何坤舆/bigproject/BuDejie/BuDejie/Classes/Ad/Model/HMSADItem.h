//
//  HMSADItem.h
//  BuDejie
//
//  Created by 何坤舆 on 2018/1/8.
//  Copyright © 2018年 何坤舆. All rights reserved.
//

#import <Foundation/Foundation.h>
/* 加载广告数据 => 拿到活时间 => 服务器 => 看接口文档 => 解析数据 =>(AFN)
 w_picurl:图片地址
 ori_curl:跳转连接
 w:图片宽
 h:图片高
 导入AFN框架:cocodpods 导入一个框架，会把这个框架依赖的所有框架都导入
 podfile：描述需要导入哪些框架
 */
@interface HMSADItem : NSObject
@property (nonatomic, strong) NSString *w_picurl;
@property (nonatomic, strong) NSString *ori_curl;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@end
