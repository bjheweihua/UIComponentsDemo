//
//  Common.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#ifndef Common_h
#define Common_h

// 浮点数比较
#define FCMP_E(x, y) (fabs((x) - (y)) < DBL_EPSILON) // x == y
#define FCMP_G(x, y) (((x) - (y)) > DBL_EPSILON)     // x > y
#define FCMP_L(x, y) FCMP_G((y), (x))                // x < y

#define FCMP_GE(x, y) (FCMP_G(x, y) || FCMP_E(x, y))     // x >= y
#define FCMP_LE(x, y) FCMP_GE((y), (x))                // x <= y


#define StringIsNull(string)  {if((NSNull*)string == [NSNull null]){string = nil;}}
//#define StringToNull(string)  {if([string isKindOfClass:[NSString class]] && string && [string isEqualToString:@""]){string = nil;}}
#define ThingsToNull(string)  {if((NSNull*)string == [NSNull null]){string = nil;}else if (string &&[string isKindOfClass:[NSString class]] && [string isEqualToString:@""]){string = nil;}}

#define NullToBank(string)  {if(((NSNull*)string == [NSNull null]) || !string){string = @"";}}
#define kTimerCanacl(timer) {if(timer){[timer invalidate];timer = nil;}}

typedef NS_ENUM(NSInteger, ELineType)
{
    ELineUnknow = 0,
    ETopLongLine = 1,
    ETopShortLine = 2,
    EBottomShortLine = 3,  // short
    EBottomLongLine = 4   // long
};

#define GetPointWith(x) {(x / ([[UIScreen mainScreen] scale]))}

//安全距离
#define kSafePadding (16.0)
#define kOffsetX     (16.0)

//手机号最大长度
#define kMobileNumberMaxCount (11+2)



#define JDJRWeakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#define JDJRStrongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __typeof__(x) x = __weak_##x##__; if (!x)return;\
_Pragma("clang diagnostic pop")

#define JDJRStrongifyReturn( x,y ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __typeof__(x) x = __weak_##x##__; if (!x)return y;\
_Pragma("clang diagnostic pop")


#endif /* Common_h */
