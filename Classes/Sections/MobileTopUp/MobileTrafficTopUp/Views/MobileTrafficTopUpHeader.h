//
//  MobileTrafficTopUpHeader.h
//  JDMobile
//
//  Created by heweihua on 16/5/2.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kMobileTrafficTopUpMobileH    (70.0)

@protocol MobileTrafficTopUpHeaderDelegate;
@interface MobileTrafficTopUpHeader : UITableViewHeaderFooterView

@property(nonatomic, weak  ) id<MobileTrafficTopUpHeaderDelegate> delegate;
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

-(void) reloadDataWithTel:(NSString*)tel name:(NSString*)name;
-(void) reloadDataWithTips:(NSString*)tips isErr:(BOOL)bErr;
-(NSString*) getPhoneOperator;
-(void) mobileTextFieldWithResignFirstResponder;
-(void)reloadBannerData:(NSArray *)arr;
-(CGFloat) getMobileMaxY;

@end




@protocol MobileTrafficTopUpHeaderDelegate <NSObject>

-(void) mobileTextFieldDidInputWithNumber:(NSString*) mobileNumber;
-(void) mobileTextFieldDidInput:(BOOL) hidden;
-(void) didClickHeadButton;

// 键盘显示|隐藏
-(void) keyBoardWillShow;
-(void) keyBoardWillHide;

@end







