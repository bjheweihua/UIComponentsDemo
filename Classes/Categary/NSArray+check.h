//
//  NSArray+check.h
//  JDMobile
//
//  Created by caiwenqiang on 15/7/15.
//  Copyright (c) 2015年 jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (check)

/**
 *  防数组越界
 *
 *  @param index 索引
 *
 *  @return
 */
- (nullable ObjectType)objectAtIndexCheck:(NSInteger)index;

//COULD BE NSNULL
- (nullable ObjectType)objectAtIndexSafely:(NSInteger)index;


@end


@interface NSMutableArray<ObjectType> (check)

- (void)addObjectCheck:(nonnull ObjectType)anObject;
- (void)insertObjectCheck:(nonnull ObjectType)anObject atIndex:(NSUInteger)index;

@end
