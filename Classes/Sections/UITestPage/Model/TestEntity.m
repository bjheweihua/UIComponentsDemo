//
//  TestEntity.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/2.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "TestEntity.h"

@implementation TestEntity

-(instancetype) init {
    
    self = [super init];
    if (self) {
        
        _bgColor = @"#ffffff";
        _title = @"test";
        _list = [[NSMutableArray alloc] init];
    }
    return self;
}


@end
