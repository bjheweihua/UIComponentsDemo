//
//  MobileTrafficTopUpCell.h
//  JDMobile
//
//  Created by heweihua on 16/4/28.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "UIBaseTableCell.h"

#define kMobileTrafficTopUpCellH (70.f)


@class MobileTrafficEntity;
@protocol MobileTrafficTopUpCellDelegate;
@interface MobileTrafficTopUpCell : UIBaseTableCell

@property(nonatomic, weak) id <MobileTrafficTopUpCellDelegate> delegate;
-(void) reloadData:(MobileTrafficEntity *)entity;
@end



@protocol MobileTrafficTopUpCellDelegate <NSObject>

-(void) didTouchTrafficTopUp:(MobileTrafficEntity *)entity;

@end
