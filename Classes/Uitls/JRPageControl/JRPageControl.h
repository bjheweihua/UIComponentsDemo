//
//  JRPageView.h
//  JDMobile
//
//  Created by xinyu.wu on 16/7/19.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    JRPageControlType_Circle,
    JRPageControlType_Line,
} JRPageControlType;

typedef enum : NSUInteger {
    JRPageControlSubType_Jump,
    JRPageControlSubType_Flow,
} JRPageControlSubType;

@interface JRPageControl : UIControl


/**
 * Default: JRPageControlType_Circle
 */
@property (nonatomic, assign) JRPageControlType type;
@property (nonatomic, assign) JRPageControlSubType subType;

@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSInteger currentPage;

@property(nullable, nonatomic,strong) UIColor *pageIndicatorTintColor;
@property(nullable, nonatomic,strong) UIColor *currentPageIndicatorTintColor;


/**
 *如果 type 为JRPageControlType_Circle 则代表圆点的半径
 *如果 type 为JRPageControlType_Line 则代表线的宽度
 */
@property (nonatomic, assign) CGFloat circle_W;
@property (nonatomic, assign) CGFloat circle_H;
@property (nonatomic, assign) CGFloat interval;

@property (nonatomic, assign) BOOL hidesForSinglePage;

@end
