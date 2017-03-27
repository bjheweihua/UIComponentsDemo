//
//  UIFont+Additions.m
//  JDMobile
//
//  Created by heweihua on 15-1-21.
//  Copyright (c) 2015年 wangxiugang. All rights reserved.
//

#import "UIFont+Additions.h"

@implementation UIFont (Additions)

// 方正兰亭黑
+(UIFont*)getJRDefaultChinaFont:(CGFloat)size
{
    return [UIFont fontWithName:@"FZLTHJW--GB1-0" size:size];
}

// 方正兰亭纤黑
+(UIFont*)getJRMaxChinaFont:(CGFloat)size
{
    return [UIFont fontWithName:@"FZLTXHKM" size:size];
}

+(UIFont*)getJRThinFont:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Thin" size:size];
}
//数字的字体
+(UIFont*)getJRLightFont:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}

//
+(UIFont*)getJRSanFrancisco_ThinFont:(CGFloat)size
{
    return [UIFont fontWithName:@"SFUIDisplay-Thin" size:size];
}
//
+(UIFont*)getJRSanFrancisco_LightFont:(CGFloat)size
{
    return [UIFont fontWithName:@"SFUIDisplay-Light" size:size];
}

+(UIFont *)getSystemFont:(CGFloat)font Weight:(KFontWeight)weight
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.2) {
        CGFloat fontWeight = [UIFont getSystemWeight:weight];
        return [UIFont systemFontOfSize:font weight:fontWeight];
    }else{
        return [UIFont systemFontOfSize:font];
    }
}

+(CGFloat)getSystemWeight:(KFontWeight)fontWeight
{
    switch (fontWeight) {
        case KFontWeightUltraLight:
            return UIFontWeightUltraLight;
            break;
        case KFontWeightThin:
            return UIFontWeightThin;
            break;
        case KFontWeightLight:
            return UIFontWeightLight;
            break;
        case KFontWeightRegular:
            return UIFontWeightRegular;
            break;
        case KFontWeightMedium:
            return UIFontWeightMedium;
            break;
        case KFontWeightSemibold:
            return UIFontWeightSemibold;
            break;
        case KFontWeightBold:
            return UIFontWeightBold;
            break;
        case KFontWeightHeavy:
            return UIFontWeightHeavy;
            break;
        case KFontWeightBlack:
            return UIFontWeightBlack;
            break;
            
        default:
            break;
    }
}



+(UIFont *)getSanFranciscoFont:(CGFloat)font Weight:(KSFWeight)weight
{
    switch (weight) {
        case KSFWeightThin:
            return [UIFont fontWithName:@"SFUIDisplay-Thin" size:font];
        case KSFWeightLight:
            return [UIFont fontWithName:@"SFUIDisplay-Light" size:font];
        case KSFWeightMedium:
            return [UIFont fontWithName:@"SFUIDisplay-Medium" size:font];
        case KSFWeightSemibold:
            return [UIFont fontWithName:@"SFUIDisplay-Semibold" size:font];
        case KSFWeightRegular:
            return [UIFont fontWithName:@"SFUIDisplay-Regular" size:font]; // heweihua
        default:
            return [UIFont systemFontOfSize:font];
            break;
    }
}



@end
