//
//  FloatinglayerView.m
//  JDMobile
//
//  Created by hwhiMac27 on 2016/11/19.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "FloatinglayerView.h"


// 一个数字     16
// 两个数字/... 20

#define kRedPointCellHeight (14.f)//16
#define kRedPointHeight (kRedPointCellHeight + kBorderWidth*2)
#define kRedPointWidth (kRedPointHeight)
#define kRedPointMaxWidth (20.f + kBorderWidth*2)
#define kBubblePointX (32.5)

#define kNewPointWH (7.f + kBorderWidth)


@interface FloatinglayerView ()
@property(nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation FloatinglayerView

-(instancetype) initWithImgNameU:(NSString*)imgNameU imgNameD:(NSString*)imgNameD{
    
    self = [super init];
    if (self) {
        
        
        self.frame = CGRectMake(0, 0, kFloatinglayerW, kFloatinglayerW);
        self.backgroundColor = [UIColor clearColor];
        
        CGRect rect = CGRectMake(0, 6.5, kButtonWH, kButtonWH);
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = rect;
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:imgNameU] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imgNameD] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(clickbutton:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        button.backgroundColor = [UIColor jrColorWithHex:@"#3d4552"];
        button.layer.borderWidth = 1;
        [button.layer setCornerRadius:kButtonWH/2];
        button.layer.borderColor = [[UIColor clearColor] CGColor];
        
        //加阴影
        button.layer.shadowColor = [UIColor jrColorWithHex:@"#000000"].CGColor;//shadowColor阴影颜色
        button.layer.shadowOffset = CGSizeMake(0.5, 3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        button.layer.shadowOpacity = 0.2;//阴影透明度，默认0
        button.layer.shadowRadius = 3;//阴影半径，默认3
        
        // 气泡描边
        rect = CGRectMake(kBubblePointX, 0, kRedPointWidth, kRedPointHeight);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(kRedPointHeight/2.f, kRedPointHeight/2.f)];
        _maskLayer = [[CAShapeLayer alloc] init];
        _maskLayer.fillColor = [UIColor jrColorWithHex:@"#ff801a"].CGColor;
        _maskLayer.strokeColor =  [UIColor whiteColor].CGColor;
        _maskLayer.path = maskPath.CGPath;
        _maskLayer.lineWidth = kBorderWidth;
        [self.layer addSublayer:_maskLayer];
        self.maskLayer.hidden = YES;// default hidden
        
        // 气泡label
        rect = CGRectMake(kBubblePointX, 0.f, kRedPointWidth, kRedPointHeight);
        _redPoint = [[UILabel alloc] initWithFrame:rect];
        _redPoint.backgroundColor = [UIColor clearColor];// [UIColor jrColorWithHex:@"#ff801a"];
        [_redPoint setFont:[UIFont getSanFranciscoFont:10.f Weight:KSFWeightMedium]];
        _redPoint.textColor = [UIColor whiteColor];
        [_redPoint setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_redPoint];
        _redPoint.hidden = YES;// default hidden
        
        /*
         _redPoint.layer.borderWidth = kBorderWidth;
         [_redPoint.layer setMasksToBounds:YES];
         [_redPoint.layer setCornerRadius:kRedPointHeight/2.f];
         _redPoint.layer.borderColor = [[UIColor whiteColor] CGColor];
         _redPoint.hidden = YES;// default hidden
         */
        
        
        // new 2.5 - 1.5
        rect = CGRectMake((kButtonWH - kNewPointWH - 1.f), 6.5, kNewPointWH, kNewPointWH);
        UIBezierPath *newMaskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(kNewPointWH/2.f, kNewPointWH/2.f)];
        _pointLayer = [[CAShapeLayer alloc] init];
        _pointLayer.fillColor = [UIColor jrColorWithHex:@"#ff801a"].CGColor;
        _pointLayer.strokeColor =  [UIColor whiteColor].CGColor;
        _pointLayer.path = newMaskPath.CGPath;
        _pointLayer.lineWidth = kBorderWidth;
        [self.layer addSublayer:_pointLayer];
        _pointLayer.hidden = YES;
    }
    return self;
}


-(void) reloadRedPoint:(NSString*)number{
    
    //    if (!number) {
    //        number = @"";
    //    }
    
    CGRect rect = CGRectMake(kBubblePointX, 0.f, kRedPointWidth, kRedPointHeight);
    [_redPoint setFrame:rect];
    
    // 描边
    rect = CGRectMake(kBubblePointX, 0, kRedPointWidth, kRedPointHeight);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(kRedPointHeight/2.f, kRedPointHeight/2.f)];
    [self.maskLayer setPath:[maskPath CGPath]];
    
    if (!number || [number isEqualToString:@""] || [number isEqualToString:@"0"]) {
        
        _redPoint.hidden = YES;
        self.maskLayer.hidden = YES;
        return;
    }
    if ([number integerValue] <= 0) {
        
        _redPoint.hidden = YES;
        self.maskLayer.hidden = YES;
        return;
    }
    _redPoint.hidden = NO;
    self.maskLayer.hidden = NO;
    self.pointLayer.hidden = YES;
    
    if ([number length] >= 2) {
        /*
         if ([number length] >= 3) {
         number = @"•••";
         }*/
        rect = CGRectMake(kBubblePointX, 0.f, kRedPointMaxWidth, kRedPointHeight);
        [_redPoint setFrame:rect];
        
        // 描边
        rect = CGRectMake(kBubblePointX, 0, kRedPointMaxWidth, kRedPointHeight);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(kRedPointHeight/2.f, kRedPointHeight/2.f)];
        [self.maskLayer setPath:[maskPath CGPath]];
    }
    if ([number integerValue] > 99) {
        number = @"99";
    }
    [_redPoint setText:number];
}




#pragma mark - click button
-(void) clickbutton:(id)sender withEvent:(UIEvent*)event{
    
    UITouch* touch = [[event allTouches] anyObject];
    // 判断点击次数
    if(touch.tapCount != 1) return;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickFloatinglayerView:)]) {
        [self.delegate didClickFloatinglayerView:self];
    }
}


@end

















