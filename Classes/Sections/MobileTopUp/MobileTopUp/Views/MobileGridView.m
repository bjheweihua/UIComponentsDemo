//
//  MobileGridView.m
//  JDMobile
//
//  Created by heweihua on 16/4/19.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileGridView.h"
#import "BillEntity.h"

@interface MobileGridView (){
    
    UIView* _bgviewNormal;
    UIView* _bgviewDisabled;
    BillEntity* _entity;
}
@end



@implementation MobileGridView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _entity = nil;
        self.backgroundColor = [UIColor whiteColor];
        _contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentBtn setBackgroundColor:[UIColor whiteColor]];
        [_contentBtn setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        [self addSubview:_contentBtn];

        
        CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        _bgviewNormal = [[UIView alloc] initWithFrame:rect];
        [_bgviewNormal setBackgroundColor:[UIColor whiteColor]];
        _bgviewNormal.layer.borderWidth = SINGLE_LINE_HEIGHT(1.f);//SINGLE_LINE_HEIGHT(1.0);
        [_bgviewNormal.layer setMasksToBounds:YES];
//        [_bgviewNormal.layer setCornerRadius:2.0];
//        _bgviewNormal.layer.borderColor = [[UIColor jrColorWithHex:kBlueColor] CGColor];
        [_bgviewNormal.layer setCornerRadius:2.0];
        _bgviewNormal.layer.borderColor = [[UIColor clearColor] CGColor];
        
        
        rect = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        _bgviewDisabled = [[UIView alloc] initWithFrame:rect];
        [_bgviewDisabled setBackgroundColor:[UIColor whiteColor]];
        _bgviewDisabled.layer.borderWidth = 1.0;//SINGLE_LINE_HEIGHT(2.0);
        [_bgviewDisabled.layer setMasksToBounds:YES];
//        [_bgviewDisabled.layer setCornerRadius:2.0];
//        _bgviewDisabled.layer.borderColor = [[UIColor jrColorWithHex:@"#eeeeee"] CGColor];
        [_bgviewDisabled.layer setCornerRadius:2.0];
        _bgviewDisabled.layer.borderColor = [[UIColor clearColor] CGColor];
        
        // @"10元"
        CGFloat pointX = 10.f;
        CGFloat maxWidth = kGridCellW - pointX*2;
        rect = CGRectMake(pointX, 10.0, maxWidth, 25.f);
        _titleLabel = [[UILabel alloc] initWithFrame:rect];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor jrColorWithHex:kBlueColor];
//        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        _titleLabel.font = [UIFont getSanFranciscoFont:16.0 Weight:KSFWeightMedium];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES; // 自动缩小
        _titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        [_bgviewNormal addSubview:_titleLabel];
        
        // 售价10.00元
        rect = CGRectMake(pointX, CGRectGetMaxY(_titleLabel.frame) + 1.f, maxWidth, 16.5);
        _subtitleLabel = [[UILabel alloc] initWithFrame:rect];
        _subtitleLabel.backgroundColor = [UIColor clearColor];
        _subtitleLabel.textColor = [UIColor jrColorWithHex:kBlueColor];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
//        _subtitleLabel.font = [UIFont systemFontOfSize:12.f];
        _subtitleLabel.font = [UIFont getSanFranciscoFont:12.0 Weight:KSFWeightMedium];
        _subtitleLabel.adjustsFontSizeToFitWidth = YES; // 自动缩小
        _subtitleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        [_bgviewNormal addSubview:_subtitleLabel];

        
        // 不可点击显示的文案  @"10元";
        rect = _titleLabel.frame;
        rect.origin.y = (CGRectGetHeight(self.frame) - CGRectGetHeight(rect))/2.f;
        _titleLabelDisabled = [[UILabel alloc] initWithFrame:rect];
        _titleLabelDisabled.backgroundColor = [UIColor clearColor];
        _titleLabelDisabled.textColor = [UIColor jrColorWithHex:@"#cccccc"];
