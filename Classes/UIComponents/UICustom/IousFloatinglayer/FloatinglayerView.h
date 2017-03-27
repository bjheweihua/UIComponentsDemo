//
//  FloatinglayerView.h
//  JDMobile
//
//  Created by hwhiMac27 on 2016/11/19.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBorderWidth (1.5f)//2
#define kButtonWH    (45.f)
#define kFloatinglayerW  (kButtonWH + 9.f + kBorderWidth)
#define kFloatinglayerH  (kButtonWH + 5.f + kBorderWidth)


@protocol FloatinglayerViewDelegate;
@interface FloatinglayerView : UIView

@property(nonatomic, weak) id <FloatinglayerViewDelegate> delegate;
@property(nonatomic, strong) CAShapeLayer *pointLayer; // new 无数字
@property(nonatomic, strong, readonly) UILabel *redPoint; // red point 有数字



-(instancetype) initWithImgNameU:(NSString*)imgNameU imgNameD:(NSString*)imgNameD;

-(void) reloadRedPoint:(NSString*)number;

@end


@protocol FloatinglayerViewDelegate <NSObject>

-(void) didClickFloatinglayerView:(UIView*)view;

@end
