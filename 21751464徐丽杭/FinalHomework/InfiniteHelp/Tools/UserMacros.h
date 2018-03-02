//
//  UserMacros.h
//  CooperateHappily
//
//  Created by 余盛褚 on 15/12/18.
//  Copyright © 2015年 palmaplus. All rights reserved.
//
/*
 宏定义文件
 */
#import "AppDelegate.h"

#ifndef UserMacros_h
#define UserMacros_h


#define TopicColor [UIColor colorWithRed:152/255.0 green:37/255.0 blue:40.0/255.0 alpha:1]/// <tabbar背景颜色
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)/// <屏幕高度
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)/// <屏幕宽度
#define UIColor3b(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]/// <rgb颜色
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]/// <归档
#define NOTIFICATION_CENTER [NSNotificationCenter defaultCenter]/// <通知中心


/**判断是iPhone4 或者 iPhone4s（960*640）*/
#define biPhone4Screen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/**判断是iPhone5 或者 5s 屏幕（1136*640）*/
#define biPhone5Screen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/**判断是iPhone6 或者 6s 屏幕（1334*750）*/
#define biPhone6Screen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/**判断是iPhone6p 或者 6sp 屏幕（1242*2208）*/
#define biPhone6PScreen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define UIColor3b(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define UIColor4b(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define DefineBlueColor    [UIColor colorWithRed:28.0f/255.0f green:106.0f/255.0f blue:184.0f/255.0f alpha:1]

// RGB颜色转换（16进制->10进制）
#define UIHexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/// show hud view
#define HPDProgressShowHudViewOnSelfViewWithMessage(msg)    [[HPDProgress defaultProgressHUD] showHUDOnView:self.view message:msg]
#define HPDProgressHide                                     [[HPDProgress defaultProgressHUD] hide]


/// OMGToast
#define ShowOMGToast(msg)                                  [OMGToast showWithText:msg bottomOffset:120 duration:1.5]
#define showOMGToastRequest                                 [OMGToast showWithText:@"请求失败" bottomOffset:120 duration:1.5]

#define resetBackItemButton()                               self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
#define kShortBundleVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define kIsNetWorkReachable [[NetWorkDetectionManager defaultNetWorkDetection] isNetworkReachable]

/*
CG_INLINE CGRect CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX; rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX; rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
}
*/
#endif
