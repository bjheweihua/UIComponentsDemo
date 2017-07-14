//
//  CfRefreFooterView.h
//  JDMobile
//
//  Created by wangxiugang on 14-12-15.
//  Copyright (c) 2014年 wangxiugang. All rights reserved.
//

#import "CfRefreFooterView.h"

@interface CfRefreFooterView : UIView

@property(nonatomic,strong) UIActivityIndicatorView * activity;

- (id)init;

- (void)start;

- (void)stop;

@end
