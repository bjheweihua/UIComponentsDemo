//
//  UitlsCommon.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/7/13.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UitlsCommon : NSObject

//2013-12-12 2:2:2  去掉后面的几点几分
+(NSString*)dateFormat:(NSString*)pFormString with:(NSTimeInterval)time;
+(NSString*)dateFormat:(NSString*)pFormString withTimeString:(NSString*)time;

+(NSString*)getTime;
+(NSString*)getTime1970;

@end
