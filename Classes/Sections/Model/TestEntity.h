//
//  TestEntity.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/2.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "BaseEntity.h"



@interface TestEntity : BaseEntity

@property(nonatomic, assign) NSInteger type;
@property(nonatomic, copy  ) NSString* bgColor;      // 背景色
@property(nonatomic, copy  ) NSString* imgUrl;       // imgUrl
@property(nonatomic, copy  ) NSString* title;        // 主标题
@property(nonatomic, copy  ) NSString* titleColor;   // 主标题颜色
@property(nonatomic, copy  ) NSString* title1;       // 副标题
@property(nonatomic, copy  ) NSString* title1Color;  // 副标题颜色
@property(nonatomic, copy  ) NSString* title2;       // bottom标题
@property(nonatomic, copy  ) NSString* title2Color;  // bottom标题颜色
@property(nonatomic, copy  ) NSString* labelText;    // 标签：“立减5元”
@property(nonatomic, strong) NSMutableArray* list;    // list

@end
