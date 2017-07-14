//
//  UIBannerView.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//



#import <UIKit/UIKit.h>

#define kMobileTopUpBannerH ((kMainScreenW*84.f)/375.f)

@interface UIBannerView : UIView

-(void)reloadData:(NSArray *)array;

@end



