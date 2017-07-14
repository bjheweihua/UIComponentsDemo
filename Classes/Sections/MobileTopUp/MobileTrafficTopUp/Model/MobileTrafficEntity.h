//
//  MobileTrafficEntity.h
//  JDMobile
//
//  Created by heweihua on 16/4/29.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "BaseEntity.h"

/*
{
    "issuccess": 1,
    "operatorName": "电信",
    "areaName": "北京",
    "contentList": [
                    {
                        "tabTitle": "全国通用",
                        "tips": "全国通用即时生效支持2G/3G/4G",
                        "list": [
                                 {
                                     "skuId": 10262857399,
                                     "skuName": "北京电信手机流量充值 5M流量套餐",
                                     "mutCode": 2,
                                     "areaCode": 1,
                                     "faceAmount": 5,
                                     "areaUsed": 0,
                                     "validDate": "当月有效",
                                     "effectDate": "",
                                     "availableNum": 99,
                                     "availableCard": "",
                                     "salePrice": "0.95",
                                     "label":"惠" --- new
                                 }
                                 ]
                    }, 
                    {
                        "tabTitle": "省内通用", 
                        "tips": "", 
                        "list": [ ]
                    }
                    ], 
    "phoneOperator": "充值号码(北京电信)", 
    "error_msg": "", 
    "isBind": false
}*/

@interface MobileTrafficEntity : BaseEntity

//"skuId": 10262857399,
//"skuName": "北京电信手机流量充值 5M流量套餐",
//"mutCode": 2,
//"areaCode": 1,
//"faceAmount": 5,
//"areaUsed": 0,
//"validDate": "当月有效",
//"effectDate": "",
//"availableNum": 99,
//"availableCard": "",
//"salePrice": "0.95"

// 原始字段
@property(nonatomic, copy  ) NSString* skuId;   // 10262857399
@property(nonatomic, copy  ) NSString* skuName; // 送5M赠送于1天内到账
@property(nonatomic, copy  ) NSString* faceAmount; // 5(M)
@property(nonatomic, copy  ) NSString* salePrice;  // 47.50(元)
@property(nonatomic, copy  ) NSString* faceAmountName;
@property(nonatomic, copy  ) NSString* salePriceName;
@property(nonatomic, copy  ) NSString* desc;
@property(nonatomic, assign) NSInteger discount; // 角标文案：0:无 1：惠 v3.9.6 

// 新增字段
//@property(nonatomic, copy  ) NSString* trafficSize; // 5M
//@property(nonatomic, copy  ) NSString* jdPrice;     // 47.50元
@property(nonatomic, assign) BOOL enabled;
-(instancetype) initWithDict:(NSDictionary*)dict;
@end




@interface TrafficSectionEntity : BaseEntity

@property(nonatomic, assign) BOOL bshow;
@property(nonatomic, copy  ) NSString* tips;      // 全国通用，立即生效
@property(nonatomic, copy  ) NSString* tabTitle;  // 全国可用
@property(nonatomic, strong  ) NSMutableArray* list;// MobileTrafficEntity

-(instancetype) initWithDict:(NSDictionary*)dict;
@end



