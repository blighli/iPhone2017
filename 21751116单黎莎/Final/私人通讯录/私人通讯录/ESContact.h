//
//  ESContact.h
//  私人通讯录
//
//  Created by Edith.S on 2017/10/12.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESContact : NSObject<NSCoding>
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSString* phone;
@property (strong,nonatomic) NSString* contactTag;
@end
