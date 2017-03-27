//
//  UIBaseView.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/25.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIBaseView.h"

@implementation UIBaseView

-(instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [_clickBtn setBackgroundColor:[UIColor clearColor]];
        [_clickBtn addTarget:self action:@selector(btnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_clickBtn];
    }
    return self;
}

-(void)reloadData:(BaseEntity*)entity{
    
    if (entity == self.entity) {
        return;
    }
    self.entity = entity;
    if (self.reloadHeight) {
        
        self.height = entity.height;
        self.clickBtn.height = entity.height;
    }

    if (self.bHighLight) {
        UIColor * selectColor = [UIColor jrColor:[UIColor blackColor] withAlpha:0.05f];
        [_clickBtn setBackgroundImage:[UIImage jrCreateImageWithColor:selectColor rect:_clickBtn.bounds] forState:UIControlStateHighlighted];
        [_clickBtn setBackgroundImage:[UIImage jrCreateImageWithColor:selectColor rect:_clickBtn.bounds] forState:UIControlStateSelected];
    }else{
        [_clickBtn setBackgroundImage:nil forState:UIControlStateHighlighted];
        [_clickBtn setBackgroundImage:nil forState:UIControlStateSelected];
    }
}


-(void) btnClick:(UIButton*)btn withEvent:(UIEvent*)event{
    
    UITouch* touch = [[event allTouches] anyObject];
    if(touch.tapCount != 1) return;
    btn.selected = YES;
    [self performSelector:@selector(btnUnSelected:) withObject:btn afterDelay:0.2];
}


-(void) btnUnSelected:(UIButton*)btn{
    
    btn.selected = NO;
}

@end





