//
//  DCVerCycleScrollView.h
//  
//
//  Created by shenghuihan on 2017/1/5.
//
//

#import <UIKit/UIKit.h>
#import "DCVerCycleModel.h"
@interface DCVerCycleScrollView : UIView
@property (nonatomic, assign) CGFloat durantion;///<滚动速度控制
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;///<滚动时间间隔
- (void)reloadArr:(NSArray <DCVerCycleModel *>*)titleArr;
@property (nonatomic, copy) void(^clickBlock)(DCVerCycleModel *,NSInteger);
@end
