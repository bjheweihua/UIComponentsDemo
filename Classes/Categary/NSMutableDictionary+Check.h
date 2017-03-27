//
//  NSMutableDictionary+Check.h
//  JDMobile
//
//  Created by caiwenqiang on 16/5/24.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary<KeyType,ObjectType> (Check)

- (void)setObjectCheck:(nonnull ObjectType)anObject forKey:(nonnull KeyType <NSCopying>)aKey;

@end
