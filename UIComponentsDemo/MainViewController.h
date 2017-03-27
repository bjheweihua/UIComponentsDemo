//
//  MainViewController.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIBaseViewController.h"
#import "IousFloatinglayer.h"

#define kIousChannelsTest
#ifdef kIousChannelsTest
#import <CoreMotion/CoreMotion.h>
//#import "IousChannelsTestController.h"
#endif



@interface MainViewController : UIBaseViewController <IousFloatinglayerDelegate>{
    
    UITableView*      _tableView;
    NSMutableArray*   _tableDataArr;       //  table 数据数组
    IousFloatinglayer *_floatlayer;
    CGFloat _oldY;
}


#ifdef kIousChannelsTest
@property (strong,nonatomic) CMMotionManager *motionManager; // heweihua test
#endif

@end
