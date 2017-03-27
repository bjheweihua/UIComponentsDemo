//
//  NSString+Additions.h
//  JDMobile
//
//  Created by heweihua on 15/4/22.
//  Copyright (c) 2015年 jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

//判断是否为汉字
+(BOOL)isChinesecharacter:(NSString *)string;

//计算汉字的个数
+(NSInteger)chineseCountOfString:(NSString *)string;

//计算字母的个数
+(NSInteger)characterCountOfString:(NSString *)string;

// 计算[字母,数字,中文]的个数, (数字、字母、标点符号等，两个字符为一个length)
+(NSInteger) getStringCount:(NSString*)string;

+(NSString*) getStringCount:(NSString*)string withMax:(NSInteger)ncount;

-(CGSize)calculateSize:(CGSize)size
                  font:(UIFont *)font
           lineSpacing:(CGFloat)lineSpacing;


//折行不带行间距
-(CGSize) sizeForLimitWidth:(CGFloat)limitWidth font:(UIFont *)font;

-(CGSize) sizeForSize:(CGSize)maxSize font:(UIFont *)font;

-(CGSize) sizeForLimitWidth:(CGFloat)limitWidth
                       font:(UIFont *)font
                  withModel:(NSLineBreakMode)model;

-(CGSize) sizeForSize:(CGSize)maxSize
                 font:(UIFont *)font
            withModel:(NSLineBreakMode)model;





-(CGSize)jr_sizeWithFont:(UIFont*)font;

-(CGSize)jr_integerSizeWithFont:(UIFont*)font;
-(CGSize)jr_sizeWithFontNum:(CGFloat)font;
-(CGSize)jr_integerSizeWithAttributes:(NSDictionary*)attributes;



//通过图片urlString获取图片的size
-(CGSize)catchImageSize;
//已知宽度，求图片的高度
-(CGFloat)getImageHeightWithImageWidth:(CGFloat)width;

@end

