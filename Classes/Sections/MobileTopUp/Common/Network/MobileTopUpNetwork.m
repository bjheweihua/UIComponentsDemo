//
//  MobileTopUpNetwork.m
//  JDMobile
//
//  Created by heweihua on 16/5/12.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTopUpNetwork.h"
//#import <JDPayJR/JDPMain.h>


@implementation MobileTopUpNetwork

//1. 话费充值: 根据手机号查询对应号码所属地区和运营商
//-(NetworkController*) getTelPhoneInfo{

//    UserInfoModel *userModel = [UserPreference getCurrentUserInfoModel];
//    if (!userModel.auth)
//        return nil;
//    
//    RequestSetupModel *setup = [RequestSetupModel model];
//    NSMutableDictionary *dic = setup.params;
//    [self addBasicInfor:dic withVersion:Version_200];
//    NSMutableDictionary *reqData = [[NSMutableDictionary alloc]init];
//    [self addBasicInfor:reqData withVersion:Version_200];
//    
//    NSString * reqDataString = [self UpDataEncryption:dic withReqData:reqData withUserModel:userModel];
//    setup.bIsEncrypt = YES;
//    setup.reqDataString = reqDataString;
//    setup.functionId = kMobileTopUp_TelPhoneInfo;
//    setup.tempServerUrl = HTTPS_JRMSERVER_ONLINE;
//    setup.showDailog = NO;
//    
//    return [self startQuest_Finish:self withStep:setup];
//}


//2. 话费充值--根据运营商编码、地区编码、面值和快慢充批量获取所有可用商品信息
//-(NetworkController*) getBillList:(NSString*)telephone localUserName:(NSString*)localUserName{
//
//    if (!telephone)
//        return nil;
//
//    UserInfoModel *userModel = [UserPreference getCurrentUserInfoModel];
//    if (!userModel.auth)
//        return nil;
//    
//    if (!telephone) {
//        telephone = @"";
//    }
//    
//    if (!localUserName) {
//        localUserName = @"";
//    }
//    RequestSetupModel *setup = [RequestSetupModel model];
//    NSMutableDictionary *dic = setup.params;
//    [self addBasicInfor:dic withVersion:Version_200];
//    NSMutableDictionary *reqData = [[NSMutableDictionary alloc]init];
//    [self addBasicInfor:reqData withVersion:Version_200];
//    [reqData setObjectCheck:telephone forKey:@"telephone"];
//    [reqData setObjectCheck:localUserName forKey:@"localUserName"];
//    
//    // http://xx.xx.xx/jrpmobile/baitiao/recharge/findBillList
//    NSString *reqDataString = [self UpDataEncryption:dic withReqData:reqData withUserModel:userModel];
//    setup.bIsEncrypt = YES;
//    setup.reqDataString = reqDataString;
//    setup.functionId = kMobileTopUp_BillList;
//    setup.tempServerUrl = HTTPS_JRMSERVER_ONLINE;
//    setup.showDailog = NO;
//    
//    return [self startQuest_Finish:self withStep:setup];
//}



//3. 话费充值--根据条件查询满足条件的订单列表信息--充值
//-(NetworkController*) getMobileTopUpRecord:(NSInteger)pageIndex pageSize:(NSInteger)pageSize{
//    
//    UserInfoModel *userModel = [UserPreference getCurrentUserInfoModel];
//    if (!userModel.auth)
//        return nil;
//    
//    RequestSetupModel *setup = [RequestSetupModel model];
//    NSMutableDictionary *dic = setup.params;
//    [self addBasicInfor:dic withVersion:Version_200];
//    NSMutableDictionary *reqData = [[NSMutableDictionary alloc]init];
//    [self addBasicInfor:reqData withVersion:Version_200];
//    [reqData setObjectCheck:@(pageIndex).stringValue forKey:@"pageIndex"];
//    [reqData setObjectCheck:@(pageSize).stringValue forKey:@"pageSize"];
//    
//    // http://msinner.jr.jd.com/jrpmobile/baitiao/recharge/billOrderList
//    NSString * reqDataString = [self UpDataEncryption:dic withReqData:reqData withUserModel:userModel];
//    setup.bIsEncrypt = YES;
//    setup.reqDataString = reqDataString;
//    setup.functionId = kMobileTopUp_BillOrderList;
//    setup.tempServerUrl = HTTPS_JRMSERVER_ONLINE;
//    setup.showDailog = NO;
//    
//    return [self startQuest_Finish:self withStep:setup];
//}




