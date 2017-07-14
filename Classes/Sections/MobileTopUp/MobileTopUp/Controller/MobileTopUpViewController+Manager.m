
//
//  MobileTopUpViewController+Manager.m
//  JDMobile
//
//  Created by heweihua on 16/4/27.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTopUpViewController+Manager.h"
#import "BillEntity.h"
#import "MobileTopUpHistoryRecordManager.h"
#import "HistoryRecordEntity.h"
#import "MobileTopUpNetwork.h"
#import "MobileNumberCell.h"
#import "UIBannerView.h"
#import "UIBannerEntity.h"


@implementation MobileTopUpViewController(Manager)

-(void) defaultInitializeData {
    
    [self.tableDataArr removeAllObjects];
    self.enabled = NO;
    // 1. 手机号
    BillEntity* entity = [[BillEntity alloc] init];
    entity.billType = 2;
    entity.height = 70;
    entity.phoneNum = @"";
    entity.phoneOperator = @"";
    
    BillSectionEntity* section0 = [[BillSectionEntity alloc] init];
    section0.billType = 2;
    section0.height = 10;
    section0.bshow = NO;
    section0.title = @"";
    [section0.billList addObjectCheck:entity];
    [self.tableDataArr addObjectCheck:section0];
    
    // 2. 充话费
    BillSectionEntity* section1 = [[BillSectionEntity alloc] init];
    section1.billType = 0;
    section1.height = 42.5f;
    section1.bshow = YES;
    section1.title = @"充话费";
    
    BillEntity* entity10 = [[BillEntity alloc] init];
    entity10.billType = 0;
    entity10.height = 75.0;
    entity10.facePriceName = @"";
    
    BillEntity* entity100 = [[BillEntity alloc] init];
    entity100.billType = 0;
    entity100.height = 75.0;
    entity100.facePriceName = @"20元";
    entity100.enabled = self.enabled;
    
    BillEntity* entity101 = [[BillEntity alloc] init];
    entity101.billType = 0;
    entity101.height = 75.0;
    entity101.facePriceName = @"30元";
    entity101.enabled = self.enabled;
    
    BillEntity* entity102 = [[BillEntity alloc] init];
    entity102.billType = 0;
    entity102.height = 75.0;
    entity102.facePriceName = @"50元";
    entity102.enabled = self.enabled;
    [entity10.billList addObjectCheck:entity100];
    [entity10.billList addObjectCheck:entity101];
    [entity10.billList addObjectCheck:entity102];
    
    
    
    BillEntity* entity11 = [[BillEntity alloc] init];
    entity11.billType = 0;
    entity11.height = 75.0;
    entity11.facePrice = @"";
    
    BillEntity* entity110 = [[BillEntity alloc] init];
    entity110.billType = 0;
    entity110.height = 75.0;
    entity110.facePriceName = @"100元";
    entity110.enabled = self.enabled;
    
    BillEntity* entity111 = [[BillEntity alloc] init];
    entity111.billType = 0;
    entity111.height = 75.0;
    entity111.facePriceName = @"200元";
    entity111.enabled = self.enabled;
    
    BillEntity* entity112 = [[BillEntity alloc] init];
    entity112.billType = 0;
    entity112.height = 75.0;
    entity112.facePriceName = @"500元";
    entity112.enabled = self.enabled;
    [entity11.billList addObjectCheck:entity110];
    [entity11.billList addObjectCheck:entity111];
    [entity11.billList addObjectCheck:entity112];
    
    [section1.billList addObjectCheck:entity10];
    [section1.billList addObjectCheck:entity11];
    [self.tableDataArr addObjectCheck:section1];
    
    // 3. 更多充值
    BillSectionEntity* section2 = [[BillSectionEntity alloc] init];
    section2.billType = 1;
    section2.height = 42.5f;
    section2.bshow = YES;
    section2.title = @"更多充值";
    
    BillEntity* entity2 = [[BillEntity alloc] init];
    entity2.billType = 1;
    entity2.height = 75.0;
    entity2.facePrice = @"";
    
    BillEntity* entity20 = [[BillEntity alloc] init];
    entity20.billType = 1;
    entity20.height = 75.0;
    entity20.flowjump = YES;
    entity20.facePriceName = @"选流量包";
    entity20.enabled = self.enabled;
    [entity2.billList addObjectCheck:entity20];
    [section2.billList addObjectCheck:entity2];
    [self.tableDataArr addObjectCheck:section2];
    [self.tableView reloadData];
}




