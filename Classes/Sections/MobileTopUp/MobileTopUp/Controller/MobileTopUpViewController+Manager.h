//
//  MobileTopUpViewController+Manager.h
//  JDMobile
//
//  Created by heweihua on 16/4/27.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTopUpViewController.h"

@class BillEntity;
@interface MobileTopUpViewController (Manager)

// 初始化默认数据
-(void) defaultInitializeData;

// 充话费充流量的button是否可点击
-(BOOL) setBillEntityWithEnabled:(BOOL)enabled;


//8. 获取手机充值banner轮播图 category:0话费 1流量
-(void) requestWithBannerPitures;

// 1. 本地没有历史记录时请求
-(void) requestData;

// 通过手机号，请求数据
-(void) requestBillList:(NSString*)phone localUserName:(NSString*)localUserName;


// 5. 根据商品，用户等信息提交订单--充值
-(void) requestWithSubmitOrder:(NSString*)tel entity:(BillEntity*)entity;

@end










