//
//  NSMutableDictionary+Check.m
//  JDMobile
//
//  Created by caiwenqiang on 16/5/24.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "NSMutableDictionary+Check.h"

@implementation NSMutableDictionary (Check)

- (void)setObjectCheck:(nonnull id)anObject forKey:(nonnull id <NSCopying>)aKey{
   
    if(!anObject || !aKey) return;
    
    [self setObject:anObject forKey:aKey];

}

@end