// 充话费充流量的button是否可点击
-(BOOL) setBillEntityWithEnabled:(BOOL)enabled{
    
    if (enabled == self.enabled) {
        return NO;
    }
    self.enabled = enabled;
    for (NSInteger i = 0; i < self.tableDataArr.count; ++i) {
        
        BillSectionEntity* section = self.tableDataArr[i];
        if (section.billType != 0 && section.billType != 1)
            continue;
        
        for (NSInteger j = 0; j < [section.billList count]; ++j) {
            
            BillEntity* entity = section.billList[j];
            for (NSInteger k = 0; k < [entity.billList count]; ++ k) {
                BillEntity* cEntity = entity.billList[k];
                cEntity.enabled = enabled;
            }
        }
    }
    self.enabled = enabled;
    
    return YES;
}


//8. 获取手机充值banner轮播图 category:0话费 1流量
-(void) requestWithBannerPitures {
    
//    @JDJRWeakify(self);
//    [[MobileTopUpNetwork sharedInstance] getMobileTopUpBannerPictures:0];
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


#pragma mark - 请求主页数据+用户信息
-(void) requestData{
    
    // (1). 有充值记录：最近一条历史记录
//    NSMutableArray *arr = [MobileTopUpHistoryRecordManager getMobileTopUpHistoryRecord];
//    if(arr && [arr count] > 0){
    
    if (true) {
        
        // -------------- 手机号
//        HistoryRecordEntity* historyEntity = arr[0];
        BillEntity* entity = [[BillEntity alloc] init];
//        entity.phoneNum = historyEntity.mobileNumber;
//        entity.phoneOperator = historyEntity.phoneOperator;
        entity.phoneNum = @"15311426057";
        entity.phoneOperator = @"北京电信";
        entity.height = 70;
        
        BillSectionEntity* section = [[BillSectionEntity alloc] init];
        section.bshow = NO;
        section.title = @"";
        section.billType = 2;
        section.height = 10;
        [section.billList addObjectCheck:entity];
        // -------------- 手机号
        
        [self.tableDataArr replaceObjectAtIndex:0 withObject:section];
        [self.tableView reloadData];
        
        // bill list request
        _tel = entity.phoneNum;
        [self requestBillList:entity.phoneNum localUserName:@"雪照天山"];
    }
    else{
        
        // (2). 无充值记录：用户已激活白条，拉取白条绑定号码；用户未激活白条，拉取商城手机号。
//        @JDJRWeakify(self);
//        [[MobileTopUpNetwork sharedInstance] getTelPhoneInfo];
//        [[AppManager sharedInstance] receiveObject:^(id object) {
//            
//            @JDJRStrongify(self);
//            if ([object isKindOfClass:[NSDictionary class]]) {
//                
//                //"issuccess": 1,
//                //"operatorName": "移动",
//                //"areaName": "北京",
//                //"phoneNum": "13436355513",
//                //"phoneOperator": "北京移动",
//                //"error_msg": ""
//                BOOL issuccess = [object[@"issuccess"] boolValue];
//                if (NO == issuccess){
//                    
//                    NSString* error_msg = object[@"error_msg"];
//                    NullToBank(error_msg);
//                    if (![error_msg isEqualToString:@""]) {
//                        [JRMsgShow showMsg:error_msg];
//                    }
//                    return;
//                }
//                
//                
//                NSString* phoneNum = object[@"phoneNum"];
//                NSString* phoneOperator = object[@"phoneOperator"];
//                NullToBank(phoneNum);
//                NullToBank(phoneOperator);
//                NSRange range = [phoneOperator rangeOfString:@"("];
//                if(range.location -1 > 10){
//                    
//                    NSString* string1 = [phoneOperator substringToIndex:range.location-1];
//                    NSString* string2 = [phoneOperator substringFromIndex:range.location];
//                    phoneOperator = [NSString stringWithFormat:@"%@...%@",[string1 substringToIndex:10],string2];
//                }
//                
//                BillEntity* entity = [[BillEntity alloc] init];
//                entity.phoneNum = phoneNum;
//                entity.phoneOperator = phoneOperator;
//                entity.height = 70;
//                
//                BillSectionEntity* section = [[BillSectionEntity alloc] init];
//                section.bshow = NO;
//                section.title = @"";
//                section.billType = 2;
//                section.height = 10;
//                [section.billList addObjectCheck:entity];
//                
//                [self.tableDataArr replaceObjectAtIndex:0 withObject:section];
//                [self.tableView reloadData];
//                
//                // bill list request
//                _tel = phoneNum;
//                [self requestBillList:phoneNum localUserName:@""];
//            }
//        } withIdentifier:kMobileTopUp_TelPhoneInfo];
        return;
    }
}


-(void) reloadBanner:(id)object {
    
//"issuccess":1,
//"bannerList": [
//               {
//                   "imgUrl": "http://www.jd.com",
//                   "jumEntity": {
//                       "gobackRefresh": false
//                   }
//               },
//               {
//                   "imgUrl": "http://www.jd.com",
//                   "jumEntity": {
//                       "gobackRefresh": false
//                   }
//               }
//               ],
//"problem_title":@"常见问题",
//"problem_href":@"http://www.jd.com"
    
    NSString* problem_title = object[@"problem_title"];
    NSString* problem_href = object[@"problem_href"];
    NSArray* banerList = object[@"bannerList"];
    
    StringIsNull(problem_title);
    StringIsNull(problem_href);
    StringIsNull(banerList);
    
    _problem_href = problem_href;
    if (problem_href && problem_title) {
        [[self getRightButton] setHidden:NO];
    }
    else{
        [[self getRightButton] setHidden:YES];
    }
    
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [banerList count]; ++i) {
        
        UIBannerEntity* entity = [[UIBannerEntity alloc] initWithDict:banerList[i]];
        [arr addObjectCheck:entity];
    }
    
    if ([arr count] > 0) {
        
        UIBannerView* header = [[UIBannerView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, kMobileTopUpBannerH)];
        [header reloadData:arr];
        header.tag = 0;
        self.tableView.tableHeaderView = header;
        self.tableView.tableHeaderView.tag = 0;
    }
    else{
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 0.01)];
        self.tableView.tableHeaderView.tag = 1;
    }
    [self.tableView reloadData];
    [self reloadButtonFrame];
}


