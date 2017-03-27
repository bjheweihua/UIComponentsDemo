//
//  UIScrollView+ElasticRefresh.m
//  RefreshDemo
//
//  Created by heweihua on 16/7/11.
//  Copyright © 2016年 heweihua. All rights reserved.
//

#import "UIScrollView+ElasticRefresh.h"
#import <objc/runtime.h>

static const void *ElasticViewKey = &ElasticViewKey;

@implementation UIScrollView (ElasticRefresh)

- (void)refreshHeaderWithBlock:(RefreshBlock)refreshBlock elasticH:(CGFloat)elasticH{
    if(!self.elasticView){
        UIElasticView *elasticView = [[UIElasticView alloc] initWithBindingScrollView:self elasticH:elasticH];
        elasticView.refreshBlock = refreshBlock;
        self.elasticView = elasticView;
        [self addSubview:elasticView];
    }
    
}



- (void)endRefresh {
    
    [self.elasticView endRefresh];
}



- (UIElasticView *)elasticView {
    
    return objc_getAssociatedObject(self, ElasticViewKey);
}



- (void)setElasticView:(UIElasticView *)elasticView {
    
    objc_setAssociatedObject(self, ElasticViewKey, elasticView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)removeElasticViewFromSuperview{
    
    [self.elasticView removeFromSuperview];
    self.elasticView = nil;
   
}

@end
