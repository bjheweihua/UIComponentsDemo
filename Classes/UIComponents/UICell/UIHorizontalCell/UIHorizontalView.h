//
//  UIHorizontalView.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/28.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIBaseView.h"
#import "UICellEntity.h"

#define kUIHorizontalView_W (145.0)
#define kUIHorizontalView_H (kUIHorizontalView_W + 21.f) // 阴影：top:5, bottom:16

@interface UIHorizontalView : UIBaseView
@property(nonatomic, strong) UIImageView* imgView;
@property(nonatomic, strong) UILabel* titleLabel;
@property(nonatomic, strong) UILabel *detailLabel;

-(void) reloadData:(UIElementEntity *)entity;
@end
