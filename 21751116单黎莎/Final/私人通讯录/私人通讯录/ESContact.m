//
//  ESContact.m
//  私人通讯录
//
//  Created by Edith.S on 2017/10/12.
//  Copyright © 2017年 Edith.S. All rights reserved.
//

#import "ESContact.h"
//用于存储需要传递的新添加的联系人信息
@implementation ESContact

/**
 在这里说明需要进行存储的数据，并对其进行编码

 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
    }
    return self;
}
@end