//        _titleLabelDisabled.font = [UIFont systemFontOfSize:18.0];
        _titleLabelDisabled.font = [UIFont getSanFranciscoFont:18.0 Weight:KSFWeightMedium];
        _titleLabelDisabled.textAlignment = NSTextAlignmentCenter;
        _titleLabelDisabled.adjustsFontSizeToFitWidth = YES; // 自动缩小
        _titleLabelDisabled.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        [_bgviewDisabled addSubview:_titleLabelDisabled];
        
        
        UIImage* imageDisabled = [UIImage jrImageFromView:_bgviewDisabled];
        [_titleLabel setTextColor:[UIColor jrColorWithHex:kBlueColor]];
        [_subtitleLabel setTextColor:[UIColor jrColorWithHex:kBlueColor]];
        [_bgviewNormal setBackgroundColor:[UIColor whiteColor]];
        UIImage* imageU = [UIImage jrImageFromView:_bgviewNormal];
        
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_subtitleLabel setTextColor:[UIColor whiteColor]];
        [_bgviewNormal setBackgroundColor:[UIColor jrColorWithHex:kBlueColor]];
        UIImage* imageD = [UIImage jrImageFromView:_bgviewNormal];
        
        [_contentBtn setBackgroundImage:imageDisabled forState:UIControlStateDisabled];
        [_contentBtn setBackgroundImage:imageU forState:UIControlStateNormal];
        [_contentBtn setBackgroundImage:imageD forState:UIControlStateHighlighted];
        [_contentBtn addTarget:self action:@selector(btnClicked:withEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _contentBtn.backgroundColor = [UIColor clearColor];
//        _contentBtn.layer.borderWidth = 1;
        [_contentBtn.layer setCornerRadius:3.f];
        _contentBtn.layer.borderColor = [[UIColor clearColor] CGColor];
        
        //加阴影
        _contentBtn.layer.shadowColor = [UIColor jrColorWithHex:kBlueColor].CGColor;//shadowColor阴影颜色
        _contentBtn.layer.shadowOffset = CGSizeMake(0.5, 2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        _contentBtn.layer.shadowOpacity = 0.07;//阴影透明度，默认0
        _contentBtn.layer.shadowRadius = 2;//阴影半径，默认3
        
        UIImage* image = [UIImage imageNamed:@"mobiletopup_hui"];
        rect = CGRectMake(CGRectGetWidth(self.frame) - image.size.width, 0, image.size.width, image.size.height);
        _labelImageview = [[UIImageView alloc] initWithFrame:rect];
        [_labelImageview setImage:image];
        [_labelImageview setBackgroundColor:[UIColor clearColor]];
        [_contentBtn addSubview:_labelImageview];
        _labelImageview.hidden = YES;
    }
    return self;
}


-(void) reloadData:(BillEntity *)entity{
    
    _entity = entity;
    
    CGFloat pointX = 10.f;
    CGFloat maxWidth = kGridCellW - pointX*2;
    CGRect rect = CGRectMake(pointX, 10.0, maxWidth, 25.f);
    [_titleLabel setFrame:rect];
    _subtitleLabel.hidden = NO;
    if (1 == entity.billType){
        
        CGFloat pointX = 10.f;
        CGFloat pointY = (CGRectGetHeight(_bgviewNormal.frame) - 25.f)/2;
        CGFloat maxWidth = kGridCellW - pointX*2;
        CGRect rect = CGRectMake(pointX, pointY, maxWidth, 25.f);
        [_titleLabel setFrame:rect];
        _subtitleLabel.hidden = YES;
    }
    [_titleLabel setText:entity.facePriceName];
    [_subtitleLabel setText:entity.jdPriceName];
    [_titleLabelDisabled setText:entity.facePriceName];
    
    UIImage* imageDisabled = [UIImage jrImageFromView:_bgviewDisabled];
    
    [_titleLabel setTextColor:[UIColor jrColorWithHex:kBlueColor]];
    [_subtitleLabel setTextColor:[UIColor jrColorWithHex:kBlueColor]];
    [_bgviewNormal setBackgroundColor:[UIColor whiteColor]];
    UIImage* imageU = [UIImage jrImageFromView:_bgviewNormal];
    
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_subtitleLabel setTextColor:[UIColor whiteColor]];
    [_bgviewNormal setBackgroundColor:[UIColor jrColorWithHex:kBlueColor]];
    UIImage* imageD = [UIImage jrImageFromView:_bgviewNormal];
    
    [_contentBtn setBackgroundImage:imageDisabled forState:UIControlStateDisabled];
    [_contentBtn setBackgroundImage:imageU forState:UIControlStateNormal];
    [_contentBtn setBackgroundImage:imageD forState:UIControlStateHighlighted];
    [_contentBtn setBackgroundImage:imageD forState:UIControlStateSelected];
    [_contentBtn addTarget:self action:@selector(btnClicked:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    _contentBtn.enabled = entity.enabled;
    
    if (entity.discount == 1) {
        [_labelImageview setImage:[UIImage imageNamed:@"mobiletopup_hui"]];
        _labelImageview.hidden = NO;
    }
    else if (entity.discount == 2){
        [_labelImageview setImage:[UIImage imageNamed:@"mobiletopup_free"]];
        _labelImageview.hidden = NO;
    }
    else{
        [_labelImageview setImage:nil];
        _labelImageview.hidden = YES;
    }
    
    if (_contentBtn.enabled) {
        //加阴影
        _contentBtn.layer.shadowColor = [UIColor jrColorWithHex:kBlueColor].CGColor;
    }
    else{
        //加阴影
        _contentBtn.layer.shadowColor = [UIColor jrColorWithHex:@"#d8d8d8"].CGColor;
        _labelImageview.hidden = YES;
    }
}




-(void) btnClicked:(UIButton*)btn withEvent:(UIEvent*)event{
    
    UITouch* touch = [[event allTouches] anyObject];
    if(touch.tapCount != 1) return;
    
    btn.selected = YES;
    [self performSelector:@selector(btnUnSelected:) withObject:btn afterDelay:0.1];
}


-(void) btnUnSelected:(UIButton*)btn{
    
    btn.selected = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchMobileGrid:)]) {
        [self.delegate didTouchMobileGrid:_entity];
    }
}


@end






