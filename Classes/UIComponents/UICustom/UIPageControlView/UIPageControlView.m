//
//  UIPageControlView.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//



#import "UIPageControlView.h"
#import "UICellEntity.h"

#define kIndicatorWith (2.0)

@interface UIPageControlView()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIView *indicaForView;
@property (nonatomic, assign) BOOL isScrolling;
@end


@implementation UIPageControlView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createSubViews];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)createSubViews {
    
    [self addSubview:self.contentView];
    [self addSubview:self.indicatorView];
}

- (void)layoutSubviews {
    
    self.contentView.minX = 0.01;
    self.contentView.minY = 0.01;
}

- (void)setItemCount:(CGFloat)count {
    
    if (count == 0)
        return;
    self.indicatorView.width = self.contentView.width / count * 1.0 + kIndicatorWith;
}

- (void)setIndicatorX:(CGFloat)offsetX {
    
    if (self.indicatorView.width == 0)
        return;
    self.indicatorView.minX = offsetX;
}

- (void)isScrolling:(BOOL)isScrollling {
    
    if (isScrollling) {
        
        if (self.isScrolling)
            return;
        
        UIView *tempView = [[UIView alloc] initWithFrame:self.indicatorView.bounds];
        tempView.layer.cornerRadius = 1;
        tempView.clipsToBounds = YES;
        [self.indicatorView addSubview:tempView];
        [self.indicaForView removeFromSuperview];
        self.indicaForView = nil;
        self.indicaForView = tempView;
        self.contentView.backgroundColor = [UIColor jrColorWithHex:@"#D8D8D8" withAlpha:0.5];
        self.indicaForView.backgroundColor = [UIColor jrColorWithHex:@"#525252" withAlpha:0.7];
        
    }else {
        
//        @JDJRWeakify(self);
        [UIView animateWithDuration:3 animations:^{
//            @JDJRStrongify(self);
            self.contentView.backgroundColor = [UIColor jrColorWithHex:@"#F3F3F3" withAlpha:0.5];
            self.indicaForView.backgroundColor = [UIColor jrColorWithHex:@"#CBCBCB" withAlpha:0.9];
        }completion:^(BOOL finished) {
            
        }];
    }
    self.isScrolling = isScrollling;
}


#pragma mark - getter and setter
- (UIView *)contentView {
    
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.size = CGSizeMake(100, kIndicatorWith);
        _contentView.backgroundColor = [UIColor jrColorWithHex:@"#F3F3F3" withAlpha:0.5];
    }
    return _contentView;
}

- (UIView *)indicatorView {
    
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.frame = CGRectMake(0, 0, 0, kIndicatorWith);
        _indicatorView.backgroundColor = [UIColor jrColorWithHex:@"#CBCBCB" withAlpha:0.9];
    }
    return _indicatorView;
}


@end


