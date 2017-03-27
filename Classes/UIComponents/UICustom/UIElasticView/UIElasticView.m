//
//  UIElasticView.m
//  RefreshDemo
//
//  Created by heweihua on 16/7/11.
//  Copyright © 2016年 heweihua. All rights reserved.
//

#import "UIElasticView.h"

#define kContentOffset @"contentOffset"
#define kAnimationDistance (25.f)
#define kDistance (self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.frame))
#define kItemHeight  ((UIScreen_W - 16*2.f - 8.0*2.f)/3.f)

@interface UIElasticView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat offSetX;
@property (nonatomic, assign, getter = isEndAnimation) BOOL endAniamtion;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UILabel *statusLabel; // 查看更多
@property (nonatomic, assign) CGFloat oldX;
@property (atomic, assign) CGFloat elasticH;
@end

@implementation UIElasticView

- (void)dealloc {
    
    [self.scrollView removeObserver:self forKeyPath:kContentOffset];
}

- (instancetype)initWithBindingScrollView:(UIScrollView *)bindingScrollView elasticH:(CGFloat)elasticH{
    
    if (self = [super initWithFrame:CGRectZero]) {
        
        self.backgroundColor = [UIColor clearColor]; // 一定要clearn
        self.scrollView = bindingScrollView;
        [self configSubViews];
        self.elasticH = elasticH;
        if (self.elasticH == 0) {
            self.elasticH = CGRectGetHeight(bindingScrollView.frame);
        }
    }
    return self;
}

- (void) configSubViews {
    
    _oldX = 0;
    self.shapeLayer = [[CAShapeLayer alloc] initWithLayer:self.layer];
    self.shapeLayer.path = [self calculateAnimaPathWithLeftOriginX:0];
    self.shapeLayer.fillColor = [UIColor jrColorWithHex:@"#f5f5f5"].CGColor;//f0f0f0
    [self.layer addSublayer:self.shapeLayer];
    [self.scrollView addObserver:self forKeyPath:kContentOffset options:NSKeyValueObservingOptionInitial context:nil];
    
    // 释放查看图文详情
//    NSString* text = @"释放查看";
    UIFont* font = [UIFont getSystemFont:11.f Weight:KFontWeightLight];
    CGFloat pointX = CGRectGetWidth(self.scrollView.frame) + (kAnimationDistance - 11.f)/2.f;
//    CGFloat pointY = (CGRectGetHeight(self.scrollView.frame) - 56.f)/2.f;
    CGFloat pointY = (self.elasticH - 56.f)/2.f;
    CGRect rect = CGRectMake(pointX, pointY, 11.f, 56.f);
    _statusLabel = [[UILabel alloc] initWithFrame:rect];
    _statusLabel.backgroundColor = [UIColor clearColor];
    _statusLabel.font = font;
    _statusLabel.textColor = [UIColor jrColorWithHex:@"#666666"];
//    _statusLabel.text = text;
    _statusLabel.numberOfLines = 0;
    [self addSubview:_statusLabel];
}



/*
 ***向左边拉动
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (![keyPath isEqualToString:kContentOffset] || ![object isKindOfClass:[UIScrollView class]]) return;
    
    
    CGFloat newX = self.scrollView.contentOffset.x;
    if (newX != _oldX ) {
         _oldX = newX;
    }
    else{
        return;
    }

    
//    NSLog(@"self.scrollView.contentOffset.x = %@", @(ceil(self.scrollView.contentOffset.x)));
    
    self.offSetX = self.scrollView.contentOffset.x - kDistance;
    CGFloat pointX = self.offSetX <= 0 ? 0 : self.offSetX;
    CGFloat pointW = self.offSetX <= 0 ? 0 : ABS(self.offSetX);
//    CGFloat pointH = CGRectGetHeight(self.scrollView.bounds);
    self.frame = CGRectMake(pointX, 0, pointW, self.elasticH);
   

//    CGFloat pointW = self.scrollView.contentSize.width;
//    CGFloat pointH = CGRectGetHeight(self.scrollView.frame);
//    CGFloat pointX = self.offSetX >= kAnimationDistance ? (pointW-kAnimationDistance) : (pointW -originX);
    
    // tips
    CGFloat width = self.scrollView.contentSize.width;
    pointX = self.offSetX >= kAnimationDistance ? (width-kAnimationDistance) : (width -self.offSetX);
//    CGRect rect = _statusLabel.frame;
//    rect.origin.x = pointX + (kAnimationDistance - rect.size.width)/2.f;
//    [_statusLabel setFrame:rect];
    
    CGFloat pointY = (self.elasticH - 56.f)/2.f;
    pointX = pointX + (kAnimationDistance - 11.f)/2.f;
    CGRect rect = CGRectMake(pointX, pointY, 11.f, 56.f);
    [_statusLabel setFrame:rect];
    // NSLog(@"pointX = %@", @(ceil(pointX)));
    
    if (self.offSetX >= kAnimationDistance + 5.f) {
        
        [_statusLabel setText:@"释放查看"];
    }
    else{
        
        [_statusLabel setText:@"查看更多"];
    }
    
    if (self.scrollView.dragging || self.offSetX < kAnimationDistance) {
        self.shapeLayer.path = [self calculateAnimaPathWithLeftOriginX:self.offSetX];
    }
    if (self.offSetX == 0) {
        self.endAniamtion = NO;
    }
    [self changeScrollViewProperty];
}

/*
- (void)changeScrollViewProperty {
    
    if (self.offSetX >= kAnimationDistance) {
        
        if (!self.scrollView.dragging && !self.endAniamtion) {
        
            [self.scrollView setContentOffset:CGPointMake(kDistance, 0) animated:NO];
            if (self.refreshBlock) {
                self.refreshBlock();
            }
            [self endRefresh];
//            [self elasticLayerAnimation];
        }
    } else {
        [self.shapeLayer removeAllAnimations];
    }
}
*/

