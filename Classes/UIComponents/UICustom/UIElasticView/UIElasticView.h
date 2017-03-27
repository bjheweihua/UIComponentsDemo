//
//  UIElasticView.h
//  RefreshDemo
//
//  Created by heweihua on 16/7/11.
//  Copyright © 2016年 heweihua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RefreshBlock)(void);

@interface UIElasticView : UIView <CAAnimationDelegate>

@property (nonatomic, copy) RefreshBlock refreshBlock;
- (instancetype)initWithBindingScrollView:(UIScrollView *)bindingScrollView elasticH:(CGFloat)elasticH;
- (void)endRefresh;

@end
