//
//  UIPageControlView.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPageControlView : UIView

- (void)setItemCount:(CGFloat)count;
- (void)setIndicatorX:(CGFloat)offsetX;
- (void)isScrolling:(BOOL)isScrollling;

@end