- (void)changeScrollViewProperty {
    
    if (self.offSetX >= kAnimationDistance) {
        
        if (!self.scrollView.dragging) {
            
            [self.scrollView setContentOffset:CGPointMake(kDistance, 0) animated:NO];
            if (self.refreshBlock) {
                self.refreshBlock();
            }
            [self endRefresh];
            //            [self elasticLayerAnimation];
        }
    } else {
        [self.shapeLayer removeAllAnimations];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (flag) {
        self.shapeLayer.path = [self calculateAnimaPathWithLeftOriginX:ABS(kAnimationDistance)];
        [self.shapeLayer removeAnimationForKey:@"elasticAnimation"];
    }
}

- (void)endRefresh {
    
    self.endAniamtion = self.offSetX == 0 ? NO : YES;
    [self.shapeLayer removeAllAnimations];
    [self.scrollView setContentOffset:CGPointMake(kDistance, 0) animated:YES];
}



/*
 ***向左拉动
 */
- (CGPathRef) calculateAnimaPathWithLeftOriginX:(CGFloat)originX {

    CGFloat pointW = self.scrollView.contentSize.width;
//    CGFloat pointH = CGRectGetHeight(self.scrollView.frame);
    CGFloat pointH = self.elasticH;
    CGFloat pointX = self.offSetX >= kAnimationDistance ? (pointW-kAnimationDistance) : (pointW -originX);
    
    CGPoint topRightPoint = CGPointMake(pointW, 0);
    CGPoint topLeftPoint = CGPointMake(pointX, 0);
    CGPoint controlPoint = CGPointMake(pointW-originX, pointH * 0.5);
    CGPoint bottomLeftPoint = CGPointMake(pointX, pointH);
    CGPoint bottomRightPoint = CGPointMake(pointW, pointH);
    
  
//    UIBezierPath* aPath = [UIBezierPath bezierPath];
//    aPath.lineWidth = 5.0;
//    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
//    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
//    [aPath moveToPoint:topLeftPoint];
//    [aPath addQuadCurveToPoint:bottomLeftPoint controlPoint:controlPoint];
////    [aPath stroke];
//    return aPath.CGPath;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:topRightPoint];
    [bezierPath addLineToPoint:topLeftPoint];
    [bezierPath addQuadCurveToPoint:bottomLeftPoint controlPoint:controlPoint];
    [bezierPath addLineToPoint:bottomRightPoint];
    return bezierPath.CGPath;
}



- (void)elasticLayerAnimation {
    
    self.shapeLayer.path = [self calculateAnimaPathWithLeftOriginX:ABS(kAnimationDistance)];
    NSArray *pathValues = @[
                            (__bridge id)[self calculateAnimaPathWithLeftOriginX:ABS(self.offSetX)],
                            (__bridge id)[self calculateAnimaPathWithLeftOriginX:ABS(kAnimationDistance) * 0.7],
                            (__bridge id)[self calculateAnimaPathWithLeftOriginX:ABS(kAnimationDistance) * 1.3],
                            (__bridge id)[self calculateAnimaPathWithLeftOriginX:ABS(kAnimationDistance) * 0.9],
                            (__bridge id)[self calculateAnimaPathWithLeftOriginX:ABS(kAnimationDistance) * 1.1],
                            (__bridge id)[self calculateAnimaPathWithLeftOriginX:ABS(kAnimationDistance)]
                            ];
    CAKeyframeAnimation *elasticAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    elasticAnimation.values = pathValues;
    elasticAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    elasticAnimation.duration = 1;
    elasticAnimation.fillMode = kCAFillModeForwards;
    elasticAnimation.removedOnCompletion = NO;
    elasticAnimation.delegate = self;
    [self.shapeLayer addAnimation:elasticAnimation forKey:@"elasticAnimation"];
}

@end










