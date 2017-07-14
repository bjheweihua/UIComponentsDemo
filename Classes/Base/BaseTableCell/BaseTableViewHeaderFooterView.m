//
//  BaseTableViewHeaderFooterView.m
//  JDMobile
//
//  Created by heweihua on 16/3/8.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "BaseTableViewHeaderFooterView.h"
#import "UIImage+Additions.h"


#define kOffsetX (16.0)
#define kRightArrowW (12.)
#define kRightArrowH (12.)


@implementation BaseTableViewHeaderFooterView

-(instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self){
        
        self.frame = CGRectMake(0, 0, kMainScreenW, kBaseTableHeaderFooterH);
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentBtn setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
//        UIImage* imageU = [UIImage jrCreateImageWithColor:[UIColor whiteColor] rect:_contentBtn.bounds];
//        UIImage* imageD = [UIImage jrCreateImageWithColor:[UIColor jrColorWithHex:@"#f2f2f2"] rect:_contentBtn.bounds];
        UIImage* imageU = [UIImage jrCreateImageWithColor:[UIColor clearColor] rect:_contentBtn.bounds];
        UIImage* imageD = [UIImage jrCreateImageWithColor:[UIColor colorWithWhite:0 alpha:.05] rect:_contentBtn.bounds];
        [_contentBtn setBackgroundImage:imageU forState:UIControlStateDisabled];
        [_contentBtn setBackgroundImage:imageU forState:UIControlStateNormal];
        [_contentBtn setBackgroundImage:imageD forState:UIControlStateHighlighted];
        [_contentBtn setBackgroundImage:imageD forState:UIControlStateSelected];
        [_contentBtn addTarget:self action:@selector(headerFooterClicked:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_contentBtn];

        
        //右箭头
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"com_arrow_to_right"]];
        CGFloat pointY = (CGRectGetHeight(self.frame) - kRightArrowH)/2;
        _arrowView.frame = CGRectMake(kMainScreenW - kOffsetX - kRightArrowW, pointY, kRightArrowW, kRightArrowH);
        [_contentBtn addSubview:_arrowView];
//        _arrowView.hidden = YES;
        
        // left
        UIFont* font = [UIFont systemFontOfSize:16.f];
        CGSize size = [@"计算高度" jr_sizeWithFont:font];
        pointY = (CGRectGetHeight(self.frame) - size.height)/2.f;
        CGRect rect = CGRectMake(kOffsetX, pointY, kMainScreenW/2.f - kOffsetX, size.height);
        _leftTextLabel = [[UILabel alloc] initWithFrame:rect];
        [_leftTextLabel setBackgroundColor:[UIColor clearColor]];
        [_leftTextLabel setTextColor:[UIColor jrColorWithHex:@"#333333"]];
        [_leftTextLabel setFont:font];
        [_contentBtn addSubview:_leftTextLabel];
        
        // right
        rect = CGRectMake(kMainScreenW/2.f, pointY, kMainScreenW/2.f - kOffsetX - kRightArrowW -10, size.height);
        _rightTextLabel = [[UILabel alloc] initWithFrame:rect];
        [_rightTextLabel setBackgroundColor:[UIColor clearColor]];
        [_rightTextLabel setTextColor:[UIColor jrColorWithHex:@"#999999"]];
        [_rightTextLabel setFont:font];
        [_rightTextLabel setTextAlignment:NSTextAlignmentRight];
        [_contentBtn addSubview:_rightTextLabel];
        
        
        // line
        CGFloat pointhH = GetPointWith(0.5);
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - pointhH, kMainScreenW, pointhH)];
        [_lineView setBackgroundColor:[UIColor jrColorWithHex:kLineColor]];
        [_contentBtn addSubview:_lineView];
//        _lineView.hidden = YES;
        
        
//        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
//        [self addGestureRecognizer:gesture];
    }
    return self;
}



//-(void) handleTapGesture:(UITapGestureRecognizer*)gesture {
//}
-(void) headerFooterClicked:(UIButton*)btn withEvent:(UIEvent*)event{
    
    UITouch* touch = [[event allTouches] anyObject];
    if(touch.tapCount != 1) return;
    
    btn.selected = YES;
    [self performSelector:@selector(btnUnSelected:) withObject:btn afterDelay:0.2];
}



-(void) btnUnSelected:(UIButton*)btn{
    
    btn.selected = NO;
    [self headerFooterClicked];
}



-(void) headerFooterClicked {
    
}
@end









