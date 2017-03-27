//
//  UIImage+Additions.m
//  JDMobile
//
//  Created by heweihua on 13-11-27.
//  Copyright (c) 2013年 jd. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

+ (UIImage *)jrImageWithColor: (UIColor *) color imageSize:(CGSize)imageSize
{
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

//根据颜色创建一个图片
+ (UIImage *)jrCreateImageWithColor:(UIColor *)color rect:(CGRect)rect
{
    //    UIGraphicsBeginImageContext(rect.size);
    // 解决锯齿问题
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
//根据颜色创建一个图片
+ (UIImage *)jrImageWithColor:(UIColor *)color
{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)jrCircleImage:(UIImage *)image withParam:(CGFloat)inset
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, YES);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(0, 0, image.size.width - 0 * 2.0f, image.size.height - 0 * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImg;
}

+ (UIImage *)jrGesturecircleImage:(UIImage *)image withParam:(CGFloat)inset
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImg;
}

+ (UIImage *) jrMorecircleImage:(UIImage *)image withParam:(CGFloat)inset
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGFloat pointX = 0;
    CGFloat pointY = 0;
    CGFloat radius;
    if (image.size.width <= image.size.height) {
        pointX = inset;
        radius = image.size.width- inset * 2.0f;
        pointY = (image.size.height - image.size.width)/2 + inset;
    }
    else
    {
        pointX = (image.size.width - image.size.height)/2 + inset;
        radius = image.size.height- inset * 2.0f;
        pointY = inset;
    }
    CGRect rect = CGRectMake(pointX, pointY, radius, radius); // heweihua
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImg;
}

- (UIImage *)jrResizedImage:(CGSize)size imageOrientation:(UIImageOrientation)imageOrientation
{
    CGSize imageSize = self.size;
    CGFloat horizontalRatio = size.width / imageSize.width;
    CGFloat verticalRatio = size.height / imageSize.height;
    CGFloat ratio = MIN(horizontalRatio, verticalRatio);
    CGSize targetSize = CGSizeMake(imageSize.width * ratio, imageSize.height * ratio);
    
	UIGraphicsBeginImageContextWithOptions(size, YES, 1.0f);
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextTranslateCTM(context, 0.0f, -size.height);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    if (imageOrientation == UIImageOrientationRight || imageOrientation == UIImageOrientationRightMirrored) {
        transform = CGAffineTransformTranslate(transform, 0.0f, size.height);
        transform = CGAffineTransformRotate(transform, -M_PI_2);
    } else if (imageOrientation == UIImageOrientationLeft || imageOrientation == UIImageOrientationLeftMirrored) {
        transform = CGAffineTransformTranslate(transform, size.width, 0.0f);
        transform = CGAffineTransformRotate(transform, M_PI_2);
    } else if (imageOrientation == UIImageOrientationDown || imageOrientation == UIImageOrientationDownMirrored) {
        transform = CGAffineTransformTranslate(transform, size.width, size.height);
        transform = CGAffineTransformRotate(transform, M_PI);
    }
    CGContextConcatCTM(context, transform);
    
	CGContextDrawImage(context, CGRectMake((size.width - targetSize.width) / 2, (size.height - targetSize.height) / 2, targetSize.width, targetSize.height), self.CGImage);
    
	UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    return resizedImage;
}

+ (UIImage *)jrReSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

+ (UIImage *)jrImageFromView:(UIView *)orgView
{
    UIGraphicsBeginImageContextWithOptions(orgView.frame.size, NO, [UIScreen mainScreen].scale);
    [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)jrCutImageFromImage:(UIImage *)image inRect:(CGRect)rect
{
    //注意，retina屏图片大小为屏幕的两倍
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return newImage;
}

//切图拉伸
+ (UIImage *)jrImageResizableWithName:(UIImage *)image
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return image;
}

- (UIImage *)jrFixOrientationRight {
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    transform = CGAffineTransformTranslate(transform, 0, self.size.width);
    transform = CGAffineTransformRotate(transform, -M_PI_2);
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.height, self.size.width,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//将scale为1的图片压缩成系统屏幕scale值得图片
+(UIImage *)jrScaleToSizeImage:(UIImage *)image
{
    
    if (!image) return nil;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize newSize = CGSizeZero;
    newSize.width = image.size.width/scale;
    newSize.height = image.size.height/scale;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage *)jrImageWidthCompRatio:(UIImage *)image Width:(CGFloat)width
{
    if (!image) return nil;
    
    //    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize newSize = CGSizeZero;
    newSize.width = width;
    newSize.height = (width/image.size.width)*image.size.height;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+(UIImage *)jrCutImageFromImage:(UIImage *)image withCenterSize:(CGSize)size
{
    if (!image) return nil;
    
    if (image.size.width< size.width && image.size.height < size.height) return image;
    
    CGImageRef imageRef = image.CGImage;
    CGFloat width = size.width * image.scale;
    CGFloat height = size.height * image.scale;
    CGFloat x = (image.size.width*2 - width)*0.5;
    CGFloat y = (image.size.height*2 - height)*0.5;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(x, y, width, height));
    UIImage *retImg = [UIImage imageWithCGImage:imagePartRef scale:image.scale orientation:UIImageOrientationUp];
    CGImageRelease(imagePartRef);
    return retImg;
    
}




@end
