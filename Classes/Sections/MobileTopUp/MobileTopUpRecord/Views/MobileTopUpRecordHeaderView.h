//
//  MobileTopUpRecordHeaderView.h
//  JDMobile
//
//  Created by heweihua on 16/4/25.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "UIBaseHeaderFooterView.h"

#define kMobileTopUpRecordHeaderViewH (35.f)

@class MobileTopUpRecordEntity;
@interface MobileTopUpRecordHeaderView : UIBaseHeaderFooterView

-(void) reloadData:(MobileTopUpRecordEntity*)entity;

@end
