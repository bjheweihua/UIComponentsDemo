//
//  UitlsCommon.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/7/13.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UitlsCommon.h"

@implementation UitlsCommon

//2013-12-12 2:2:2  去掉后面的几点几分
+(NSString*)dateFormat:(NSString*)pFormString with:(NSTimeInterval)time
{
    time = time/1000;//1970年到现在的秒 1419955200000
    NSDate * Date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
    [inputFormat setDateFormat:pFormString]; //12-08
    NSString* dateString = [inputFormat stringFromDate:Date];
    return dateString;
}

+(NSString*)dateFormat:(NSString*)pFormString withTimeString:(NSString*)time
{
    if (!time) return nil;
    if (!pFormString) return nil;
    
    NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
    [inputFormat setDateFormat:@"yyyy.MM.dd"];
    NSDate *date = [inputFormat dateFromString:time];
    [inputFormat setDateFormat:pFormString];
    NSString* dateString = [inputFormat stringFromDate:date];
    return dateString;
}

+(NSString*)getTime
{
    NSDate * Date = [NSDate date];
    NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
    [inputFormat setDateFormat:@"yyyy-MM-dd"]; //2014-08-01
    NSString* dateString = [inputFormat stringFromDate:Date];
    return dateString;
}
+(NSString*)getTime1970
{
    NSTimeInterval time = [NSDate date].timeIntervalSince1970;
    return [NSString stringWithFormat:@"%ld",(long)time];
}
@end
