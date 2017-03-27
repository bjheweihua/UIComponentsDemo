//
//  UIHorizontalTableCell.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/28.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UICellEntity;
@interface UIHorizontalTableCell : UITableViewCell

-(void)reloadData:(UICellEntity *)entity;
@end
