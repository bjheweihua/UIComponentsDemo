//
//  NSArray+check.m
//  JDMobile
//
//  Created by caiwenqiang on 15/7/15.
//  Copyright (c) 2015年 jr. All rights reserved.
//

#import "NSArray+check.h"

@implementation NSArray (check)

//防止数组越界
- (nullable id)objectAtIndexCheck:(NSInteger)index{

    if (index >= [self count]) {
        return nil;
    }

    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;

}

//COULD BE NSNULL
- (nullable id)objectAtIndexSafely:(NSInteger)index
{
    
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    return value;
    
}


@end


@implementation NSMutableArray (check)


- (void)addObjectCheck:(nonnull id)anObject
{
    if (!anObject)
        return;
    [self addObject:anObject];
}
- (void)insertObjectCheck:(nonnull id)anObject atIndex:(NSUInteger)index
{
    if (!anObject)
        return;
    if (index<0 || index>self.count)
        return;
    [self insertObject:anObject atIndex:index];
}

@end
