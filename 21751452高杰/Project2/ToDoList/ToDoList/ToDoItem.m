//
//  ToDoItem.m
//  ToDoList
//
//  Created by Yif-JJ on 2017/10/13.
//  Copyright © 2017年 JJ. All rights reserved.
//

#import "ToDoItem.h"
@interface ToDoItem()
@property NSDate *completionDate;
@end
@implementation ToDoItem
-(void)markAsCompleted:(BOOL)isCompleted{
    self.completed = isCompleted;
    [self setCompletionDate];
}
- (void)setCompletionDate {
    if (self.completed) {
        self.completionDate = [NSDate date];
    } else {
        self.completionDate = nil;
    }
}
@end
