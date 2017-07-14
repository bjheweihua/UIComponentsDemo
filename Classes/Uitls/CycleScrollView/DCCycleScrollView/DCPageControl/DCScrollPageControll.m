//
//  DCScrollPageControll.m
//  JDMobile
//
//  Created by shenghuihan on 2017/1/12.
//  Copyright © 2017年 jr. All rights reserved.
//

#import "DCScrollPageControll.h"

@interface DCScrollPageControll()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIView *indicaForView;
@property (nonatomic, assign) BOOL isScrolling;
@end

@implementation DCScrollPageControll
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor jrColorWithHex:@"#FFFFFF"];
        [self createSubViews];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)createSubViews {
    [self addSubview:self.backView];
    [self addSubview:self.indicatorView];
}

- (void)layoutSubviews {
    self.backView.minX = 0.01;
    self.backView.minY = 0.01;
    
}

- (void)setItemCount:(CGFloat)count {
    if (count == 0) return;
    self.indicatorView.width = self.backView.width / count * 1.0 + 2.0;
}

- (void)setIndicatorX:(CGFloat)offsetX {
    if (self.indicatorView.width == 0) return;
    self.indicatorView.minX = offsetX;
}

- (void)isScrolling:(BOOL)isScrollling {
    
    if (isScrollling) {
        if (self.isScrolling) return;
        
        UIView *tempView = [[UIView alloc] initWithFrame:self.indicatorView.bounds];
        tempView.layer.cornerRadius = 1;
        tempView.clipsToBounds = YES;
        [self.indicatorView addSubview:tempView];
        [self.indicaForView removeFromSuperview];
        self.indicaForView = nil;
        self.indicaForView = tempView;
        self.backView.backgroundColor = [UIColor jrColorWithHex:@"#D8D8D8" withAlpha:0.5];
        self.indicatorView.backgroundColor = [UIColor clearColor];
        self.indicaForView.backgroundColor = [UIColor jrColorWithHex:@"#525252" withAlpha:0.7];

    }else {
        
        @JDJRWeakify(self);
        [UIView animateWithDuration:3 animations:^{
            @JDJRStrongify(self);
            self.backView.backgroundColor = [UIColor jrColorWithHex:@"#F3F3F3" withAlpha:0.5];
            self.indicaForView.backgroundColor = [UIColor jrColorWithHex:@"#CBCBCB" withAlpha:0.9];
        }completion:^(BOOL finished) {

        }];
    }
    self.isScrolling = isScrollling;
}

#pragma mark - getter and setter
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.size = CGSizeMake(100,2);
        _backView.backgroundColor = [UIColor jrColorWithHex:@"#F3F3F3" withAlpha:0.5];
    }
    return _backView;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.frame = CGRectMake(0, 0, 0, 2);
        _indicatorView.backgroundColor = [UIColor jrColorWithHex:@"#CBCBCB" withAlpha:0.9];
    }
    return _indicatorView;
}

@end
