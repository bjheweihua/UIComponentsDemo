//
//  MobileTrafficTopUpViewController+Manager.h
//  JDMobile
//
//  Created by heweihua on 16/5/17.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTrafficTopUpViewController.h"

@class MobileTrafficEntity;
@interface MobileTrafficTopUpViewController (Manager)

-(void) defaultInitializeData;
-(void) setTrafficEntityWithEnabled:(BOOL)enabled;

-(void) requestData;
-(void) requestWithBannerPitures;//8. 获取手机充值banner轮播图 category:0话费 1流量
-(void) requestWithSubmitOrder:(NSString*)tel entity:(MobileTrafficEntity*)entity;// 6. 流量充值(下单)

@end
