//
//  UIGridTableCell.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//


/*
 type = 102
 */
#import <UIKit/UIKit.h>


#define kGridIconCellH (89.f)

@class UICellEntity;
@interface UIGridTableCell : UITableViewCell

-(void) reloadData:(UICellEntity *)entity;
@end