-(void) reloadButtonFrame {
    
    CGFloat pointY = CGRectGetHeight(self.tableView.frame) - 22.5 - 40 + (40 - 12)/2.f - 64;
    
    if (self.tableView.contentSize.height >= pointY) {
        pointY = self.tableView.contentSize.height;
        self.tableView.contentSize = CGSizeMake(0, pointY + 40);
    }
    [_button setFrame:CGRectMake(0, pointY, kMainScreenW, 40)];
}



-(void) requestBillList:(NSString*)phone localUserName:(NSString*)localUserName{
    
//    @JDJRWeakify(self);
//    // (2). 无充值记录：用户已激活白条，拉取白条绑定号码；用户未激活白条，拉取商城手机号。
//    [[MobileTopUpNetwork sharedInstance] getBillList:phone localUserName:localUserName];
//    [[AppManager sharedInstance] receiveObject:^(id object) {
//        
//        @JDJRStrongify(self);
//        if ([object isKindOfClass:[NSDictionary class]]) {
//            
//            BOOL issuccess = [object[@"issuccess"] boolValue];
//            if (NO == issuccess){
//                
//                // 1. 手机号
//                NSString* phoneNum = object[@"phoneNum"];
//                NSString* phoneOperator = object[@"phoneOperator"];
//                NSString* bindInfo = object[@"bindInfo"];
//                NullToBank(phoneNum);
//                NullToBank(phoneOperator);
//                NullToBank(bindInfo);
//                
//                if(bindInfo.length > 10){
//                    phoneOperator = [NSString stringWithFormat:@"%@...%@",[bindInfo substringToIndex:10],phoneOperator];
//                }
//                else{
//                    phoneOperator = [NSString stringWithFormat:@"%@%@",bindInfo,phoneOperator];
//                }
//                
//                BillEntity* entity = [[BillEntity alloc] init];
//                entity.billType = 2;
//                entity.height = 70;
//                entity.phoneNum = phoneNum;
//                entity.phoneOperator = phoneOperator;
//                
//                BillSectionEntity* section0 = [[BillSectionEntity alloc] init];
//                section0.billType = 2;
//                section0.height = 10;
//                section0.bshow = NO;
//                section0.title = @"";
//                [section0.billList addObjectCheck:entity];
//                
//                
//                NSString* error_msg = object[@"error_msg"];
//                NullToBank(error_msg);
//                if (![error_msg isEqualToString:@""]) {
//                    
//                    entity.phoneOperator = error_msg;
//                    entity.bErr = YES;
////                    [JRMsgShow showMsg:error_msg];
//                }
//                [self.tableDataArr replaceObjectAtIndex:0 withObject:section0];
//                [self setBillEntityWithEnabled:NO];
//                [self.tableView reloadData];
//                
//                // 常见问题
//                [self reloadButtonFrame];
//                return;
//            }
//
//            [self reloadData:object];
//            
//            // 常见问题
//            [self reloadButtonFrame];
//        }
//    } withIdentifier:kMobileTopUp_BillList];
    
    
    NSString *path = [[NSBundle mainBundle]  pathForResource:@"findBillList" ofType:@"json"];
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
    [self reloadBillList:dict];
    
}

