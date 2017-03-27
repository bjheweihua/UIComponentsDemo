//
//  UIGridView.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIBaseCollectionViewCell.h"


#define kIousGridIconW ((kMainScreenW - 20.f)/4.f)

@class JRBubbleView;
@class UIElementEntity;
@interface UIGridCollectionCell : UIBaseCollectionViewCell

@property(nonatomic, strong) UIImageView* imgView; // icon
@property(nonatomic, strong) JRBubbleView* bubbleView;
@property(nonatomic, strong) UILabel* titleLabel;   // 主标题

-(void) reloadData:(UIElementEntity *)entity;

@end
