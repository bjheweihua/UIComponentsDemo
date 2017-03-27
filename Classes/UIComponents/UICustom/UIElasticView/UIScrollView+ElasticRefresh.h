//
//  UIScrollView+ElasticRefresh.h
//  RefreshDemo
//
//  Created by heweihua on 16/7/11.
//  Copyright © 2016年 heweihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIElasticView.h"

@interface UIScrollView (ElasticRefresh)

@property (nonatomic, strong) UIElasticView *elasticView;
- (void)refreshHeaderWithBlock:(RefreshBlock)refreshBlock elasticH:(CGFloat)elasticH;
- (void)removeElasticViewFromSuperview;
- (void)endRefresh;

@end
