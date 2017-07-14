//
//  MobileTopUpNetwork.h
//  JDMobile
//
//  Created by heweihua on 16/5/12.
//  Copyright © 2016年 jr. All rights reserved.
//

//#import "AppManager.h"



#define kTopUpRecordCount 20

@interface MobileTopUpNetwork : NSObject

////1. 话费充值: 根据手机号查询对应号码所属地区和运营商 --- ok
//-(NetworkController*) getTelPhoneInfo;
//
////2. 话费充值--根据运营商编码、地区编码、面值和快慢充批量获取所有可用商品信息
//-(NetworkController*) getBillList:(NSString*)telephone localUserName:(NSString*)localUserName;
//
////3. 话费充值--根据条件查询满足条件的订单列表信息--充值
//-(NetworkController*) getMobileTopUpRecord:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;
//
////4. 话费充值--根据条件查询满足条件的订单列表信息--流量
//-(NetworkController*) getTrafficRecord:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;
//
////5. 根据商品，用户等信息提交订单--话费充值
//-(NetworkController*) submitBillOrder:(NSString*)telephone money:(NSString*)money productName:(NSString*)productName isNumberExist:(BOOL)isNumberExist;
//
////6. 根据商品，用户等信息提交订单--流量
//-(NetworkController*) submitFlowOrder:(NSString*)telephone money:(NSString*)money skuId:(NSString*)skuId productName:(NSString*)productName isNumberExist:(BOOL)isNumberExist;
//
////7. 流量充值--根据运营商编码、地区编码、面值和快慢充批量获取所有可用商品信息
//-(NetworkController*) getFlowList:(NSString*)telephone localUserName:(NSString*)localUserName;
//
////8. 获取手机充值banner轮播图 category:0话费 1流量
//-(NetworkController*) getMobileTopUpBannerPictures:(NSInteger)category;

@end

// @"gw/generic/bt/na/m/submitBillOrder”;
/*
{
    "phoneNum": "15311426057",
    "defautlSelectPos": 2,
    "skuParams": [
                  {
                      "facePriceName": "10元",
                      "class": "com.jd.jrmserver.pojo.recharge.BillDetailResVo",
                      "jdPrice": "9.90",
                      "jdPriceName": "售价9.90元",
                      "facePrice": "10",
                      "discount": 0
                  },
                  {
                      "facePriceName": "20元",
                      "class": "com.jd.jrmserver.pojo.recharge.BillDetailResVo",
                      "jdPrice": "19.80",
                      "jdPriceName": "售价19.80元",
                      "facePrice": "20",
                      "discount": 0
                  },
                  {
                      "facePriceName": "30元",
                      "class": "com.jd.jrmserver.pojo.recharge.BillDetailResVo",
                      "jdPrice": "29.70",
                      "jdPriceName": "售价29.70元",
                      "facePrice": "30",
                      "discount": 1
                  }
                  ],
    "flowList": [
                 {
                     "facePriceName": "选流量包",
                     "jdPrice": "",
                     "jdPriceName": "",
                     "facePrice": "",
                     "discount": 0
                 },
                 {
                     "facePriceName": "领流量",
                     "jdPrice": "",
                     "jdPriceName": "",
                     "facePrice": "",
                     "discount": 2,
                     "jumEntity":{}
                 }
                 ],
    "operatorName": "电信",
    "areaName": "北京",
    "issuccess": 1,
    "phoneNumStatus": 1,
    "phoneOperator": "(北京电信)",
    "bindInfo": "账户绑定号码",
    "error_msg": "",
    "isBind": true
}
*/



//@"gw/generic/bt/na/m/findLiuLiangInfos"
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
                                     "discount": 0 // 角标类型int 0: 无 1：惠 2:免费
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










