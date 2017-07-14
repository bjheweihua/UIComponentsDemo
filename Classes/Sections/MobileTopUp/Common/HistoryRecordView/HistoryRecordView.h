//
//  HistoryRecordView.h
//  JDMobile
//
//  Created by heweihua on 16/4/20.
//  Copyright © 2016年 jr. All rights reserved.
//  充值历史记录（最近三条）

#import <UIKit/UIKit.h>



@class HistoryRecordEntity;
@protocol HistoryRecordViewDelegate;
@interface HistoryRecordView : UIView

@property(nonatomic, weak) id<HistoryRecordViewDelegate> delegate;
-(void) reloadData:(NSInteger)type; // 0: 话费 1：流量
@end



@protocol HistoryRecordViewDelegate <NSObject>

-(void) didSelectHistoryRecord:(HistoryRecordEntity*)entity;
-(void) didTapHiddenHistoryRecordView;
@end