-(void) reloadBillList:(NSDictionary*)object {
    
    BOOL issuccess = [object[@"issuccess"] boolValue];
    if (NO == issuccess){

        // 1. 手机号
        NSString* phoneNum = object[@"phoneNum"];
        NSString* phoneOperator = object[@"phoneOperator"];
        NSString* bindInfo = object[@"bindInfo"];
        NullToBank(phoneNum);
        NullToBank(phoneOperator);
        NullToBank(bindInfo);

        if(bindInfo.length > 10){
            phoneOperator = [NSString stringWithFormat:@"%@...%@",[bindInfo substringToIndex:10],phoneOperator];
        }
        else{
            phoneOperator = [NSString stringWithFormat:@"%@%@",bindInfo,phoneOperator];
        }

        BillEntity* entity = [[BillEntity alloc] init];
        entity.billType = 2;
        entity.height = 70;
        entity.phoneNum = phoneNum;
        entity.phoneOperator = phoneOperator;

        BillSectionEntity* section0 = [[BillSectionEntity alloc] init];
        section0.billType = 2;
        section0.height = 10;
        section0.bshow = NO;
        section0.title = @"";
        [section0.billList addObjectCheck:entity];


        NSString* error_msg = object[@"error_msg"];
        NullToBank(error_msg);
        if (![error_msg isEqualToString:@""]) {

            entity.phoneOperator = error_msg;
            entity.bErr = YES;
//                    [JRMsgShow showMsg:error_msg];
        }
        [self.tableDataArr replaceObjectAtIndex:0 withObject:section0];
        [self setBillEntityWithEnabled:NO];
        [self.tableView reloadData];

        // 常见问题
        [self reloadButtonFrame];
        return;
    }
    [self reloadData:object];
    
    // 常见问题
    [self reloadButtonFrame];
}



