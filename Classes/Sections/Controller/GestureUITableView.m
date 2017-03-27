//
//  GestureUITableView.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/15.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "GestureUITableView.h"

@implementation GestureUITableView

// 该方法实现，如果一个手势没有被识别，那么多个手势可以被识别
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
////    if (gestureRecognizer.state != 0) {
////        return YES;
////    }else{
////        return NO;
////    }
//    
//    
//    return self.enable;
//}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
