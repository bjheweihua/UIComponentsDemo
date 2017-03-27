//
//  TestTableViewCell.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/2.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIBaseTableCell.h"

@class TestEntity;
@interface TestTableViewCell : UIBaseTableCell


-(void) reloadData:(TestEntity*)entity;
@end