//4.  话费充值--根据条件查询满足条件的订单列表信息--流量
//{"clientType ":"","pageIndex":"1","pageSize":"10"}
//-(NetworkController*) getTrafficRecord:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
//    
//    UserInfoModel *userModel = [UserPreference getCurrentUserInfoModel];
//    if (!userModel.auth)
//        return nil;
//    
//    RequestSetupModel *setup = [RequestSetupModel model];
//    NSMutableDictionary *dic = setup.params;
//    [self addBasicInfor:dic withVersion:Version_200];
//    NSMutableDictionary *reqData = [[NSMutableDictionary alloc]init];
//    [self addBasicInfor:reqData withVersion:Version_200];
//    [reqData setObjectCheck:@(pageIndex).stringValue forKey:@"pageIndex"];
//    [reqData setObjectCheck:@(pageSize).stringValue forKey:@"pageSize"];
//    
//    // http://xx.xx.xx/jrpmobile/baitiao/recharge/flowOrderList
//    NSString * reqDataString = [self UpDataEncryption:dic withReqData:reqData withUserModel:userModel];
//    setup.bIsEncrypt = YES;
//    setup.reqDataString = reqDataString;
//    setup.functionId = kMobileTopUp_TrafficOrderList;
//    setup.tempServerUrl = HTTPS_JRMSERVER_ONLINE;
//    setup.showDailog = NO;
//    
//    return [self startQuest_Finish:self withStep:setup];
//}




//5. 根据商品，用户等信息提交订单--话费充值
//-(NetworkController*) submitBillOrder:(NSString*)telephone money:(NSString*)money productName:(NSString*)productName isNumberExist:(BOOL)isNumberExist{
//    
//    if (!telephone) {
//        return nil;
//    }
//    if (!money) {
//        return nil;
//    }
//
//    UserInfoModel *userModel = [UserPreference getCurrentUserInfoModel];
//    if (!userModel.auth)
//        return nil;
//    
//    NSString *jdPaySdkVersion = nil;
//    NSString *jdPayClientName = nil;
//    
//    if ([CacheModel shareCache].sdkConfig.jdPayFalg)
//    {
//        NSDictionary *jdPayDic = [[[JDPMain sharedMain] getJDPayVersion] jr_objectFromJSONString];
//        jdPaySdkVersion = [jdPayDic objectForKey:@"jdPaySdkVersion"];
//        jdPayClientName = [jdPayDic objectForKey:@"jdPayClientName"];
//    }
//
//    NullToBank(jdPaySdkVersion);
//    NullToBank(jdPayClientName);
//    
//    RequestSetupModel *setup = [RequestSetupModel model];
//    NSMutableDictionary *dic = setup.params;
//    [self addBasicInfor:dic withVersion:Version_200];
//    NSMutableDictionary *reqData = [[NSMutableDictionary alloc]init];
//    [self addBasicInfor:reqData withVersion:Version_200];
//    [reqData setObjectCheck:telephone forKey:@"telephone"];
//    [reqData setObjectCheck:money forKey:@"money"];
//    // v3.9.0
//    NSString *_productName = [NSString stringWithFormat:@"话费%@",productName];
//    [reqData setObjectCheck:_productName forKey:@"productName"];
//    [reqData setObjectCheck:@"jdfinance" forKey:@"jdPayChannel"];
//    [reqData setObjectCheck:jdPaySdkVersion forKey:@"jdPaySdkVersion"];
//    [reqData setObjectCheck:jdPayClientName forKey:@"jdPayClientName"];
//    [reqData setObjectCheck:@(isNumberExist).stringValue forKey:@"isNumberExist"]; // 3.9.2
//    
//    
//    // http://xx.xx.xx/jrpmobile/baitiao/recharge/submitBillOrder
//    NSString * reqDataString = [self UpDataEncryption:dic withReqData:reqData withUserModel:userModel];
//    setup.bIsEncrypt = YES;
//    setup.reqDataString = reqDataString;
//    setup.functionId = kMobileTopUp_SubmitBillOrder;
//    setup.tempServerUrl = HTTPS_JRMSERVER_ONLINE;
//    setup.showDailog = YES;
//    return [self startQuest_Finish:self withStep:setup];
//}



