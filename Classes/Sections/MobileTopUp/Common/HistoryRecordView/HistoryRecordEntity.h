//
//  HistoryRecordEntity.h
//  JDMobile
//
//  Created by heweihua on 16/4/21.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryRecordEntity : NSObject

@property(nonatomic, assign) NSInteger type; // 0: 数据 1：清空历史记录
@property(nonatomic, copy  ) NSString *mobileNumber;
@property(nonatomic, copy  ) NSString *phoneOperator; //@"北京电信";
@property(nonatomic, copy  ) NSString *status; // “账户绑定号码"、“XXX”（通讯录姓名）、“充值号码”（非前两项时，输入框内显示此名称，历史记录里显示为空）
@property(nonatomic, copy  ) NSString *name; // 通讯录姓名

@end
