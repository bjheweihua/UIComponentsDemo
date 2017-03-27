//
//  UIBigGridCollectionCell.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIBaseCollectionViewCell.h"



#define kUIBigGridView_W ((kMainScreenW - 42.f)/2.f)
#define kUIBigGridView_H (kUIBigGridView_W + 91.0)

@class UIElementEntity;
@interface UIBigGridCollectionCell : UIBaseCollectionViewCell

@property(nonatomic, strong) UIImageView* imgView; // icon
@property(nonatomic, strong) UILabel* titleLabel;   // 主标题
@property(nonatomic, strong) UILabel *subTitleLabel;

-(void) reloadData:(UIElementEntity *)entity;

@end
