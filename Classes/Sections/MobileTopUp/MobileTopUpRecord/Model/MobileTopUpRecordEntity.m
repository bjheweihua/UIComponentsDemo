//
//  MobileTopUpRecordEntity.m
//  JDMobile
//
//  Created by heweihua on 16/4/25.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTopUpRecordEntity.h"
#import "UitlsCommon.h"

@implementation MobileTopUpRecordEntity

-(instancetype) initWithDict:(NSDictionary*)dict withType:(NSInteger)type{
    
    self = [super init];
    if (self) {

        NSNumber* orderStatus = dict[@"orderStatus"];
        NSString* orderStatusName = dict[@"orderStatusName"];
        NSString* createTime = dict[@"createTime"];
        NSString* phoneNum = dict[@"phoneNum"];
        NSString* skuName = dict[@"skuName"];
        NSString* chargePrice = dict[@"chargePrice"];
        NSString* orderStatusStyle = dict[@"orderStatusStyle"];
        NSString* simpleSkuName = dict[@"simpleSkuName"];
        NSString* chargeTitle = dict[@"chargeTitle"];
        
        StringIsNull(orderStatus);
        NullToBank(orderStatusName);
        NullToBank(createTime);
        NullToBank(phoneNum);
        NullToBank(skuName);
        NullToBank(chargePrice);
        StringIsNull(orderStatusStyle);
        NullToBank(simpleSkuName);
        NullToBank(chargeTitle);
        
        if (!orderStatusStyle) {
            orderStatusStyle = @"#999999";
        }
        
        self.orderStatus = [orderStatus integerValue];
        self.orderStatusName = orderStatusName;
        self.createTime = [NSString stringWithFormat:@"%@",createTime];
        
        
        self.phoneNum = [self getTelPhoneWithDo:phoneNum];
        self.skuName = skuName;
        _chargePrice = [NSString stringWithFormat:@"%@元",chargePrice];
        self.statusTextColor = orderStatusStyle;
        NSTimeInterval time = [self.createTime doubleValue];//1970年到现在的豪秒
        self.timeText = [UitlsCommon dateFormat:@"MM-dd HH:mm" with:time]; // 16-05 12:36
        self.simpleSkuName = simpleSkuName;
        self.chargeTitle = chargeTitle;
        /*
        NSString* month = [JRUitlsCommon dateFormat:@"YY年M月" with:time]; // 2016年5月
        NSString* currentMonth = [self getCurrentMonth:@"YY年M月"];
        if ([month isEqualToString:currentMonth]) {
            month = @"本月";
        }
         // 当前日期
         self.monthText = month;
         */
        
        self.monthText = chargeTitle;
        NSString* text;
        if (0 ==type) {
            text = @"话费";
        }
        else{
            text = @"流量";
        }
        _leftUpText = [NSString stringWithFormat:@"%@%@ - %@",text,self.simpleSkuName,self.phoneNum];
    }
    return self;
}

// @"MM年d月"
-(NSString*) getCurrentMonth:(NSString*)dateFormat {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:dateFormat];
    
    NSString *location = [dateformatter stringFromDate:date];
    return location;
}


-(NSString*) getTelPhoneWithDo:(NSString*)tel {
    

    if ([tel length]==11) {
        
        NSMutableString* string = [NSMutableString stringWithFormat:@"%@",tel];
        NSInteger index = 0;
        while (index < string.length) {
            
            if(index == 3 || index == 8){
                
                [string insertString:@" " atIndex:index];
            }
            index++;
        }
        return string;
    }
    else{
        return tel;
    }
}



@end
