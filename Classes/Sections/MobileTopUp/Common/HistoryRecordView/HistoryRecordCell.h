//
//  HistoryRecordCell.h
//  JDMobile
//
//  Created by heweihua on 16/4/20.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "UIBaseTableCell.h"
#import "HistoryRecordViewDelegate.h"

#define kHistoryRecordCellH (60.0)

@protocol HistoryRecordCellDelegate;
@class HistoryRecordEntity;
@interface HistoryRecordCell : UIBaseTableCell

@property(nonatomic, weak) id <HistoryRecordCellDelegate> delegate;
-(void) hiddenTopLine:(BOOL)hidden;
-(void) reloadData:(HistoryRecordEntity *)entity;
@end



