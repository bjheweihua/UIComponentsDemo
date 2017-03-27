//
//  UIBaseHeaderFooterView.m
//  ClassmateParty
//
//  Created by heweihua on 15/7/26.
//  Copyright (c) 2015年 heweihua. All rights reserved.
//

#import "UIBaseHeaderFooterView.h"

@implementation UIBaseHeaderFooterView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.frame = CGRectMake(0, 0, kMainScreenW, kHeaderFooterH);
        self.contentView.backgroundColor = [UIColor clearColor];
        
//        UIFont* font = [UIFont getJRDefaultChinaFont:10.f];
//        CGSize size = [@"计算高度" jr_sizeWithFont:font];
//        CGFloat pointY = (kHeaderFooterH - size.height)/2.f;
//        CGRect rect = CGRectMake(kOffsetX, pointY, kMainScreenW - 2*kOffsetX, size.height);
//        _titleLabel = [[UILabel alloc] initWithFrame:rect];
//        [_titleLabel setBackgroundColor:[UIColor clearColor]];
//        [_titleLabel setTextColor:[UIColor jrColorWithHex:@"#b2b2b2"]];
//        [_titleLabel setFont:font];
//        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

//- (void) layoutSubviews
//{
//    [super layoutSubviews];
//    // self.textLabel 重新布局
//    CGRect rect = _titleLabel.frame;
//    rect.origin.y = (CGRectGetHeight(self.frame) - rect.size.height)/2;
//    _titleLabel.frame = rect;
//}


@end
