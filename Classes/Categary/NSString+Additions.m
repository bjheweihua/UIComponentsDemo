//
//  NSString+Additions.m
//  JDMobile
//
//  Created by heweihua on 15/4/22.
//  Copyright (c) 2015年 jr. All rights reserved.
//

#import "NSString+Additions.h"
//#import "JRBaseCommon.h"
//#import "JRUitlsCommon.h"
//#import "NSArray+check.h"
//#import "NSMutableDictionary+Check.h"
#import "UIColor+Additions.h"
#import "UIFont+Additions.h"



@implementation NSString(Additions)



//判断是否为汉字
+ (BOOL)isChinesecharacter:(NSString *)string
{
    if (string.length == 0)
    {
        return NO;
    }
    unichar c = [string characterAtIndex:0];
    if (c >=0x4E00 && c <=0x9FA5)
    {
        return YES;//汉字
    }
    else
    {
        return NO;//英文
    }
}

//计算汉字的个数
+ (NSInteger)chineseCountOfString:(NSString *)string
{
    int chineseCount = 0;
    if (string.length == 0)
    {
        return 0;
    }
    for (int i = 0; i<string.length; i++)
    {
        unichar c = [string characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5)
        {
            chineseCount++ ;//汉字
        }
    }
    return chineseCount;
}

//计算字母的个数
+ (NSInteger)characterCountOfString:(NSString *)string
{
    int characterCount = 0;
    if (string.length == 0)
    {
        return 0;
    }
    for (int i = 0; i<string.length; i++)
    {
        unichar c = [string characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5)
        {
        }
        else
        {
            characterCount++;//英文
        }
    }
    return characterCount;
}

+(NSInteger) getStringCount:(NSString*)string
{
    int chineseCount = 0;
    int characterCount = 0;
    if (string.length == 0)
    {
        return 0;
    }
    for (int i = 0; i<string.length; i++)
    {
        unichar c = [string characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5)
        {
            chineseCount++ ;//汉字
        }
        else
        {
            characterCount++;//英文
        }
    }
    return chineseCount + characterCount/2;
}

+(NSString*) getStringCount:(NSString*)string withMax:(NSInteger)ncount
{
    int chineseCount = 0;
    int characterCount = 0;
    int nlength = 0;
    if (string.length == 0)
    {
        return 0;
    }
    for (int i = 0; i<string.length; i++)
    {
        unichar c = [string characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5)
        {
            chineseCount++ ;//汉字
        }
        else
        {
            characterCount++;//英文
        }
        if (chineseCount + characterCount/2 == ncount)
        {
            nlength = chineseCount + characterCount;
        }
    }
    if (chineseCount + characterCount/2 >= ncount)
    {
        return [string substringToIndex:nlength];
    }
    return string;
}


// main
-(CGSize) sizeForLimitWidth:(CGFloat)limitWidth font:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(limitWidth, MAXFLOAT);
    return [self sizeForSize:maxSize font:font];
}
-(CGSize) sizeForSize:(CGSize)maxSize font:(UIFont *)font
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
}


-(CGSize) sizeForLimitWidth:(CGFloat)limitWidth font:(UIFont *)font withModel:(NSLineBreakMode)model
{
    CGSize maxSize = CGSizeMake(limitWidth, MAXFLOAT);
    return [self sizeForSize:maxSize font:font withModel:model];
}
-(CGSize) sizeForSize:(CGSize)maxSize font:(UIFont *)font withModel:(NSLineBreakMode)model
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineBreakMode = model;
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraph} context:nil].size;
}


- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing{
    
    CGSize labelSize = CGSizeZero;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.lineSpacing = lineSpacing;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    labelSize = [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine |
                 NSStringDrawingUsesLineFragmentOrigin |
                 NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    
    return CGSizeMake(ceil(labelSize.width), ceil(labelSize.height));
}

-(CGSize)jr_sizeWithFont:(UIFont*)font
{
    return  [self sizeWithAttributes:@{NSFontAttributeName:font}];
}
-(CGSize)jr_sizeWithFontNum:(CGFloat)font
{
    return  [self sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
}
-(CGSize)jr_integerSizeWithFont:(UIFont *)font
{   
    CGSize size = [self jr_sizeWithFont:font];
    return CGSizeMake(ceil(size.width), ceil(size.height));
}
-(CGSize)jr_integerSizeWithAttributes:(NSDictionary *)attributes
{
    CGSize size = [self sizeWithAttributes:attributes];
    return CGSizeMake(ceil(size.width), ceil(size.height));
}



-(CGSize)catchImageSize
{
    if (!self) {
        return CGSizeZero;
    }
    
    if (![self isKindOfClass:[NSString class]]) {
        return CGSizeZero;
    }
    
    NSArray *array = [self componentsSeparatedByString:@"?"];
    if (array.count != 2) {
        return CGSizeZero;
    }
    
    NSString *sizeString = [array objectAtIndexCheck:1];
    array = [sizeString componentsSeparatedByString:@"&"];
    if (array.count != 2) {
        return CGSizeZero;
    }
    
    NSMutableString *widthString = [[NSMutableString alloc]initWithString:[array objectAtIndexCheck:0]];
    NSMutableString *heightString = [[NSMutableString alloc]initWithString:[array objectAtIndexCheck:1]];
    
    NSString *width = [widthString stringByReplacingOccurrencesOfString:@"width=" withString:@""];
    NSString *height = [heightString stringByReplacingOccurrencesOfString:@"height=" withString:@""];
    CGSize size = CGSizeMake([width floatValue], [height floatValue]);
    
    return size;
}

-(CGFloat)getImageHeightWithImageWidth:(CGFloat)width
{
    CGSize size = [self catchImageSize];
    if (size.width>0) {
        return (width/size.width)*size.height;
    }else{
        return 0;
    }
}


@end



