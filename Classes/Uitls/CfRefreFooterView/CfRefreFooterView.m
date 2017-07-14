//
//  CfRefreFooterView.m
//  JDMobile
//
//  Created by heweihua on 14-12-15.
//  Copyright (c) 2014年 wangxiugang. All rights reserved.
//

#import "CfRefreFooterView.h"


@interface CfRefreFooterView ()
{

}

@end

@implementation CfRefreFooterView
@synthesize activity;

-(void)dealloc
{
    NSLog(@"CfRefreFooterView dealloc");
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];

        self.frame = CGRectMake(0, 0, kMainScreenW, CGRectGetHeight(activity.frame)*2);
        
        [activity setCenter:CGPointMake(CGRectGetWidth(self.frame)*0.5f,CGRectGetHeight(self.frame)*0.5f)];
        [self addSubview:activity];
        
    }
    return self;
}

-(void)start
{
    if ([activity isAnimating])
        return;
    [activity startAnimating];
}

-(void)stop
{
    [activity stopAnimating];
}

@end
