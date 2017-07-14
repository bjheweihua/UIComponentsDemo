//
//  MobileTopUpHeaderView.h
//  JDMobile
//
//  Created by heweihua on 16/4/18.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "BaseTableViewHeaderFooterView.h"

#define kMobileTopUpHeaderH (42.5f)

@class BillSectionEntity;
@interface MobileTopUpHeaderView : BaseTableViewHeaderFooterView

-(void) reloadData:(BillSectionEntity*)entity;

@end
