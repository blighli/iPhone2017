//
//  TaskListModel.h
//  TaskList
//
//  Created by 王奇 on 2017/10/24.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ListModel <NSObject>

- (NSInteger)count;
- (id)objectAtIndex:(NSInteger)index;
- (void)insertObject:(id)object AtIndex:(NSInteger)index;
- (void)removeObjectAtIndex:(NSInteger)index;

@end

@interface TaskListModel : NSObject <ListModel>

//- (instancetype)initWithArray:(NSArray *)array;
- (void)saveTaskList;
- (void)loadTaskList;

@end

