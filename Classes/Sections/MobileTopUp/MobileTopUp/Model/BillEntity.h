//
//  BillEntity.h
//  JDMobile
//
//  Created by heweihua on 16/4/25.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "BaseEntity.h"

@interface BillEntity : BaseEntity

// billType = 0，充话费
//"facePrice": 100,
//"jdPrice": 99.8,
//"facePriceName": "100.00元",
//"jdPriceName": "售价99.80元"
@property(nonatomic, copy  ) NSString* facePrice;// 500元
@property(nonatomic, copy  ) NSString* jdPrice;  // 499.50
@property(nonatomic, copy  ) NSString* facePriceName;// 500元
@property(nonatomic, copy  ) NSString* jdPriceName;  // 499.50
@property(nonatomic, assign) NSInteger billType; // 0: 充话费 1：充流量 2:手机号
@property(nonatomic, assign) NSInteger discount; // 角标类型 0: 无 1：惠 2:免费 v3.9.6 
@property(nonatomic, assign) BOOL flowjump;// bool类型：false：走跳转中心（执行jumEntity） true:本地跳转：流量充值

// billType = 2，手机号
@property(nonatomic, copy  ) NSString* phoneNum;
@property(nonatomic, copy  ) NSString* phoneOperator;
@property(nonatomic, assign) BOOL bErr; // 手机号错误

// billType = 1，充流量
@property(nonatomic, copy  ) NSString* tips;// 如：订购后月底失效

// 新增字段
@property(nonatomic, strong) NSMutableArray* billList; // 数据拆分 BillEntity
@property(nonatomic, assign) BOOL enabled;
-(instancetype) initWithDict:(NSDictionary*)dict;

@end


@interface BillSectionEntity : BaseEntity

@property(nonatomic, assign) BOOL bshow;
@property(nonatomic, copy  ) NSString* title;         // 充话费|充流量
@property(nonatomic, strong  ) NSMutableArray* billList;// 元素：BillEntity -- 话费
@property(nonatomic, strong  ) NSMutableArray* flowList;// 元素：BillEntity -- 流量

@property(nonatomic, assign) NSInteger billType;      // 0: 充话费 1：充流量 2:手机号
-(instancetype) initWithDict:(NSDictionary*)dict;

@end





