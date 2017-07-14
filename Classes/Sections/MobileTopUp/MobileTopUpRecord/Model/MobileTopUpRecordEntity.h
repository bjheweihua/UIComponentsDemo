//
//  MobileTopUpRecordEntity.h
//  JDMobile
//
//  Created by heweihua on 16/4/25.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "BaseEntity.h"

@interface MobileTopUpRecordEntity : BaseEntity

//"orderDetails": [
//                 {
//                     "orderId": 18698748066,
//                     "orderStatus": 4, --ok
//                     "orderStatusName": "等待充值",--ok
//                     "areaCode": 1,
//                     "areaCodeName": "北京",
//                     "isp": 1,
//                     "ispName": "移动",
//                     "createTime": 1462773780000, --ok
//                     "phoneNum": "13552364988", --ok
//                     "skuName": "北京移动手机话费充值10元 快充", --ok
//                     "chargePrice": "10.00",--ok
//                     "chargeDetailDate": "14:03", 
//                     "chargeTitle": "5月"
//                 }]

@property(nonatomic, assign) NSInteger orderStatus; // 0：充值失败 1：充值成功 2:正在充值 4:等待充值
@property(nonatomic, copy  ) NSString* orderStatusName; // 充值状态: "等待充值" --ok
@property(nonatomic, copy  ) NSString* createTime;
@property(nonatomic, copy  ) NSString* phoneNum; // 135 5236 4988
@property(nonatomic, copy  ) NSString* skuName;  //"北京移动手机话费充值10元 快充", --ok
@property(nonatomic, copy  ) NSString* chargePrice; // 10.00 --ok
@property(nonatomic, copy  ) NSString* simpleSkuName;// 充流量5M
@property(nonatomic, copy  ) NSString* chargeTitle; //"5月"

// 新增字段
@property(nonatomic, copy  ) NSString* monthText; // 2016年5月
@property(nonatomic, copy  ) NSString* leftUpText; // 153 1142 6057 - 充话费20元
@property(nonatomic, copy  ) NSString* timeText; // 03-25 12:36
@property(nonatomic, copy  ) NSString* statusTextColor; // 充值状态color
@property(nonatomic, assign) NSInteger ntype; // 0话费 1流量

-(instancetype) initWithDict:(NSDictionary*)dict withType:(NSInteger)type;

@end


