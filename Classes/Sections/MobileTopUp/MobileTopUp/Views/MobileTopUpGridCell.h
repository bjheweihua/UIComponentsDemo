//
//  MobileTopUpGridCell.h
//  JDMobile
//
//  Created by heweihua on 16/4/19.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "UIBaseTableCell.h"
#import "MobileGridView.h"

#define kMobileTopUpGridCellH (kGridCellH + 10.f)


@class BillEntity;
@protocol MobileTopUpGridCellDelegate;
@interface MobileTopUpGridCell : UIBaseTableCell{
    
    MobileGridView* _cell1;
    MobileGridView* _cell2;
    MobileGridView* _cell3;
}
@property(nonatomic, assign) id <MobileTopUpGridCellDelegate> delegate;

-(void) reloadData:(BillEntity *)entity;

@end




@protocol MobileTopUpGridCellDelegate <NSObject>

-(void) didTouchMobileGrid:(BillEntity*) entity;

@end
