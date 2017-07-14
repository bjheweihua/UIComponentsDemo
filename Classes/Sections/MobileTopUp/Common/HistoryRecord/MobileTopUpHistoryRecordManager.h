//
//  MobileTopUpHistoryRecordManager.h
//  JDMobile
//
//  Created by heweihua on 16/5/6.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HistoryRecordEntity;
@interface MobileTopUpHistoryRecordManager : NSObject

#pragma mark - 话费充值
+(void) setMobileTopUpHistoryRecord:(HistoryRecordEntity *)entity;
+(NSMutableArray*) getMobileTopUpHistoryRecord;
+(void) deleteAllMobileTopUpHistoryRecord;

@end
