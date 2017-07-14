//
//  HistoryRecordClearCell.h
//  JDMobile
//
//  Created by heweihua on 16/4/20.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "UIBaseTableCell.h"
#import "HistoryRecordViewDelegate.h"

#define kHistoryRecordClearCellH (60.0)


@class HistoryRecordEntity;
@interface HistoryRecordClearCell : UIBaseTableCell
@property(nonatomic, weak) id <HistoryRecordCellDelegate> delegate;
-(void) reloadData:(HistoryRecordEntity *)entity;
@end

