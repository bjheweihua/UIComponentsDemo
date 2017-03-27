//
//  UIView+Layout.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    EOscillatoryAnimationToBigger,
    EOscillatoryAnimationToSmaller,
} EOscillatoryAnimationType;



@interface UIView (Layout)

@property (nonatomic) CGFloat minX;     // Shortcut for frame.origin.x.
@property (nonatomic) CGFloat minY;     // Shortcut for frame.origin.y
@property (nonatomic) CGFloat maxX;     // Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat maxY;     // Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;    // Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;   // Shortcut for frame.size.height.
@property (nonatomic) CGFloat midX;     // Shortcut for center.x
@property (nonatomic) CGFloat midY;     // Shortcut for center.y
@property (nonatomic) CGPoint origin;   // Shortcut for frame.origin.
@property (nonatomic) CGSize  size;     // Shortcut for frame.size.

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(EOscillatoryAnimationType)type;

@end

