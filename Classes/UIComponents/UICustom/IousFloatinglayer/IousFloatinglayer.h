//
//  IousFloatinglayer.h
//  JDMobile
//
//  Created by hwhiMac27 on 2016/11/19.
//  Copyright © 2016年 jr. All rights reserved.


#import <UIKit/UIKit.h>


#define kIousFloatinglayerW (45.f + 10.5f)
#define kIousFloatinglayerH ((45.f + 5.5f)*2.f + 15.5f)

@class FloatinglayerView;
@protocol IousFloatinglayerDelegate;
@interface IousFloatinglayer : UIView

@property(nonatomic, weak) id<IousFloatinglayerDelegate> delegate;
-(void) reloadRedPointWithOrder:(NSString*)number;
-(void) reloadRedPointWithShopping:(NSString*)number;
@end


@protocol IousFloatinglayerDelegate <NSObject>

// index: 1:订单 2：购物车
-(void) didClickIousFloatinglayer:(NSInteger)index;

@end
