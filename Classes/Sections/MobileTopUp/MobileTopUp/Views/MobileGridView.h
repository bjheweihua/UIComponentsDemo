//
//  MobileGridView.h
//  JDMobile
//
//  Created by heweihua on 16/4/19.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kOffsetX      (16.0)
#define kOffsetInnerW (10.0)
#define kGridCellW    ((kMainScreenW - kOffsetX*2 - kOffsetInnerW*2)/3.0)
#define kGridCellH    (65.f)



@class BillEntity;
@protocol MobileGridViewDelegate;
@interface MobileGridView : UIView

@property(nonatomic, strong) UIButton *contentBtn; // 背景按钮
@property(nonatomic, strong) UILabel* titleLabel;   // 主标题
@property(nonatomic, strong) UILabel* subtitleLabel;// 副标题
@property(nonatomic, strong) UILabel* titleLabelDisabled;   // 主标题
@property(nonatomic, strong) UIImageView* labelImageview;   // 角标

@property(nonatomic, weak  ) id <MobileGridViewDelegate> delegate;
-(void) reloadData:(BillEntity *)entity;
@end


@protocol MobileGridViewDelegate <NSObject>

-(void) didTouchMobileGrid:(BillEntity*) entity;

@end
