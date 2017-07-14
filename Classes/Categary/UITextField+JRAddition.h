//
//  UITextField+Addition.h
//  JDMobile
//
//  Created by heweihua on 14-3-2.
//  Copyright (c) 2014年 jd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (JRAddition)

- (NSUInteger)jrcursorPosition;

- (void)jrsetCursorPosition:(NSUInteger)position;

/**
 *  修改区域内的字符，并在指定位置添加空格
 *
 *  @param range     修改区域
 *  @param string    替换字符
 *  @param positions 空格位置数组
 */
- (void)jrchangeCharactersInRange:(NSRange)range replacementString:(NSString *)string whitePositions:(NSArray *)positions;

- (BOOL)jrchangeAmountsInRange:(NSRange)range replacementString:(NSString *)string maxLength:(NSUInteger)maxLength error:(NSError **)err;

@end
