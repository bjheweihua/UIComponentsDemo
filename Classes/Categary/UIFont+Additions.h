//
//  UIFont+Additions.h
//  JDMobile
//
//  Created by heweihua on 15-1-21.
//  Copyright (c) 2015年 wangxiugang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    KFontWeightUltraLight,
    KFontWeightThin,
    KFontWeightLight,
    KFontWeightRegular,
    KFontWeightMedium,
    KFontWeightSemibold,
    KFontWeightBold,
    KFontWeightHeavy,
    KFontWeightBlack
} KFontWeight;



//SanFrancisco  字体
typedef enum : NSUInteger {
    KSFWeightThin,
    KSFWeightLight,
    KSFWeightMedium,
    KSFWeightSemibold,
    KSFWeightRegular
} KSFWeight;


@interface UIFont (Additions)

// 方正兰亭黑 - 中文，混合
+(UIFont*)getJRDefaultChinaFont:(CGFloat)size;

// 方正兰亭纤黑 - 中文大字号
+(UIFont*)getJRMaxChinaFont:(CGFloat)size;

+(UIFont*)getJRThinFont:(CGFloat)size;
+(UIFont*)getJRLightFont:(CGFloat)size; // 数字默认
+(UIFont*)getJRSanFrancisco_ThinFont:(CGFloat)size;
+(UIFont*)getJRSanFrancisco_LightFont:(CGFloat)size;

// 系统Light字体: PingFangSC-Light
+(UIFont *)getSystemFont:(CGFloat)font Weight:(KFontWeight)weight;

//SanFrancisco 字体  四种类型
+(UIFont *)getSanFranciscoFont:(CGFloat)font Weight:(KSFWeight)weight;



@end
