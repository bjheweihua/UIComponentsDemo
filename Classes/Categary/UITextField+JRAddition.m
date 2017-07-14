//
//  UITextField+JRAddition.m
//  JDMobile
//
//  Created by heweihua on 14-3-2.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import "UITextField+JRAddition.h"
#import "JDUtil.h"

@implementation UITextField (JRAddition)

- (NSUInteger)jrcursorPosition
{
    UITextRange *selRange = self.selectedTextRange;
    UITextPosition *selStartPos = selRange.start;
    NSInteger idx = [self offsetFromPosition:self.beginningOfDocument toPosition:selStartPos];
    
    return idx;
}

- (void)jrsetCursorPosition:(NSUInteger)position
{
    UITextPosition *start = [self positionFromPosition:[self beginningOfDocument] offset:position];
    UITextPosition *end = [self positionFromPosition:start offset:0];
    [self setSelectedTextRange:[self textRangeFromPosition:start toPosition:end]];
}

- (void)jrchangeCharactersInRange:(NSRange)range replacementString:(NSString *)string whitePositions:(NSArray *)positions
{
    
    NSInteger location = 0;
    NSString *str = JDJRUtil.JRReplaceCharacter(self.text, string, range, @" ", positions, &location);
    
    NSMutableString *text = [NSMutableString stringWithString:str];
    
//    NSMutableString *text = [NSMutableString stringWithString:self.text];
//    
//    NSUInteger location = range.location;
//    
//    if (range.length == 0)
//    {
//        [text insertString:string atIndex:range.location];
//        ++location;
//    }
//    else
//    {
//        NSString *tempString = [self.text substringWithRange:range];
//        if ([tempString isEqualToString:@" "])
//        {
//            [text deleteCharactersInRange:(NSRange){range.location - 1, range.length}];
//            --location;
//        }
//        else
//        {
//            [text deleteCharactersInRange:range];
//            
//            tempString = [self.text substringWithRange:(NSRange){range.location - 1, range.length}];
//            if ([tempString isEqualToString:@" "])
//            {
//                --location;
//            }
//        }
//    }
//    
//    text = [NSMutableString stringWithString:[text stringByReplacingOccurrencesOfString:@" " withString:@""]];
//    NSArray *reversePosition = [[positions reverseObjectEnumerator] allObjects];
//    for (NSNumber *number in reversePosition)
//    {
//        if (location > [number integerValue])
//        {
//            --location;
//        }
//    }
    
    for (NSNumber *number in positions)
    {
        NSInteger position = [number integerValue];
        if (text.length > position)
        {
            [text insertString:@" " atIndex:position];
            if (range.location == position - 1)
            {
                
            }
            else if (location == position)
            {
                if (range.length == 0)
                {
                    location += 2;
                }
            }
            else if (location > position)
            {
                ++location;
            }
        }
    }
    
    self.text = text;
    
    [self jrsetCursorPosition:location];
}

- (BOOL)jrchangeAmountsInRange:(NSRange)range replacementString:(NSString *)string maxLength:(NSUInteger)maxLength error:(NSError **)err
{
    // 插入时判断各种非法输入
    if (range.length == 0)
    {
        // “.”只能出现一次
        if ([@"." isEqualToString:string] && [self.text rangeOfString:@"."].length != 0)
        {
            if (err)
            {
                *err = [NSError errorWithDomain:@"AmountsFormatErrorDomain" code:0 userInfo:@{@"error": @"输入格式不符合规范"}];
            }
            return NO;
        }
        
        // 判断小数点后的位数
        NSRange dotRange = [self.text rangeOfString:@"."];
        if (dotRange.length > 0 && range.location > dotRange.location)
        {
            NSString *tempStr = [self.text substringFromIndex:dotRange.location + 1];
            if (tempStr.length >= 2)
            {
                if (err)
                {
                    *err = [NSError errorWithDomain:@"AmountsFormatErrorDomain" code:0 userInfo:@{@"error": @"小数点后最多两位"}];
                }
                return NO;
            }
        }
        
        // 判断金额长度
        NSString *prev = [self.text substringWithRange:(NSRange){0, dotRange.length == 0 ? self.text.length : dotRange.location}];
        if (prev && ![prev isEqualToString:@""])
        {
            prev = [prev stringByReplacingOccurrencesOfString:@"," withString:@""];
            if (prev.length >= maxLength)
            {
                return NO;
            }
        }
    }
    
    NSArray *positions = JDJRUtil.JRGetLocationsOfCharacter(self.text, ",");
    
    NSInteger location = 0;
    
    NSString *text = JDJRUtil.JRReplaceCharacter(self.text, string, range, @",", positions, (NSInteger*)&location);
    
    self.text = JDJRUtil.JRFormatAmountString(text, &location);
    
    [self jrsetCursorPosition:location];  // feng 修改bug 28/04
    
    return YES;
}

@end
