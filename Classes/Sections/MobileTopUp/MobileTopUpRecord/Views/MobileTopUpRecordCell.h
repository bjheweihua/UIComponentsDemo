//
//  MobileTopUpRecordCell.h
//  JDMobile
//
//  Created by heweihua on 16/4/25.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "UIBaseTableCell.h"

#define kMobileTopUpRecordCellH (70.f)

@class MobileTopUpRecordEntity;
@interface MobileTopUpRecordCell : UIBaseTableCell

-(void) reloadData:(MobileTopUpRecordEntity *)entity;
@end
