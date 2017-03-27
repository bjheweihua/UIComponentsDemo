//
//  UITableFooterCell.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/1.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIBaseTableCell.h"

@class UICellEntity;
@interface UITableFooterCell : UIBaseTableCell

-(void)reloadData:(UICellEntity *)entity;
@end
