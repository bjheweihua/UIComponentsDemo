//
//  JRPageView.m
//  JDMobile
//
//  Created by xinyu.wu on 16/7/19.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "JRPageControl.h"

@interface JRPageControl ()

@property (nonatomic, strong) UIView *tintMaskView;//截断超出的View
@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, assign) NSInteger lastPage;

@end

@implementation JRPageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        
        [self resetValues];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        
        [self resetValues];
    }
    return self;
}

-(void)layoutSubviews
{
    [self makeViewFrame];
    [super layoutSubviews];
}

-(void)resetValues
{
    _currentPage = 0;
    _currentPageIndicatorTintColor = [UIColor redColor];
    _pageIndicatorTintColor = [UIColor whiteColor];
    
    _circle_W = 7.0;
    _circle_H = 1.0;
    _interval = 7.0;
    
    _tintMaskView = [[UIView alloc] init];
    _tintMaskView.backgroundColor = [UIColor clearColor];
    _tintMaskView.clipsToBounds = YES;
    [self addSubview:_tintMaskView];
    
    _currentView = [[UIView alloc] init];
    _currentView.backgroundColor = [UIColor redColor];
    [_tintMaskView addSubview:_currentView];
}

-(void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    
    [self makeViewFrame];
    
    [self setNeedsDisplay];
}

-(void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    
    [self setNeedsDisplay];
}

-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    _currentView.backgroundColor = _currentPageIndicatorTintColor;
    
    [self setNeedsDisplay];
}

-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    
    [self setNeedsDisplay];
}

-(void)setCircle_W:(CGFloat)circle_W
{
    _circle_W = circle_W;
    
    [self makeViewFrame];
    
    [self setNeedsDisplay];
}

-(void)setCircle_H:(CGFloat)circle_H
{
    _circle_H = circle_H;
    
    [self makeViewFrame];
    
    [self setNeedsDisplay];
}

-(void)setInterval:(CGFloat)interval
{
    _interval = interval;
    
    [self makeViewFrame];
    
    [self setNeedsDisplay];
}

-(void)setHidesForSinglePage:(BOOL)hidesForSinglePage
{
    _hidesForSinglePage = hidesForSinglePage;
    
    [self setNeedsDisplay];
}

-(void)makeViewFrame
{
    CGFloat total_W = _numberOfPages * _circle_W + (_numberOfPages - 1) * _interval;
    CGFloat start_X = (CGRectGetWidth(self.frame) - total_W)/2.0;
    CGFloat start_Y = (CGRectGetHeight(self.frame) - _circle_H)*0.5;;
    _tintMaskView.frame = CGRectMake(start_X, start_Y, total_W, _circle_H);
    
    _currentView.frame = CGRectMake(_currentPage * (_circle_W + _interval), 0, _circle_W, _circle_H);
    _currentView.layer.cornerRadius = CGRectGetHeight(_currentView.frame)/2.0;
    _currentView.clipsToBounds = YES;
}

- (void)drawRect:(CGRect)rect {
    
    if (_hidesForSinglePage && _numberOfPages <= 1) {
        self.currentView.hidden = YES; return;
    }else {
        self.currentView.hidden = NO;
    };
    
    if (_currentPage >= _numberOfPages) return;
    if (_numberOfPages <= 0 || _circle_W == 0) return;
    if (CGRectGetWidth(self.frame) == 0 || CGRectGetHeight(self.frame) == 0) return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat total_W = _numberOfPages * _circle_W + (_numberOfPages - 1) * _interval;
    CGPoint start = CGPointMake((CGRectGetWidth(self.frame) - total_W)/2.0, CGRectGetHeight(self.frame)/2.0);
    
    for (NSInteger i = 0; i < _numberOfPages; i++) {
        
        CGContextSetFillColorWithColor(context, _pageIndicatorTintColor.CGColor);
        
        if (self.type == JRPageControlType_Line) {
            CGContextFillRect(context, CGRectMake(start.x + i * (_circle_W + _interval), start.y - _circle_H/2.0, _circle_W, _circle_H));
        }else{
            CGContextFillEllipseInRect(context, CGRectMake(start.x + i * (_circle_W + _interval), start.y - _circle_H/2.0, _circle_W, _circle_H));
        }
    }
    
    if (self.subType == JRPageControlSubType_Jump) {
        CGRect rect = _currentView.frame;
        rect.origin.x = _currentPage * (_circle_W + _interval);
        _currentView.frame = rect;
    }else {
        BOOL isLastToFirst = (_currentPage == 0)&&(_lastPage == (_numberOfPages - 1));
        BOOL isFirstToLast = (_lastPage == 0)&&(_currentPage == (_numberOfPages - 1));
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            if (_numberOfPages > 2 && isLastToFirst) {
                //从第七个变到第一个
                CGRect rect = _currentView.frame;
                rect.origin.x = _numberOfPages * (_circle_W + _interval);
                _currentView.frame = rect;
            }
            else if (_numberOfPages > 2 && isFirstToLast) {
                CGRect rect = _currentView.frame;
                rect.origin.x = -1 * (_circle_W);
                _currentView.frame = rect;
            }
            else {
                CGRect rect = _currentView.frame;
                rect.origin.x = _currentPage * (_circle_W + _interval);
                _currentView.frame = rect;
            }
        } completion:^(BOOL finished) {
            if (_numberOfPages > 2 && isLastToFirst) {
                CGRect rect = _currentView.frame;
                rect.origin.x = _currentPage * (_circle_W + _interval);
                _currentView.frame = rect;
            }
            else if (_numberOfPages > 2 && isFirstToLast) {
                CGRect rect = _currentView.frame;
                rect.origin.x = _currentPage * (_circle_W + _interval);
                _currentView.frame = rect;
            }
        }];
    }
    _lastPage = _currentPage;
}


/*
 if (i == _currentPage) {
 CGContextSetFillColorWithColor(context, _currentPageIndicatorTintColor.CGColor);
 }else{
 CGContextSetFillColorWithColor(context, _pageIndicatorTintColor.CGColor);
 }
 */

@end
