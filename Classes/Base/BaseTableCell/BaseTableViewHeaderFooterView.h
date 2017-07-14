//
//  BaseTableViewHeaderFooterView.h
//  JDMobile
//
//  Created by heweihua on 16/3/8.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kBaseTableHeaderFooterH (56.f)//(22.f)

@interface BaseTableViewHeaderFooterView : UITableViewHeaderFooterView

@property(nonatomic, strong) UIButton *contentBtn; // 背景按钮
@property(nonatomic, strong) UILabel *leftTextLabel;
@property(nonatomic, strong) UILabel *rightTextLabel; // only supported for headers in grouped style
@property(nonatomic, strong) UIView  *lineView;
@property(nonatomic, strong) UIImageView* arrowView;
-(instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
