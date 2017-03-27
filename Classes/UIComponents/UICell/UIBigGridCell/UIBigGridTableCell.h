//
//  UIBigGridTableCell.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//


/*
 type = 102
 */
#import <UIKit/UIKit.h>



@class UICellEntity;
@interface UIBigGridTableCell : UITableViewCell

-(void) reloadData:(UICellEntity *)entity;
@end
