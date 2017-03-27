//
//  UIBaseTableCell.m
//  JDMobile
//
//  Created by heweihua on 15/7/7.
//  Copyright (c) 2015年 jr. All rights reserved.
//

#import "UIBaseTableCell.h"


@interface UIBaseTableCell (){
}
@end

@implementation UIBaseTableCell


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        // 系统的小箭头
        [self setAccessoryType:UITableViewCellAccessoryNone];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        _clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [_clickBtn setBackgroundColor:[UIColor clearColor]];
        [_clickBtn addTarget:self action:@selector(btnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_clickBtn];
        
//        CGFloat pointH = GetPointWith(0.5);
        CGFloat pointH = 0.5;
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - pointH, kMainScreenW, pointH)];
        [_lineView setBackgroundColor:[UIColor jrColorWithHex:@"#eeeeee"]];
        [self.contentView addSubview:_lineView];
        _lineView.hidden = YES;
    }
    return self;
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


-(void) setLineType:(ELineType)lineType{
    
    CGFloat pointH = GetPointWith(0.5);
    if (lineType == EBottomLongLine){
        [_lineView setFrame:CGRectMake(0, self.frame.size.height - pointH, kMainScreenW, pointH)];
        _lineView.hidden = NO;
    }
    else if (lineType == EBottomShortLine){
        [_lineView setFrame:CGRectMake(kOffsetX, self.frame.size.height - pointH, kMainScreenW-kOffsetX, pointH)];
        _lineView.hidden = NO;
    }
    else if (lineType == ETopLongLine){
        [_lineView setFrame:CGRectMake(0, 0, kMainScreenW, pointH)];
        _lineView.hidden = NO;
    }
    else if (lineType == ETopShortLine){
        [_lineView setFrame:CGRectMake(kOffsetX, 0, kMainScreenW-kOffsetX, pointH)];
        _lineView.hidden = NO;
    }
    else{
        _lineView.hidden = YES;
    }
}


-(void)reloadData:(BaseEntity*)entity{
    
    if (entity == self.entity) {
        return;
    }
    self.entity = entity;
    self.height = entity.height;
    self.clickBtn.height = entity.height;
    
    if (self.bHighLight) {
        UIColor * selectColor = [UIColor jrColor:[UIColor blackColor] withAlpha:0.05f];
        [_clickBtn setBackgroundImage:[UIImage jrCreateImageWithColor:selectColor rect:_clickBtn.bounds] forState:UIControlStateHighlighted];
        [_clickBtn setBackgroundImage:[UIImage jrCreateImageWithColor:selectColor rect:_clickBtn.bounds] forState:UIControlStateSelected];
    }else{
        [_clickBtn setBackgroundImage:nil forState:UIControlStateHighlighted];
        [_clickBtn setBackgroundImage:nil forState:UIControlStateSelected];
    }
}



@end





