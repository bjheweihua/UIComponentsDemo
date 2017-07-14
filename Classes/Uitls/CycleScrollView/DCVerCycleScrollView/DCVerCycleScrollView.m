//
//  DCVerCycleScrollView.m
//  
//
//  Created by shenghuihan on 2017/1/5.
//
//

#import "DCVerCycleScrollView.h"
#import "NSTimer+Blocks.h"

@interface DCVerCycleScrollView()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *downView;
@property (nonatomic, strong) NSArray *itemArr;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL canTouch;
@end

@implementation DCVerCycleScrollView

- (void)dealloc {
    [self.timer invalidate];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        [self createSubViews];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)reloadArr:(NSArray <DCVerCycleModel *>*)titleArr {
    
    [self.timer invalidate];
    self.timer  = nil;
    
    self.itemArr = [titleArr copy];
 
    [self resetTopAndDownViews];

}

- (void)resetTopAndDownViews {
    
    [self.topView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.downView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (self.itemArr.count) {
        if (self.itemArr.count == 1) {
            DCVerCycleModel *model = self.itemArr.firstObject;
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            titleLabel.font = [UIFont getSystemFont:14 Weight:KFontWeightRegular];
            titleLabel.textColor = [UIColor jrColorWithHex:@"#555555"];
            titleLabel.text = model.titleString;
            [titleLabel sizeToFit];
            CGFloat maxWidth = self.width;
            if (titleLabel.width > maxWidth) {
                titleLabel.width = maxWidth;
            }
            
            [self.topView addSubview:titleLabel];
            titleLabel.midY = self.topView.height * 0.5;
            self.index = 0;
            
            self.topView.minY = 0;
            self.downView.minY = self.height;
        }else {
            DCVerCycleModel *model = self.itemArr.firstObject;
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            titleLabel.font = [UIFont getSystemFont:14 Weight:KFontWeightRegular];
            titleLabel.textColor = [UIColor jrColorWithHex:@"#555555"];
            titleLabel.text = model.titleString;
            [titleLabel sizeToFit];
            CGFloat maxWidth = self.width;
            if (titleLabel.width > maxWidth) {
                titleLabel.width = maxWidth;
            }
            
            [self.topView addSubview:titleLabel];
            titleLabel.midY = self.topView.height * 0.5;
            self.index = 0;
            
            DCVerCycleModel *model1 = self.itemArr[1];
            UILabel *titleLabel1 = [[UILabel alloc] init];
            titleLabel1.lineBreakMode = NSLineBreakByTruncatingTail;
            titleLabel1.font = [UIFont getSystemFont:14 Weight:KFontWeightRegular];
            titleLabel1.textColor = [UIColor jrColorWithHex:@"#555555"];
            titleLabel1.text = model1.titleString;
            [titleLabel1 sizeToFit];
            if (titleLabel1.width > maxWidth) {
                titleLabel1.width = maxWidth;
            }

            [self.downView addSubview:titleLabel1];
            titleLabel1.midY = self.downView.height * 0.5;
            
            self.topView.minY = 0;
            self.downView.minY = self.height;
            
            [self startTimer];
        }
    }
}

- (void)createSubViews {
    [self addSubview:self.topView];
    self.topView.size = CGSizeMake(kMainScreenW - 42.5, self.size.height);;
    
    [self addSubview:self.downView];
    self.downView.size = CGSizeMake(kMainScreenW - 42.5, self.size.height);
    self.downView.minY = self.height;
}

- (void)startTimer {
    
    __weak typeof(self) weakSelf = self;
    CGFloat timeInter = 3;
    if (self.autoScrollTimeInterval) {
        timeInter = self.autoScrollTimeInterval;
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInter block:^{
        [weakSelf startToScroll];
//        NSLog(@"notice滚动了一下");
    } repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)startToScroll {
    __weak typeof(self) weakSelf = self;
    self.canTouch = NO;
    
    CGFloat duration = 1;
    if (self.durantion) {
        duration = self.durantion;
    }
    
    [UIView animateWithDuration:duration animations:^{
        weakSelf.topView.maxY = 0;
        weakSelf.downView.minY = 0;
    } completion:^(BOOL finished) {
        weakSelf.canTouch = YES;
        weakSelf.index ++;
        if (weakSelf.index == weakSelf.itemArr.count) {
            weakSelf.index = 0;
        }
        
        weakSelf.topView.hidden = YES;
        weakSelf.topView.minY = weakSelf.height;
        weakSelf.topView.hidden = NO;
        
        UIView *tempView = weakSelf.topView;
        weakSelf.topView = weakSelf.downView;
        weakSelf.downView = tempView;
        
        UILabel *label = nil;
        for (UIView *item in weakSelf.downView.subviews) {
            if ([item isKindOfClass:[UILabel class]]) {
                label = (UILabel *)item;
            }
        }
        
        NSInteger indexN = weakSelf.index + 1;
        if (indexN == weakSelf.itemArr.count) {
            indexN = 0;
            DCVerCycleModel *model = weakSelf.itemArr.firstObject;
            label.text = model.titleString;
            [label sizeToFit];
            
            CGFloat maxWidth = self.width;
            if (label.width > maxWidth) {
                label.width = maxWidth;
            }
        }else {
            DCVerCycleModel *model = weakSelf.itemArr[indexN];
            label.text = model.titleString;
            [label sizeToFit];
            
            CGFloat maxWidth = self.width;
            if (label.width > maxWidth) {
                label.width = maxWidth;
            }
        }
    }];
}

- (void)tapView {
    if (self.canTouch || self.itemArr.count == 1) {
        DCVerCycleModel *model = [self.itemArr objectAtIndexCheck:self.index];
        if (self.clickBlock) {
            self.clickBlock(model,self.index);
        }
    }
}

#pragma mark - getter and setter
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.size = CGSizeMake(0,0);
        _topView.backgroundColor = [UIColor jrColorWithHex:@"#ffffff"];
    }
    return _topView;
}

- (UIView *)downView {
    if (!_downView) {
        _downView = [[UIView alloc] init];
        _downView.size = CGSizeMake(0,0);
        _downView.backgroundColor = [UIColor jrColorWithHex:@"#ffffff"];
    }
    return _downView;
}

@end
