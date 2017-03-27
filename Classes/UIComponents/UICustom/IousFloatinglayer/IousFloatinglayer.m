//
//  IousFloatinglayer.m
//  JDMobile
//
//  Created by hwhiMac27 on 2016/11/19.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "IousFloatinglayer.h"
#import "FloatinglayerView.h"

@interface IousFloatinglayer ()<FloatinglayerViewDelegate>

@property(nonatomic, strong) FloatinglayerView* orderview;
@property(nonatomic, strong) FloatinglayerView* shoppingview;
@end



@implementation IousFloatinglayer

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect rect = CGRectMake(0, 0, kFloatinglayerW, kFloatinglayerH);
        _shoppingview = [[FloatinglayerView alloc] initWithImgNameU:@"ious_icon_shoppingcart" imgNameD:@"ious_icon_shoppingcart_d"];
        [_shoppingview setDelegate:self];
        [_shoppingview.pointLayer setHidden:YES]; // 购物车没有小红点
        [_shoppingview setFrame:rect];
        //[_shoppingview reloadRedPoint:@"100"];//99 //2 12 99 ...
        [self addSubview:_shoppingview];
        
        
        CGFloat pointY = CGRectGetMaxY(_shoppingview.frame) + 15.5f;
        rect = CGRectMake(0, pointY, kFloatinglayerW, kFloatinglayerH);
        _orderview = [[FloatinglayerView alloc] initWithImgNameU:@"ious_icon_orders" imgNameD:@"ious_icon_orders_d"];
        [_orderview setDelegate:self];
        [_orderview setFrame:rect];
        //[_orderview reloadRedPoint:@"99"];//2 12 99 ...
        [self addSubview:_orderview];
    }
    return self;
}


-(void) reloadRedPointWithOrder:(NSString*)number{
    
    [_orderview reloadRedPoint:number];
    
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    if (NO == [user boolForKey:@"hidden_orders_new"]) {
        if (_orderview.redPoint.hidden == YES) {
            [_orderview.pointLayer setHidden:NO];
        }
    }
}


-(void) reloadRedPointWithShopping:(NSString*)number{
    
    [_shoppingview reloadRedPoint:number];
    /*
     NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
     if (NO == [user boolForKey:@"hidden_shoppingcart_new"]) {
     if (_shoppingview.redPoint.hidden == YES) {
     [_shoppingview.pointLayer setHidden:NO];
     }
     }*/
}


#pragma mark - FloatinglayerViewDelegate

-(void) didClickFloatinglayerView:(UIView*)view {
    
    if (_shoppingview == view){
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didClickIousFloatinglayer:)]) {
            /*
             NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
             if (NO == [user boolForKey:@"hidden_shoppingcart_new"]) {
             [user setBool:YES forKey:@"hidden_shoppingcart_new"];// 购物车
             [_shoppingview.pointLayer setHidden:YES];
             }*/
            [self.delegate didClickIousFloatinglayer:2];
        }
    }
    else if (_orderview == view) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didClickIousFloatinglayer:)]) {
            
            NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
            if (NO == [user boolForKey:@"hidden_orders_new"]) {
                [user setBool:YES forKey:@"hidden_orders_new"];// 订单列表
                [_orderview.pointLayer setHidden:YES];
            }
            [self.delegate didClickIousFloatinglayer:1];
        }
    }
}




@end














