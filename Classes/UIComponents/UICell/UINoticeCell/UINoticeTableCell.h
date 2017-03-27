//
//  UINoticeTableCell.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/27.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUINoticeTableCellH (40.f)

@class UICellEntity;
@interface UINoticeTableCell : UITableViewCell<UIScrollViewDelegate>

-(void) reloadData:(UICellEntity *)entity;

@end
