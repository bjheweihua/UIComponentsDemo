//
//  UIImage+Additions.h
//  JDMobile
//
//  Created by heweihua on 13-11-27.
//  Copyright (c) 2013年 jd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

+ (UIImage *)jrImageWithColor:(UIColor *)color imageSize:(CGSize)imageSize;
+ (UIImage *)jrCreateImageWithColor:(UIColor *)color rect:(CGRect)rect;
+ (UIImage *)jrImageWithColor:(UIColor *)color;

//将图片裁剪成圆形
+ (UIImage *)jrCircleImage:(UIImage *)image withParam:(CGFloat)inset;

+ (UIImage *)jrGesturecircleImage:(UIImage *)image withParam:(CGFloat)inset;

+ (UIImage *)jrMorecircleImage:(UIImage *)image withParam:(CGFloat)inset;
//将图片裁剪成指定大小
- (UIImage *)jrResizedImage:(CGSize)size imageOrientation:(UIImageOrientation)imageOrientation;

//图片缩放
+ (UIImage *)jrReSizeImage:(UIImage *)image toSize:(CGSize)reSize;

//view 转 image
+ (UIImage *)jrImageFromView:(UIView *)orgView;

//图片裁剪
+ (UIImage *)jrCutImageFromImage:(UIImage *)image inRect:(CGRect)rect;

//切图拉伸
+ (UIImage *)jrImageResizableWithName:(NSString *)imageName;

//图片向右旋转90度
- (UIImage *)jrFixOrientationRight;

//将scale为1的图片压缩成系统屏幕scale值得图片
+(UIImage *)jrScaleToSizeImage:(UIImage *)image;
//将按着新的宽度等比压缩 Compression ratio
+(UIImage *)jrImageWidthCompRatio:(UIImage *)image Width:(CGFloat)width;
//从中间截取
+(UIImage *)jrCutImageFromImage:(UIImage *)image withCenterSize:(CGSize)size;


@end
