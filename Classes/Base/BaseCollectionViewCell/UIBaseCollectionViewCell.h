//
//  UIBaseCollectionViewCell.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/1.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseEntity.h"

@interface UIBaseCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) BaseEntity *entity;
@property (nonatomic, strong) UIButton *clickBtn;
@property (nonatomic, assign) BOOL bHighLight;//  default NO

-(void) reloadData:(BaseEntity*)entity;
-(void) btnClick:(UIButton*)btn withEvent:(UIEvent*)event;

@end