-(void) reloadData:(NSDictionary*)object {
    
    [self.tableDataArr removeAllObjects];
    // 1. 手机号
    self.enabled = YES;
    NSString* phoneNum = object[@"phoneNum"];
    NSString* phoneOperator = object[@"phoneOperator"];
    NSString* bindInfo = object[@"bindInfo"];
    
    NullToBank(phoneNum);
    NullToBank(phoneOperator);
    NullToBank(bindInfo);
    
    if(bindInfo.length > 10){
        phoneOperator = [NSString stringWithFormat:@"%@...%@",[bindInfo substringToIndex:10],phoneOperator];
    }
    else{
        phoneOperator = [NSString stringWithFormat:@"%@%@",bindInfo,phoneOperator];
    }
    _tel = phoneNum;
    BillEntity* entity = [[BillEntity alloc] init];
    entity.billType = 2;
    entity.height = 70;
    entity.phoneNum = phoneNum;
    entity.phoneOperator = phoneOperator;
    
    BillSectionEntity* section0 = [[BillSectionEntity alloc] init];
    section0.billType = 2;
    section0.height = 10;
    section0.bshow = NO;
    section0.title = @"";
    [section0.billList addObjectCheck:entity];
    [self.tableDataArr addObjectCheck:section0];
    
    // 2. 充话费
    BillSectionEntity* section1 = [[BillSectionEntity alloc] initWithDict:object];
    section1.billType = 0;
    section1.height = 42.5f;
    section1.bshow = YES;
    section1.title = @"充话费";
    
    if(section1.billList && [section1.billList count] > 0){
        
        [self.tableDataArr addObjectCheck:section1];
        
        // 3. 更多充值
        BillSectionEntity* section2 = [[BillSectionEntity alloc] init];
        section2.billType = 1;
        section2.height = 42.5f;
        section2.bshow = YES;
        section2.title = @"更多充值";
        
        if (section1.flowList && [section1.flowList count] >0) {
            [section2.billList addObjectsFromArray:section1.flowList];
        }
        else{
            
            BillEntity* entity2 = [[BillEntity alloc] init];
            entity2.billType = 1;
            entity2.height = 75.0;
            entity2.facePrice = @"";
            
            BillEntity* entity20 = [[BillEntity alloc] init];
            entity20.billType = 1;
            entity20.height = 75.0;
            entity20.facePriceName = @"选流量包";
            entity20.flowjump = YES;
            entity20.enabled = YES;
            [entity2.billList addObjectCheck:entity20];
            [section2.billList addObjectCheck:entity2];
        }
        [self.tableDataArr addObjectCheck:section2];
    }
    else{
        
        self.enabled = NO;
        // 加载本地初始化数据
        // 2. 充话费
        BillSectionEntity* section1 = [[BillSectionEntity alloc] init];
        section1.billType = 0;
        section1.height = 42.5f;
        section1.bshow = YES;
        section1.title = @"充话费";
        
        BillEntity* entity10 = [[BillEntity alloc] init];
        entity10.billType = 0;
        entity10.height = 75.0;
        entity10.facePriceName = @"";
        
        BillEntity* entity100 = [[BillEntity alloc] init];
        entity100.billType = 0;
        entity100.height = 75.0;
        entity100.facePriceName = @"20元";
        entity100.enabled = self.enabled;
        
        BillEntity* entity101 = [[BillEntity alloc] init];
        entity101.billType = 0;
        entity101.height = 75.0;
        entity101.facePriceName = @"30元";
        entity101.enabled = self.enabled;
        
        BillEntity* entity102 = [[BillEntity alloc] init];
        entity102.billType = 0;
        entity102.height = 75.0;
        entity102.facePriceName = @"50元";
        entity102.enabled = self.enabled;
        [entity10.billList addObjectCheck:entity100];
        [entity10.billList addObjectCheck:entity101];
        [entity10.billList addObjectCheck:entity102];
        
        
        
        BillEntity* entity11 = [[BillEntity alloc] init];
        entity11.billType = 0;
        entity11.height = 75.0;
        entity11.facePrice = @"";
        
        BillEntity* entity110 = [[BillEntity alloc] init];
        entity110.billType = 0;
        entity110.height = 75.0;
        entity110.facePriceName = @"100元";
        entity110.enabled = self.enabled;
        
        BillEntity* entity111 = [[BillEntity alloc] init];
        entity111.billType = 0;
        entity111.height = 75.0;
        entity111.facePriceName = @"200元";
        entity111.enabled = self.enabled;
        
        BillEntity* entity112 = [[BillEntity alloc] init];
        entity112.billType = 0;
        entity112.height = 75.0;
        entity112.facePriceName = @"500元";
        entity112.enabled = self.enabled;
        [entity11.billList addObjectCheck:entity110];
        [entity11.billList addObjectCheck:entity111];
        [entity11.billList addObjectCheck:entity112];
        
        [section1.billList addObjectCheck:entity10];
        [section1.billList addObjectCheck:entity11];
        [self.tableDataArr addObjectCheck:section1];
        
        
        // 3. 更多充值
        BillSectionEntity* section2 = [[BillSectionEntity alloc] init];
        section2.billType = 1;
        section2.height = 42.5f;
        section2.bshow = YES;
        section2.title = @"更多充值";
        
        BillEntity* entity2 = [[BillEntity alloc] init];
        entity2.billType = 1;
        entity2.height = 75.0;
        entity2.facePrice = @"";
        
        BillEntity* entity20 = [[BillEntity alloc] init];
        entity20.billType = 1;
        entity20.height = 75.0;
        entity20.facePriceName = @"选流量包";
        entity20.flowjump = YES;
        entity20.enabled = self.enabled;
        [entity2.billList addObjectCheck:entity20];
        [section2.billList addObjectCheck:entity2];
        
        [self.tableDataArr addObjectCheck:section2];
    }
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




// 5. 话费充值 -- 下单
-(void) requestWithSubmitOrder:(NSString*)tel entity:(BillEntity*)entity {

//
//    // 获取
//    if (_network)
//        [_network cancel];
//    @JDJRWeakify(self);
//    _network = [[MobileTopUpNetwork sharedInstance] submitBillOrder:tel money:entity.facePrice productName:entity.facePriceName isNumberExist:NO];
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
//                }*/
//            }
//        }
//    } withIdentifier:kMobileTopUp_SubmitBillOrder];
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
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            MobileNumberCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            NSString* tel = [cell getTelePhone];
            if (!tel || [tel isEqualToString:@""]) {
                return;
            }
            NSString* phoneOperator = [cell getPhoneOperator];
            
            HistoryRecordEntity* entity = [[HistoryRecordEntity alloc] init];
            entity.type = 0;
            entity.mobileNumber = tel;
            entity.status = phoneOperator;
            entity.name = self.name;
            [MobileTopUpHistoryRecordManager setMobileTopUpHistoryRecord:entity];
            
            return;
        }
        else if ([payStatus isEqualToString:JDP_PAY_FAIL])
        {
            //[[JRPodsPublic shareInstance]JRPublicJump:self.downClick];
            return;
        }
        
    }];
     */
}


@end