//6. 根据商品，用户等信息提交订单--流量
//-(NetworkController*) submitFlowOrder:(NSString*)telephone money:(NSString*)money skuId:(NSString*)skuId productName:(NSString*)productName isNumberExist:(BOOL)isNumberExist{
//    if (!telephone) {
//        return nil;
//    }
//    if (!money) {
//        return nil;
//    }
//    if (!skuId) {
//        skuId = @"";
//    }
//    
//    UserInfoModel *userModel = [UserPreference getCurrentUserInfoModel];
//    if (!userModel.auth)
//        return nil;
//    
//    NSString *jdPaySdkVersion = nil;
//    NSString *jdPayClientName = nil;
//    if ([CacheModel shareCache].sdkConfig.jdPayFalg)
//    {
//        NSDictionary *jdPayDic = [[[JDPMain sharedMain] getJDPayVersion] jr_objectFromJSONString];
//        jdPaySdkVersion = [jdPayDic objectForKey:@"jdPaySdkVersion"];
//        jdPayClientName = [jdPayDic objectForKey:@"jdPayClientName"];
//    }
//
//    NullToBank(jdPaySdkVersion);
//    NullToBank(jdPayClientName);
//    
//    RequestSetupModel *setup = [RequestSetupModel model];
//    NSMutableDictionary *dic = setup.params;
//    [self addBasicInfor:dic withVersion:Version_200];
//    NSMutableDictionary *reqData = [[NSMutableDictionary alloc]init];
//    [self addBasicInfor:reqData withVersion:Version_200];
//    [reqData setObjectCheck:telephone forKey:@"telephone"];
//    [reqData setObjectCheck:money forKey:@"money"];
//    [reqData setObjectCheck:skuId forKey:@"skuId"];
//    // v3.9.0
//    NSString *_productName = [NSString stringWithFormat:@"流量%@",productName];
//    [reqData setObjectCheck:_productName forKey:@"productName"]; // @"faceAmountName"
//    [reqData setObjectCheck:@"jdfinance" forKey:@"jdPayChannel"];
//    [reqData setObjectCheck:jdPaySdkVersion forKey:@"jdPaySdkVersion"];
//    [reqData setObjectCheck:jdPayClientName forKey:@"jdPayClientName"];
//    [reqData setObjectCheck:@(isNumberExist).stringValue forKey:@"isNumberExist"]; // 3.9.2
//    
//    
//    // http://xx.xx.xx/jrpmobile/baitiao/recharge/createFlowOrder
//    NSString * reqDataString = [self UpDataEncryption:dic withReqData:reqData withUserModel:userModel];
//    setup.bIsEncrypt = YES;
//    setup.reqDataString = reqDataString;
//    setup.functionId = kMobileTopUp_SubmitFlowOrder;
//    setup.tempServerUrl = HTTPS_JRMSERVER_ONLINE;
//    setup.showDailog = YES;
//    
//    return [self startQuest_Finish:self withStep:setup];
//}


//7. 流量充值--根据运营商编码、地区编码、面值和快慢充批量获取所有可用商品信息
//-(NetworkController*) getFlowList:(NSString*)telephone localUserName:(NSString*)localUserName{
//    UserInfoModel *userModel = [UserPreference getCurrentUserInfoModel];
//    if (!userModel.auth)
//        return nil;
//    
//    if (!telephone) {
//        telephone = @"";
//    }
//    
//    if (!localUserName) {
//        localUserName = @"";
//    }
//    RequestSetupModel *setup = [RequestSetupModel model];
//    NSMutableDictionary *dic = setup.params;
//    [self addBasicInfor:dic withVersion:Version_200];
//    NSMutableDictionary *reqData = [[NSMutableDictionary alloc]init];
//    [self addBasicInfor:reqData withVersion:Version_200];
//    [reqData setObjectCheck:telephone forKey:@"telephone"];
//    [reqData setObjectCheck:localUserName forKey:@"localUserName"];
//    
//    
//    // http://xx.xx.xx/jrpmobile/baitiao/recharge/findLiuLiangInfos
//    NSString * reqDataString = [self UpDataEncryption:dic withReqData:reqData withUserModel:userModel];
//    setup.bIsEncrypt = YES;
//    setup.reqDataString = reqDataString;
//    setup.functionId = kMobileTopUp_TrafficList;
//    setup.tempServerUrl = HTTPS_JRMSERVER_ONLINE;
//    setup.showDailog = NO;
//    
//    return [self startQuest_Finish:self withStep:setup];
//}


//8. 获取手机充值banner轮播图 category:0话费 1流量
//-(NetworkController*) getMobileTopUpBannerPictures:(NSInteger)category {
//    UserInfoModel *userModel = [UserPreference getCurrentUserInfoModel];
//    if (!userModel.auth)
//        return nil;
//    
//    RequestSetupModel *setup = [RequestSetupModel model];
//    NSMutableDictionary *dic = setup.params;
//    [self addBasicInfor:dic withVersion:Version_200];
//    NSMutableDictionary *reqData = [[NSMutableDictionary alloc]init];
//    [self addBasicInfor:reqData withVersion:Version_200];
//    [reqData setObjectCheck:@(category).stringValue forKey:@"category"];
//    
//    
//    // http://xx.xx.xx/jrpmobile/baitiao/recharge/chartList
//    NSString * reqDataString = [self UpDataEncryption:dic withReqData:reqData withUserModel:userModel];
//    setup.bIsEncrypt = YES;
//    setup.reqDataString = reqDataString;
//    setup.functionId = kMobileTopUp_BannerPictures;
//    setup.tempServerUrl = HTTPS_JRMSERVER_ONLINE;
//    setup.showDailog = NO;
//    
//    return [self startQuest_Finish:self withStep:setup];
//}



@end








