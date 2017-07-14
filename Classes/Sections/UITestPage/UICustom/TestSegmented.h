//
//  MobileTrafficTopUpSegmented.h
//  JDMobile
//
//  Created by heweihua on 16/6/28.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTestSegmentedH (50)

@protocol TestSegmentedDelegate;
@interface TestSegmented : UIView


@property (nonatomic, weak ) id <TestSegmentedDelegate> delegate;
@property (nonatomic,strong) UISegmentedControl *segmentControl;
@property (nonatomic,strong) UIView* lineView;
-(void)reloadData:(NSArray *)titleArray;

@end



@protocol TestSegmentedDelegate <NSObject>

-(void)segmentControlClick:(UISegmentedControl *)segmentControl;

@end
