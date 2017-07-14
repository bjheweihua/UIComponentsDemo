//
//  HistoryRecordViewDelegate.h
//  JDMobile
//
//  Created by heweihua on 16/6/30.
//  Copyright © 2016年 jr. All rights reserved.
//

#ifndef HistoryRecordViewDelegate_h
#define HistoryRecordViewDelegate_h

@protocol HistoryRecordCellDelegate <NSObject>

-(void) didSelectHistoryRecordCell:(NSInteger)row;

@end


#endif /* HistoryRecordViewDelegate_h */
