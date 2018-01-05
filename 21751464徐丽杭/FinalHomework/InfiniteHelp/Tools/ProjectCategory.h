//
//  ProjectCategory.h
//  CooperateHappily
//
//  Created by 余盛褚 on 15/12/20.
//  Copyright © 2015年 sands.yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface ProjectCategory : NSObject

@end

@interface CALayer (xibConfiguration)

@property (nonatomic,assign) UIColor* borderUIColor;

@end

@interface UIView (AdjustPosition)

/**
 * 设置当前视图的顶部坐标为 top
 */
- (void)setTop:(CGFloat)top;

/**
 * 设置当前视图的左侧坐标为 left
 */
- (void)setLeft:(CGFloat)left;

@end


@interface NSString (HPDString)
/**
 *  wipe out commas from a string
 *
 *  @return a string with no commas
 */
- (NSString *)removeCommas;

/**
 *  check whether match the regex format
 *
 *  @param regex regex string
 *
 *  @return YES if match
 */
- (BOOL)checkMatchRegex:(NSString *)regex;

/**
 *  check a string whether match the monery format(two decimal places or no)
 *
 *  @return YES if a monery format
 */
- (BOOL)isMoneyFormmat;

/**
 *  check a string whether match the email format
 *
 *  @return YES if a email format
 */
- (BOOL)isEmailFormat;

/**
 *  check a string whether match the phone number format
 *
 *  @return YES if a phone number format
 */
- (BOOL)isPhoneNumberFormat;

/**
 *  check a string whether match the id card format
 *
 *  @return YES if a id card format
 */
- (BOOL)isIDCardFormart;

/**
 * check a string containt a substring
 *
 * @return YES Or No
 */


@end
