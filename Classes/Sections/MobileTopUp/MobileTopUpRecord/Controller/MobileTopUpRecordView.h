//
//  MobileTopUpRecordView.h
//  JDMobile
//
//  Created by heweihua on 16/5/23.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRRefreshView.h"
#import "CfRefreFooterView.h"

@class MobileTopUpRecordViewController;
@interface MobileTopUpRecordView : UIView
//@property (nonatomic, strong) NetworkController *network;
@property (nonatomic, strong) NSMutableArray    *tableDataArr;
@property (nonatomic, assign) NSInteger         totalCount;
@property (nonatomic, strong) SRRefreshView     *slimeView;

@property(nonatomic,strong) CfRefreFooterView *refreshFooter;
@property(nonatomic,assign) BOOL isFull;     // 没有更多了
@property(nonatomic,assign) BOOL isLoading;


// type 0:话费  1：流量
-(instancetype) initWithFrame:(CGRect)frame;
-(void) setController:(MobileTopUpRecordViewController*)vc type:(NSInteger)type;
-(void) requestData;
@end
