//
//  UINoticeView.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/27.
//  Copyright © 2017年 heweihua. All rights reserved.
// Copyright © 2017年 jr. All rights reserved.
//

#import "UINoticeView.h"
#import "UICellEntity.h"

@implementation UINoticeView

- (void)dealloc {
    NSLog(@"%s",__func__);
}


-(instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.bHighLight = NO;
        self.clipsToBounds = YES;
        
        _topLabel = [[UILabel alloc] init];
        _topLabel.font = [UIFont getSystemFont:14 Weight:KFontWeightRegular];
        _topLabel.textColor = [UIColor jrColorWithHex:@"#555555"];
        [self addSubview:_topLabel];
        
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.font = [UIFont getSystemFont:14 Weight:KFontWeightRegular];
        _bottomLabel.textColor = [UIColor jrColorWithHex:@"#555555"];
        [self addSubview:_bottomLabel];
    }
    return self;
}



- (void)reloadData:(UIElementEntity *) entity {
    
    _topLabel.text = ((UIElementEntity*)self.entity).title;
    _topLabel.textColor = [UIColor jrColorWithHex:((UIElementEntity*)entity).titleColor];
    CGRect frame = self.frame;
    frame.origin.y = 0;
    frame.origin.x = 0;
    _topLabel.frame = frame;
    frame.origin.y = self.frame.size.height;
    _bottomLabel.frame = frame;
    
    BOOL haveLastModel = self.entity?YES:NO;
    [super reloadData:entity];
    _bottomLabel.text = entity.title;
    _bottomLabel.textColor = [UIColor jrColorWithHex:entity.titleColor];
    if (!haveLastModel) {
        _topLabel.text = entity.title;
        _topLabel.textColor = [UIColor jrColorWithHex:((UIElementEntity*)entity).titleColor];
        return;
    }
    [UIView animateWithDuration:1 animations:^{
        _topLabel.minY = -self.height;
        _bottomLabel.minY = 0;
    } completion:^(BOOL finished) {
        
    }];
}


@end









