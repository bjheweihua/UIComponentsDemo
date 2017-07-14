//
//  MobileTrafficTopUpViewController+Manager.m
//  JDMobile
//
//  Created by heweihua on 16/5/17.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTrafficTopUpViewController+Manager.h"
#import "MobileTrafficEntity.h"
#import "MobileTopUpHistoryRecordManager.h"
#import "HistoryRecordEntity.h"
#import "MobileTopUpNetwork.h"
#import "MobileTrafficTopUpFooter.h"
#import "MobileTrafficTopUpHeader.h"
#import "UIBannerEntity.h"

@implementation MobileTrafficTopUpViewController (Manager)


-(void) defaultInitializeData {
    
    [self.tableDataArr removeAllObjects];
    TrafficSectionEntity* section = [[TrafficSectionEntity alloc] init];
    [self.tableDataArr addObjectCheck:section];
    [self.tableView reloadData];
}


// 流量的button是否可点击
-(void) setTrafficEntityWithEnabled:(BOOL)enabled {
    
    for (NSInteger i = 0; i < self.tableDataArr.count; ++i) {
        
        TrafficSectionEntity* section = self.tableDataArr[i];
        for (NSInteger j = 0; j < [section.list count]; ++j) {
            
            MobileTrafficEntity* entity = section.list[j];
            entity.enabled = enabled;
        }
    }
    [self.tableView reloadData];
}



//8. 获取手机充值banner轮播图 category:0话费 1流量
-(void) requestWithBannerPitures {
    
//    @JDJRWeakify(self);
//    [[MobileTopUpNetwork sharedInstance] getMobileTopUpBannerPictures:1];
//    [[AppManager sharedInstance] receiveObject:^(id object) {
//        
//        @JDJRStrongify(self);
//        if ([object isKindOfClass:[NSDictionary class]]) {
//            
//            BOOL issuccess = [object[@"issuccess"] boolValue];
//            if (NO == issuccess){
//                return;
//            }
//            [self reloadBanner:object];
//        }
//    } withIdentifier:kMobileTopUp_BannerPictures];
    
    NSString *path = [[NSBundle mainBundle]  pathForResource:@"bannerList" ofType:@"json"];
    NSData *rdata = [[NSData alloc] initWithContentsOfFile:path];
    NSString *result = [[NSString alloc] initWithData:rdata encoding:NSUTF8StringEncoding];
    result = [result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    [self reloadBanner:dict];
}


-(void) reloadBanner:(id)object {
    
    NSString* problem_title = object[@"problem_title"];
    NSString* problem_href = object[@"problem_href"];
    NSArray* banerList = object[@"bannerList"];
    
    StringIsNull(problem_title);
    StringIsNull(problem_href);
    StringIsNull(banerList);
    _problem_href = problem_href;
    
//    // 常见问题
//    self.tableView.tableFooterView = nil;
//    if (problem_title && problem_href) {
//        
//        static NSString *footerId = @"MobileTrafficTopUpFooter";
//        MobileTrafficTopUpFooter* footer = [[MobileTrafficTopUpFooter alloc] initWithReuseIdentifier:footerId];
//        [footer reloadData:problem_title problemUrl:problem_href];
//        self.tableView.tableFooterView = footer;
//    }


    NSMutableArray* arr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [banerList count]; ++i) {
        
        UIBannerEntity* entity = [[UIBannerEntity alloc] initWithDict:banerList[i]];
        [arr addObjectCheck:entity];
    }
    
    [_headerView reloadBannerData:arr];
    self.tableView.tableHeaderView = _headerView;
    [self.tableView reloadData];
    [self.cell reloadFooterData]; // 充值记录
    
    if (problem_href && problem_title) {
        [[self getRightButton] setHidden:NO];
    }
    else{
        [[self getRightButton] setHidden:YES];
    }
}




