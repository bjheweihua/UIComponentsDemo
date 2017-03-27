//
//  UIBaseTableCell.h
//  JDMobile
//
//  Created by heweihua on 15/7/7.
//  Copyright (c) 2015年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseEntity.h"

@interface UIBaseTableCell : UITableViewCell

@property (nonatomic, strong) BaseEntity *entity;
@property (nonatomic, strong) UIButton *clickBtn;
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, assign) BOOL bHighLight; //  default NO

-(void) reloadData:(BaseEntity*)entity;
-(void) btnClick:(UIButton*)btn withEvent:(UIEvent*)event;
-(void) setLineType:(ELineType)lineType;

@end
