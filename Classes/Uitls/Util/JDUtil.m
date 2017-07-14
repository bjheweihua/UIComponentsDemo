//
//  JDPayUtil.m
//  JDPay4iPhone
//
//  Created by Alex on 13-9-10.
//  Copyright (c) 2013年 jd. All rights reserved.
//

#import "JDUtil.h"
#import "RegexKitLite.h"
#import "JDUtilHeaders.h"
//#import "JRBaseCommon.h"
#import "NSArray+check.h"


NSString * isIdentification(NSString *identification)
{
    
    //身份证正则表达式(15位)
    if(identification.length == 15 && [identification isMatchedByRegex:@"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$"])
    {
        return   [identification stringByReplacingOccurrencesOfString:@"x" withString:@"X"];
    }
    //身份证正则表达式(18位)
    if(identification.length == 18 && [identification isMatchedByRegex:@"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|[xX])$"])
    {
        return   [identification stringByReplacingOccurrencesOfString:@"x" withString:@"X"];
    }
    return nil;
}

NSString *getTimeDifference(NSDate *beforeDate)
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *d = [cal components:unitFlags fromDate:beforeDate toDate:[NSDate date] options:0];
    NSInteger sec = [d hour]*3600+[d minute]*60+[d second];
    
    return [NSString stringWithFormat:@"%ld",(long)sec];
    
    
}
//
BOOL JRIsBlankString(NSString* str)
{ 
    if (nil == str) {
        return YES;
    }
    
    if ((NSNull *) str == [NSNull null]) {
        return YES;
    }
    
    if([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    
    return NO;
}

NSString *JRAssignEmptyStringIfBlank(NSString* str)
{
    NSString *tempStr = @"";
    if([str isKindOfClass:[NSNumber class]])
    {
        tempStr = [NSString stringWithFormat:@"%@",str];
        return tempStr;
    }
    
    if (JRIsBlankString(str))
    {
        return @"";
    }
    
    if ([str isEqualToString:@"<null>"])
    {
        return @"";
    }
    if ([str isEqualToString:@"(null)"])
    {
        return @"";
    }
//    if ([str isEqualToString:@"null"])
//    {
//        return @"";
//    }
    return str;
}

//账户格式校验（邮箱/手机号）
BOOL checkPhoneOrEmail(NSString *string)
{
    if ([string isMatchedByRegex:REGEX_email]) {
        return YES;
    }
    if ([string isMatchedByRegex:REGEX_mobile]) {
        return YES;
    }
    return NO;
}

// 中文
//BOOL checkchinese(NSString *string)
//{
//    if ([string isMatchedByRegex:REGEX_chinese]) {
//        return YES;
//    }
//    return NO;
//}

// username
BOOL checkusername(NSString *string)
{
    if ([string isMatchedByRegex:REGEX_username]) {
        return YES;
    }
    return NO;
}


//手机号格式化
//NSString *telephoneWithReformat(NSString *telephone)
//{
//    NSString *newTelephone = [telephone stringByReplacingOccurrencesOfRegex:@"[^0-9]" withString:@""];
//    return newTelephone;
//}




NSString *getPositiveFormat(NSString *amount)
{
    NSRange textPointRang = [amount rangeOfString:@"."];
    if (textPointRang.location == NSNotFound)
        return nil;
    NSInteger pointLen = amount.length-textPointRang.location-1;
    NSMutableString * string = [@"#,##0." mutableCopy];
    for (NSInteger i = 0; i<pointLen; ++i)
    {
//        @"#,##0.#######"
        [string appendString:@"#"];
    }
    return string;
}

NSComparisonResult valueComValue(NSString*value1,NSString*value2)
{
    NSDecimalNumber * num1 =  [NSDecimalNumber decimalNumberWithString:value1];
    NSDecimalNumber * num2 =  [NSDecimalNumber decimalNumberWithString:value2];
//    if (!num1 || [[num1 description] isEqualToString: @"NaN"])
//    {
//        return -1;
//    }
//    if (!num2 || [[num2 description] isEqualToString: @"NaN"])
//    {
//        return -1;
//    }
    return [num1 compare:num2];
}
NSString * valueAddValue(NSString*value1,NSString*value2)
{
    NSDecimalNumber * num1 =  [NSDecimalNumber decimalNumberWithString:value1];
    NSDecimalNumber * num2 =  [NSDecimalNumber decimalNumberWithString:value2];
    
    if ((!num1 || [[num1 description] isEqualToString: @"NaN"]) &&(!num2 || [[num2 description] isEqualToString: @"NaN"]))
    {
        return nil;
    }
    if (!num1 || [[num1 description] isEqualToString: @"NaN"])
    {
        return value2;
    }
    if (!num2 || [[num2 description] isEqualToString: @"NaN"])
    {
        return value1;
    }
    
    NSDecimalNumber * total = [num1 decimalNumberByAdding:num2];
    NSRange rang1 = [value1 rangeOfString:@"."];
    NSRange rang2 = [value2 rangeOfString:@"."];
    NSInteger pointLen1 = 0;
    NSInteger pointLen2 = 0;
    if (rang1.location != NSNotFound)
    {
        pointLen1 = value1.length-rang1.location-1;
    }
    if (rang2.location != NSNotFound)
    {
        pointLen2 = value2.length-rang2.location-1;
    }
    NSMutableString * totalString = [total.description mutableCopy];
    if (pointLen1 == 0 && pointLen2 == 0)
        return totalString;
    
    NSInteger valuePointLen = 0;
    NSRange totalRang = [totalString rangeOfString:@"."];
    if (totalRang.location == NSNotFound)
    {
        //给value添加小数点
        [totalString appendString:@"."];
        valuePointLen = 0;
    }
    else
    {
        valuePointLen = totalString.length-totalRang.location-1;
    }
    NSInteger needLen = MAX(pointLen1, pointLen2)- valuePointLen;
    if (needLen <= 0)
        return totalString;
    for (NSInteger i = 0; i<needLen; ++i)
    {
        [totalString appendString:@"0"];
    }
    return totalString;
}

NSString *amountFormat(NSString *amount)
{
    NSDecimalNumber * num =  [NSDecimalNumber decimalNumberWithString:amount];
    if (!num || [[num description] isEqualToString: @"NaN"])
        return amount;
    //对数字进行拆分  整数部分和小数部分
    BOOL isFuHao = YES;
    NSString * amountStr = amount;
    if ([amount rangeOfString:@"-"].location==NSNotFound)
        isFuHao = NO;
    else
    {
        isFuHao = YES;
        amountStr = [amountStr stringByReplacingOccurrencesOfString:@"-" withString:@""];

    }
    
    NSString * interString = nil;
    NSString *  formatInterString = nil;
    NSDecimalNumber * numInterString = nil;
    NSString * pointString = nil;
    
    NSArray * arr = [amountStr componentsSeparatedByString:@"."];
    if (!arr || arr.count == 0)
        return amount;
    
    interString = arr[0];
    numInterString = [NSDecimalNumber decimalNumberWithString:interString];
    
    if (arr.count>1)
        pointString = [NSString stringWithFormat:@".%@",arr[1]];
    
    if (numInterString && ![[numInterString description] isEqualToString: @"NaN"])
    {
        //对整数部分格式化输出
        NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
        //    formatter.positiveFormat = getPositiveFormat(amountStr);
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatInterString = [formatter stringFromNumber:numInterString];
    }
    if (!formatInterString)
        formatInterString = @"";
    if (isFuHao)
        formatInterString = [NSString stringWithFormat:@"-%@",formatInterString];
    
    if (pointString)
        return [NSString stringWithFormat:@"%@%@",formatInterString,pointString];
    else
        return formatInterString;
    
}
//获取当前时间
NSString *getCurrentDateWithFormat(NSString *formatterStr)
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (formatterStr == nil) {
        formatterStr = @"yyyy-MM-dd HH:mm:ss";
    }
    dateFormatter.dateFormat = formatterStr;
    NSString *str = [dateFormatter stringFromDate:[NSDate date]];
    return str;
}




// plans数组是否包含有string的数字
BOOL getStringIncludePlans(NSString *plans, NSString*string){
    
    BOOL bFlag = NO;
    NSInteger nPlan = [string integerValue];
    NSArray *array = [plans componentsSeparatedByString:@","];
    for (NSInteger i = 0; i < [array count]; ++i) {
        NSInteger temNum = [array[i] integerValue];
        if (temNum == nPlan) {
            bFlag = YES;
            break;
        }
    }
    return bFlag;
}

//CGFloat GetPointWith(CGFloat pointW) {
//
//    CGFloat scale = [[UIScreen mainScreen] scale];
//    CGFloat width = 1.0 / scale;
//    return width;
//}


//
//#pragma mark - JDPayUtils
//
NSInteger JRGetCountOfCharacter(NSString *str, const char *character)
{
    NSString *chr = [NSString stringWithUTF8String:character];
    
    NSUInteger count = 0;
    if (str != nil && chr != nil)
    {
        NSUInteger len = [str length];
        const unichar p = [chr characterAtIndex:0];
        for (int i = 0; i < len; i++)
        {
            const unichar c = [str characterAtIndex:i];
            if (c == p)
            {
                ++count;
            }
        }
    }
    
    return count;
}

NSArray *JRGetLocationsOfCharacter(NSString *str, const char *character)
{
    NSMutableArray *arr = [NSMutableArray array];
    
    NSString *chr = [NSString stringWithUTF8String:character];
    
    //    NSUInteger count = 0;
    if (str != nil && chr != nil)
    {
        NSUInteger len = [str length];
        const unichar p = [chr characterAtIndex:0];
        for (int i = 0; i < len; i++)
        {
            const unichar c = [str characterAtIndex:i];
            if (c == p)
            {
                [arr addObjectCheck:@(i)];
            }
        }
    }
    
    return arr.count == 0 ? nil : arr;
}

NSString* JRFormatAmountString(NSString *amount, NSInteger *location)
{
    NSRange range = [amount rangeOfString:@"."];
    
    NSMutableString *tempStr = [NSMutableString stringWithString:(range.length > 0 ? [amount substringToIndex:range.location] : amount)];
    
    // 插入“,”号的个数
    NSInteger number = MAX(0, (tempStr.length / 3 - (tempStr.length % 3 == 0 ? 1 : 0)));
    
    NSInteger position = (tempStr.length % 3 != 0 ? tempStr.length % 3 : 3);
    
    // 插入“,”号
    for (int i = 0; i < number; i++)
    {
        [tempStr insertString:@"," atIndex:position];
        
        if (*location > position)
        {
            (*location)++;
        }
        
        position += 4;
    }
    
    if (range.length > 0)
    {
        [tempStr appendString:[amount substringFromIndex:range.location]];
    }
    
    return tempStr;
}

/**
 *  替换字符串指定Range的字符，并返回
 *
 *  @param string    原字符串
 *  @param subString 子字符串
 *  @param range     替换范围
 *  @param character 填充字符串
 *  @param positions 字符位置
 *  @param pos       用于返回光标位置
 *g
 *  @return 新字符串
 */
NSString* JRReplaceCharacter(NSString *string, NSString *subString, NSRange range, NSString *character, NSArray *positions, NSInteger *pos)
{
    NSMutableString *text = [NSMutableString stringWithString:string];
    
    NSUInteger location = range.location;
    
    if (range.length == 0)
    {
        [text insertString:subString atIndex:range.location];
        ++location;
    }
    else
    {
        NSString *tempString = [string substringWithRange:range];
        if ([tempString isEqualToString:character])
        {
            [text deleteCharactersInRange:(NSRange){range.location - 1, range.length}];
            --location;
        }
        else
        {
            [text deleteCharactersInRange:range];
            if (range.location>0)
            {
                tempString = [string substringWithRange:(NSRange){range.location - 1, range.length}];
                if ([tempString isEqualToString:character])
                {
                    --location;
                }
            }

        }
    }

    text = [NSMutableString stringWithString:[text stringByReplacingOccurrencesOfString:character withString:@""]];
    if (positions)
    {
        for (NSNumber *number in [[positions reverseObjectEnumerator] allObjects])
        {
            if (location > [number integerValue])
            {
                --location;
            }
        }
    }
    
    *pos = location;
    
    return text;
}

JDJRUtil_t JDJRUtil =
{
    JRGetCountOfCharacter,
    JRGetLocationsOfCharacter,
    JRFormatAmountString,
    JRReplaceCharacter,
    JRAssignEmptyStringIfBlank,
    JRIsBlankString
};







