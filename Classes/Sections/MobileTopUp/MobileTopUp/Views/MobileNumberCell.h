//
//  MobileNumberCell.h
//  JDMobile
//
//  Created by heweihua on 16/4/19.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "UIBaseTableCell.h"

#define kMobileNumberCellH (70.f)


@class BillEntity;
@protocol MobileNumberCellDelegate;
@interface MobileNumberCell : UIBaseTableCell

@property(nonatomic, weak  ) id<MobileNumberCellDelegate> delegate;


-(void) reloadData:(BillEntity *)entity;
-(void) hiddenMobileTextFieldWithTel:(NSString*)tel name:(NSString*)name;
-(NSString*) getTelePhone;
-(NSString*) getPhoneOperator;
-(void) mobileTextFieldWithResignFirstResponder;
-(CGFloat) getMobileMaxY;
@end



@protocol MobileNumberCellDelegate <NSObject>

-(void) mobileTextFieldDidInputWithNumber:(NSString*) mobileNumber;
-(void) mobileTextFieldDidInput:(BOOL) hidden;
-(void) didClickHeadButton;

// 键盘显示|隐藏
-(void) keyBoardWillShow;
-(void) keyBoardWillHide;

@end
