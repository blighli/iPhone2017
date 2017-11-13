//
//  ToDoItem.h
//  ToDoList
//
//  Created by Yif-JJ on 2017/10/13.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject
@property NSString *itemName;
@property BOOL completed;
@property (readonly)NSDate *creationDate;

-(void)markAsCompleted;
@end
