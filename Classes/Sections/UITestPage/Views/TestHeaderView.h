//
//  TestHeaderView.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/5.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestSegmented.h"



#define kMobileTrafficTopUpMobileH    (70.0)

@protocol TestHeaderViewViewDelegate;
@interface TestHeaderView : UITableViewHeaderFooterView
<
UIScrollViewDelegate,
TestSegmentedDelegate
>
{
    NSInteger    _nType; // 0:全国通用  1：省内通用
    TestSegmented* _segControl;
    NSInteger _tableIndex;
    NSArray*  _tableArr;
}

@property(nonatomic, weak  ) id<TestHeaderViewViewDelegate> delegate;
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end




@protocol TestHeaderViewDelegate <NSObject>

//-(void) mobileTextFieldDidInputWithNumber:(NSString*) mobileNumber;
//-(void) mobileTextFieldDidInput:(BOOL) hidden;
//-(void) didClickHeadButton;
//
//// 键盘显示|隐藏
//-(void) keyBoardWillShow;
//-(void) keyBoardWillHide;

@end