-(void) requestData{
    
    // 7. 流量充值--根据运营商编码、地区编码、面值和快慢充批量获取所有可用商品信息
//    @JDJRWeakify(self);
//    [[MobileTopUpNetwork sharedInstance] getFlowList:_tel localUserName:_name];
//    [[AppManager sharedInstance] receiveObject:^(id object) {
//        
//        @JDJRStrongify(self);
//        if ([object isKindOfClass:[NSDictionary class]]) {
//            
//            
//            //            "issuccess": 1,
//            //            "operatorName": "电信",
//            //            "areaName": "北京",
//            //            "contentList": []
//            //            "phoneOperator": "充值号码(北京电信)",
//            //            "error_msg": "",
//            //            "isBind": false
//            
//            NSString* phoneOperator = object[@"phoneOperator"];
//            NSString* bindInfo = object[@"bindInfo"];
//            NullToBank(phoneOperator);
//            NullToBank(bindInfo);
//            
//            if(bindInfo.length > 10){
//                phoneOperator = [NSString stringWithFormat:@"%@...%@",[bindInfo substringToIndex:10],phoneOperator];
//            }
//            else{
//                phoneOperator = [NSString stringWithFormat:@"%@%@",bindInfo,phoneOperator];
//            }
//            [_headerView reloadDataWithTips:phoneOperator isErr:NO];
//            
//            BOOL issuccess = [object[@"issuccess"] boolValue];
//            if (NO == issuccess){
//                
//                // 1. 手机号错误
//                NSString* error_msg = object[@"error_msg"];
//                NullToBank(error_msg);
//                if (![error_msg isEqualToString:@""]) {
//                    [_headerView reloadDataWithTips:error_msg isErr:YES];
//                    //                    [JRMsgShow showMsg:error_msg];
//                }
//                self.tableView.tableHeaderView = _headerView;
//                [self setTrafficEntityWithEnabled:NO];
//                return;
//            }
//            // 2. 手机号正确
//            [self reloadData:object];
//        }
//    } withIdentifier:kMobileTopUp_TrafficList];
    
    
    NSString *path = [[NSBundle mainBundle]  pathForResource:@"findLiuLiangInfos" ofType:@"json"];
    NSData *rdata = [[NSData alloc] initWithContentsOfFile:path];
    NSString *result = [[NSString alloc] initWithData:rdata encoding:NSUTF8StringEncoding];
    result = [result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    
    NSString* phoneOperator = object[@"phoneOperator"];
    NSString* bindInfo = object[@"bindInfo"];
    NullToBank(phoneOperator);
    NullToBank(bindInfo);

    if(bindInfo.length > 10){
        phoneOperator = [NSString stringWithFormat:@"%@...%@",[bindInfo substringToIndex:10],phoneOperator];
    }
    else{
        phoneOperator = [NSString stringWithFormat:@"%@%@",bindInfo,phoneOperator];
    }
    [_headerView reloadDataWithTips:phoneOperator isErr:NO];
    [self reloadData:object];
}




-(void) reloadData:(NSDictionary*) object {
    
    [self.tableDataArr removeAllObjects];
    
    NSArray* contentList = object[@"contentList"];
    StringIsNull(contentList);
    for (NSInteger i = 0; i < contentList.count; ++i) {
        
        NSDictionary* subdict = contentList[i];
        TrafficSectionEntity* section = [[TrafficSectionEntity alloc] initWithDict:subdict];
        [self.tableDataArr addObjectCheck:section];
    }
    if(!contentList || [contentList count] <= 0){
        [self defaultInitializeData];
    }
    self.tableView.tableHeaderView = _headerView;
    [self.tableView reloadData];
}




/*
 {
 "issuccess": 1,
 "orderResult": {
 "rep_money": {
 "cent": 998,
 "currency": "CNY",
 "currencyCode": "CNY",
 "amount": 9.98,
 "centFactor": 100
 },
 "orderId": 19177990834
 },
 "error_msg": ""
 }*/

// 6. 流量充值 -- 下单
-(void) requestWithSubmitOrder:(NSString*)tel entity:(MobileTrafficEntity*)entity {
    
//    if (_network)
//        [_network cancel];
//    @JDJRWeakify(self);
//    _network = [[MobileTopUpNetwork sharedInstance] submitFlowOrder:tel money:entity.salePrice skuId:entity.skuId productName:entity.faceAmountName isNumberExist:NO];
//    [[AppManager sharedInstance] receiveObject:^(id object){
//        
//        @JDJRStrongify(self);
//        if ([object isKindOfClass:[NSDictionary class]]){
//            
//            // 订单是否生成
//            BOOL issuccess = [object[@"issuccess"] boolValue];
//            if (NO == issuccess){
//                
//                NSString* error_msg = object[@"error_msg"];
//                NullToBank(error_msg);
//                if ([error_msg isEqualToString:@""]) {
//                    error_msg = @"提交订单失败";
//                }
//                [JRMsgShow showMsg:error_msg];
//                return;
//            }
//            
//            NSDictionary* dict = object[@"orderResult"];
//            StringIsNull(dict);
//            
//            if (dict) {
//                
//                NSNumber* redis_switch = dict[@"redis_switch"];
//                NSNumber* orderId = dict[@"orderId"];
//                NSString* cid = dict[@"cid"];
//                NSString* rep_money = dict[@"rep_money"];
//                NSString* payParam = dict[@"payParam"];
//                NSString* appId = dict[@"appId"];
//                StringIsNull(payParam);
//                StringIsNull(redis_switch);
//                StringIsNull(orderId);
//                NullToBank(cid);
//                NullToBank(rep_money);
//                StringIsNull(appId);
//                /*
//                self.downClick = [[ClickEntity alloc]initWithData:dict[@"downgradeForward"]];
//                
//                BOOL bswitch = [redis_switch boolValue];
//                if (bswitch && payParam && appId) {
//                    
//                    [self jumptoJDPay:payParam appId:appId];
//                }
//                else{
//                    [[JRPodsPublic shareInstance]JRPublicJump:self.downClick];
//                }
//                */
//            }
//        }
//    } withIdentifier:kMobileTopUp_SubmitFlowOrder];
}

     
// 跳转到京东支付
-(void) jumptoJDPay:(NSString*)payParam appId:(NSString*)appId
{
    /*
    if (![CacheModel shareCache].sdkConfig.jdPayFalg)
    {
        [[JRPodsPublic shareInstance]JRPublicJump:self.downClick];
        return;
    }
    
    if (![CacheModel shareCache].sdkConfig.jdPayFalg)
        return;
    
    JDPOrderInfo *order = [[JDPOrderInfo alloc] init];
    order.appId = appId; // test jrapp
    order.payParam = payParam;
    
    @JDJRWeakify(self);
    [[JDPMain sharedMain] payInOrder:order completionHandler:^(NSDictionary *params) {
        
        @JDJRStrongify(self);
        NSString *payStatus = params[@"payStatus"];
        NullToBank(payStatus);
        if ([payStatus isEqualToString:JDP_PAY_SUCCESS]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:AppStore_Comment object:nil userInfo:nil];
            
            // 成功后添加历史记录
            if (!_tel || [_tel isEqualToString:@""]) {
                return;
            }
            NSString* phoneOperator = [_headerView getPhoneOperator];
            HistoryRecordEntity* entity = [[HistoryRecordEntity alloc] init];
            entity.type = 0;
            entity.mobileNumber = _tel;
            entity.status = phoneOperator;
            entity.name = _name;
            [MobileTopUpHistoryRecordManager setMobileTopUpHistoryRecord:entity];
            return;
        }
        else if ([payStatus isEqualToString:JDP_PAY_FAIL])
        {
            [[JRPodsPublic shareInstance]JRPublicJump:self.downClick];
            return;
        }
    }];
     */
}

     
@end
