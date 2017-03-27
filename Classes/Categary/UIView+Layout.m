//
//  UIView+Layout.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIView+Layout.h"


@implementation UIView (Layout)

- (CGFloat)minX {
    return CGRectGetMinX(self.frame);
}

- (void)setMinX:(CGFloat)minX {
    CGRect frame = self.frame;
    frame.origin.x = minX;
    self.frame = frame;
    
}

- (CGFloat)minY {
    return CGRectGetMinY(self.frame);
}

- (void)setMinY:(CGFloat)minY {
    CGRect frame = self.frame;
    frame.origin.y = minY;
    self.frame = frame;
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxX:(CGFloat)maxX {
    CGRect frame = self.frame;
    frame.origin.x = maxX - frame.size.width;
    self.frame = frame;
}

- (CGFloat)maxY {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setMaxY:(CGFloat)maxY {
    CGRect frame = self.frame;
    frame.origin.y = maxY - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)midX {
    return self.center.x;
}

- (void)setMidX:(CGFloat)midX {
    self.center = CGPointMake(midX, self.center.y);
}

- (CGFloat)midY {
    return self.center.y;
}

- (void)setMidY:(CGFloat)midY {
    self.center = CGPointMake(self.center.x, midY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(EOscillatoryAnimationType)type{
    
    NSNumber *animationScale1 = type == EOscillatoryAnimationToBigger ? @(1.15) : @(0.5);
    NSNumber *animationScale2 = type == EOscillatoryAnimationToBigger ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}

@end
