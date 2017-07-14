//
//  JDPayUtil.h
//  JDPay4iPhone
//
//  Created by Alex on 13-9-10.
//  Copyright (c) 2013年 jd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



////验证身份证有效性
FOUNDATION_EXTERN NSString * isIdentification(NSString *identification);

////计算时间差
FOUNDATION_EXTERN NSString *getTimeDifference(NSDate *beforeDate);


////账户格式校验（邮箱/手机号）
FOUNDATION_EXTERN BOOL checkPhoneOrEmail(NSString *string);

// 中文
//FOUNDATION_EXTERN BOOL checkchinese(NSString *string);
// username
FOUNDATION_EXTERN BOOL checkusername(NSString *string);

//手机号格式化(去掉所有非数字)
//FOUNDATION_EXTERN NSString *telephoneWithReformat(NSString *telephone);

//金额格式化（加逗号）
FOUNDATION_EXTERN NSString *amountFormat(NSString *amount);
FOUNDATION_EXTERN NSString * valueAddValue(NSString*value1,NSString*value2);
FOUNDATION_EXTERN NSComparisonResult valueComValue(NSString*value1,NSString*value2);

//获取当前时间
FOUNDATION_EXTERN NSString *getCurrentDateWithFormat(NSString *formatterStr);

// plans数组是否包含有string的数字
FOUNDATION_EXTERN BOOL getStringIncludePlans(NSString *plans, NSString*string);

//FOUNDATION_EXTERN CGFloat GetPointWith(CGFloat pointW);

FOUNDATION_EXTERN NSString* JRFormatAmountString(NSString *amount, NSInteger *location);
FOUNDATION_EXTERN NSInteger JRGetCountOfCharacter(NSString *str, const char *character);
FOUNDATION_EXTERN NSArray *JRGetLocationsOfCharacter(NSString *str, const char *character);
FOUNDATION_EXTERN NSString* JRReplaceCharacter(NSString *string, NSString *subString, NSRange range, NSString *character, NSArray *positions, NSInteger *pos);
FOUNDATION_EXTERN BOOL JRIsBlankString(NSString *str);
FOUNDATION_EXTERN NSString *JRAssignEmptyStringIfBlank(NSString *str);
/**
 *  JDJRUtil结构体，用于组合能用C函数方法
 */
typedef struct _JDJRUtil
{
    /**
     *  计算字符在字符串中出现的次数
     */
    NSInteger (*JRGetCountOfCharacter)(NSString *, const char *);
    
    /**
     *  获取字符在字符串中的位置数组
     */
    NSArray* (*JRGetLocationsOfCharacter)(NSString *, const char *);
    
    /**
     *  格式化金额字符串
     */
    NSString* (*JRFormatAmountString)(NSString *, NSInteger *);
    
    /**
     *  替换字符串指定Range的字符，并返回
     */
    NSString* (*JRReplaceCharacter)(NSString *, NSString *, NSRange, NSString*, NSArray *, NSInteger *);
    
    /**
     *  如果输入字符串为空, 则转化为相应的值
     *
     *  字符串为空主要是服务端返回时需要处理的类型, 如<null>等
     *  而如果是NSNumber类型, 则直接转化为字符串
     */
    NSString* (*JRAssignEmptyStringIfBlank)(NSString *);
    
    /**
     *  判断字符串是否为空白字符串
     */
    BOOL (*JRIsBlankString)(NSString *);
    
} JDJRUtil_t;

extern JDJRUtil_t JDJRUtil;





