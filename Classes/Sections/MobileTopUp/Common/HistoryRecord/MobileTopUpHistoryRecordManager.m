//
//  MobileTopUpHistoryRecordManager.m
//  JDMobile
//
//  Created by heweihua on 16/5/6.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTopUpHistoryRecordManager.h"
#import "HistoryRecordEntity.h"

// 话费
#define kMobileTopUpHistoryArr @"mobileTopUpHistoryArr"
#define kHistoryMaxCount       (3)


// 流量
#define kMobileTrafficTopUpHistoryArr @"kMobileTrafficTopUpHistoryArr"
#define kTrafficHistoryMaxCount       (3)

@implementation MobileTopUpHistoryRecordManager

#pragma mark - 话费充值
// 添加手机充值记录
+(void) setMobileTopUpHistoryRecord:(HistoryRecordEntity *)entity {
    
    NSMutableDictionary *historyDic = [self getCurrentUserMobileHistoryDict];
    if (nil == historyDic) {
        return;
    }
    NSArray *arr = [historyDic objectForKey:kMobileTopUpHistoryArr];
    NSMutableArray *hisArr = [[NSMutableArray alloc] initWithArray:arr];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:entity];
    if (!data)return;
    
    if (hisArr.count == 0){
        
        [hisArr insertObjectCheck:data atIndex:0];
    }
    else{
        
        BOOL b = NO;
        for (NSInteger i = 0; i < hisArr.count; ++i){
            
            NSData *data2 = (NSData*)[hisArr objectAtIndexCheck:i];
            HistoryRecordEntity *temEntity = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
            if ([temEntity.mobileNumber isEqualToString:entity.mobileNumber]){
                
                b = YES;
                [hisArr removeObjectAtIndex:i];
                [hisArr insertObjectCheck:data atIndex:0];
                break;
            }
        }
        if (!b){
            if (hisArr.count == kHistoryMaxCount){
                [hisArr removeObjectAtIndex:kHistoryMaxCount-1];
                [hisArr insertObjectCheck:data atIndex:0];
            }
            else{
                [hisArr insertObjectCheck:data atIndex:0];
            }
        }
    }
    
    [historyDic setObjectCheck:hisArr forKey:kMobileTopUpHistoryArr];
    [self setCurrentUserMobileTopUpHistoryDic:historyDic];
}

// get手机历史充值记录
+(NSMutableArray*) getMobileTopUpHistoryRecord{
    
    NSMutableDictionary *historyDic = [self getCurrentUserMobileHistoryDict];
    NSArray *arr = [historyDic objectForKey:kMobileTopUpHistoryArr];
    NSMutableArray *histArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < arr.count; ++i){
        
        NSData *data = (NSData*)[arr objectAtIndexCheck:i];
        HistoryRecordEntity *entity = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [histArr addObjectCheck:entity];
    }
    return histArr;
}




// 删除手机历史充值记录
+(void) deleteAllMobileTopUpHistoryRecord {
    
    NSMutableDictionary *historyDic = [self getCurrentUserMobileHistoryDict];
    NSArray *arr = [historyDic objectForKey:kMobileTopUpHistoryArr];
    if (!arr || arr.count == 0)
        return;
    [historyDic setObjectCheck:@[] forKey:kMobileTopUpHistoryArr];
    [self setCurrentUserMobileTopUpHistoryDic:historyDic];
}






// 返回当前用户充值历史记录字典，不存在则添加
+(NSMutableDictionary *) getCurrentUserMobileHistoryDict{
    
    /*
    //获取当前用户名
    UserInfoModel *userModel = [UserPreference getCurrentUserInfoModel];
    NSString *currentJDPin = userModel.JDPin;// 京东Pin
    if (currentJDPin == nil) {
        return nil;
    }
    
    NSArray *array = (NSArray*)[UserPreference getValueForKey:kMobileTopUpHistory];
    NSMutableArray *historyArr;
    if (array == nil)
        historyArr = [[NSMutableArray alloc] initWithCapacity:kMobileTopUpHistoryUserMax];
    else
        historyArr = [[NSMutableArray alloc] initWithArray:array];
    
    // 查找当前用户历史记录是否已经存在
    for (NSMutableDictionary *dic in historyArr) {
        if ([[dic objectForKey:@"JDPin"] isEqualToString:currentJDPin]) { // 京东Pin
            NSMutableDictionary *historyDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
            return historyDic;
        }
    }
    // 未找到当前用户,添加
    NSMutableArray *entityArr = [[NSMutableArray alloc] initWithCapacity:kHistoryMaxCount];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObjectCheck:currentJDPin forKey:@"JDPin"];
    [dic setObjectCheck:entityArr forKey:kMobileTopUpHistoryArr]; // 一个用户最多保存3条历史数据
    [historyArr addObjectCheck:dic];
    [UserPreference setValue:historyArr forKey:kMobileTopUpHistory]; //本地同步
    return dic;
    */
    return nil;
}





// 设置当前用户手势密码字典,如果 dictionary = nil ,则移除当前用户的手势密码 --- ok
+(void) setCurrentUserMobileTopUpHistoryDic:(NSMutableDictionary *)dictionary{
    
    /*
    if (!dictionary) {
        return;
    }
    UserInfoModel *userModel = [UserPreference getCurrentUserInfoModel];
    NSString *currentJDPin = userModel.JDPin;
    if(!currentJDPin) return;
    
    // 获取手势字典数组
    NSArray *array = (NSArray*)[UserPreference getValueForKey:kMobileTopUpHistory];
    NSMutableArray *historyArr = [[NSMutableArray alloc]initWithArray:array];
    
    // 如果手势数组中没有元素
    if (historyArr.count == 0){
        [historyArr addObjectCheck:dictionary];
    }
    else{
        
        //查找当前用户所在字典
        BOOL exist = NO;
        for (NSInteger i = 0; i< historyArr.count; i++){
            NSMutableDictionary *dic = [historyArr objectAtIndexCheck:i];
            if ([[dic objectForKey:@"JDPin"] isEqualToString:currentJDPin]){
                exist = YES;
                if (dictionary==nil)
                    [historyArr removeObject:dic];
                else
                    [historyArr replaceObjectAtIndex:i withObject:dictionary];
                break;
            }
        }
        //没找到当前用户
        if (!exist)
            [historyArr addObjectCheck:dictionary];
    }
    [UserPreference removeKey:kMobileTopUpHistory]; // 先清空，再次重新存入
    //本地同步
    [UserPreference setValue:historyArr forKey:kMobileTopUpHistory];
     */
}




@end
