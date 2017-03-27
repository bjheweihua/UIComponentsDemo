//
//  JRBubbleView.h
//  JDMobile
//
//  Created by heweihua on 2017/1/22.
//  Copyright © 2017年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRBubbleView : UIView

-(void) setText:(NSString*)text maxWidth:(CGFloat)maxWidth;// text:赋值 maxWidth:气泡最大宽度
-(void) setTextColor:(UIColor *)textColor; // 设置字体颜色
-(void) setBackgroundColor:(UIColor *)bgColor; // 设置背景颜色
-(void) setTextFont:(UIFont *)font;

@end
