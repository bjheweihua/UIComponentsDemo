//
//  UIBaseView.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/25.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseEntity.h"

@interface UIBaseView : UIView


@property (nonatomic, strong) BaseEntity *entity;
@property (nonatomic, strong) UIButton *clickBtn;
@property (nonatomic, assign) BOOL bHighLight;//  default NO
@property (nonatomic, assign) BOOL reloadHeight;//  default NO

-(void) reloadData:(BaseEntity*)entity;
-(void) btnClick:(UIButton*)btn withEvent:(UIEvent*)event;

@end
