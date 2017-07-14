//
//  MobileTrafficTopUpSegmented.h
//  JDMobile
//
//  Created by heweihua on 16/6/28.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMobileTrafficTopUpSegmentedH (50)

@protocol MobileTrafficTopUpSegmentedDelegate;
@interface MobileTrafficTopUpSegmented : UIView
@property (nonatomic, weak ) id <MobileTrafficTopUpSegmentedDelegate> delegate;
@property (nonatomic,strong) UISegmentedControl *segmentControl;
@property (nonatomic,strong) UIView* lineView;
-(void)reloadData:(NSArray *)titleArray;

@end



@protocol MobileTrafficTopUpSegmentedDelegate <NSObject>

-(void)segmentControlClick:(UISegmentedControl *)segmentControl;

@end