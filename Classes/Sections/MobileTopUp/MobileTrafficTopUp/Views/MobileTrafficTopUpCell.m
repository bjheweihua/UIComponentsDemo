//
//  MobileTrafficTopUpCell.m
//  JDMobile
//
//  Created by heweihua on 16/4/28.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTrafficTopUpCell.h"
#import "MobileTrafficEntity.h"

#define kOffsetX           (16.0)
#define kPriceLabelWith    (68.0)
#define kPriceLabelHeight  (30.0)
#define kPriceButtonWith   (kPriceLabelWith + (kOffsetX*2))
#define kLLabelMaxWith     (kMainScreenW - kPriceButtonWith - kOffsetX)


@interface MobileTrafficTopUpCell () {
    
    MobileTrafficEntity *_entity;
}

@property(nonatomic, strong) UILabel* lUpLabel;   // 30M
@property(nonatomic, strong) UILabel* lDownLabel; // 订购后月底失效
@property(nonatomic, strong) UILabel* discoutLabel; // 惠

@property(nonatomic, strong) UILabel* priceLabel; // 9.98元
@property(nonatomic, strong) UIButton* priceBtn;
@end

@implementation MobileTrafficTopUpCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, kMainScreenW, kMobileTrafficTopUpCellH);
        
        
        // left 主标题
        CGRect rect = CGRectMake(kOffsetX, 14.0, kLLabelMaxWith, 25.0);
        _lUpLabel = [[UILabel alloc] initWithFrame:rect];
        _lUpLabel.backgroundColor = [UIColor clearColor];
        _lUpLabel.textColor = [UIColor jrColorWithHex:@"#444444"];
//        _lUpLabel.font = [UIFont systemFontOfSize:18.0 ];
        _lUpLabel.font = [UIFont getSanFranciscoFont:18.0 Weight:KSFWeightMedium];
        [self.contentView addSubview:_lUpLabel];
        
        //惠
        rect = CGRectMake(kLLabelMaxWith + 7.f, 14.0 + 3.5, 28.f, 18.0);
        _discoutLabel = [[UILabel alloc] initWithFrame:rect];
        _discoutLabel.backgroundColor = [UIColor jrColorWithHex:@"#ff801a"];
        _discoutLabel.textColor = [UIColor whiteColor];
        _discoutLabel.font = [UIFont getSystemFont:12.0 Weight:KFontWeightMedium];
        _discoutLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_discoutLabel];
        [_discoutLabel setText:@"惠"];
        _discoutLabel.hidden = YES;
        
        [self.contentView bringSubviewToFront:self.lineView];
        
        // left 副标题
        rect = _lUpLabel.frame;
        rect.origin.y = (CGRectGetMaxY(_lUpLabel.frame)) + 1.5f;
        rect.size.height = 16.5;
        _lDownLabel = [[UILabel alloc] initWithFrame:rect];
        _lDownLabel.backgroundColor = [UIColor clearColor];
        _lDownLabel.textColor = [UIColor jrColorWithHex:@"#999999"];
//        _lDownLabel.font = [UIFont getSystemFont:12.0 Weight:KFontWeightLight];
        _lDownLabel.font = [UIFont getSanFranciscoFont:12.0 Weight:KSFWeightRegular];
        [self.contentView addSubview:_lDownLabel];
        
        
        // 9.98元
        rect = CGRectMake(0, 0, kPriceLabelWith, kPriceLabelHeight);
        _priceLabel = [[UILabel alloc] initWithFrame:rect];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textColor = [UIColor jrColorWithHex:kBlueColor];
//        _priceLabel.font = [UIFont systemFontOfSize:14.0];
        _priceLabel.font = [UIFont getSanFranciscoFont:14.0 Weight:KSFWeightMedium];
        [_priceLabel setTextAlignment:NSTextAlignmentCenter];
        _priceLabel.layer.borderWidth = (1.0);
        [_priceLabel.layer setMasksToBounds:YES];
        [_priceLabel.layer setCornerRadius:2.0];
        _priceLabel.layer.borderColor = [[UIColor jrColorWithHex:kBlueColor] CGColor];
        
        // right button
        _priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _priceBtn.frame = CGRectMake(kMainScreenW - kPriceButtonWith, 0, kPriceButtonWith, kMobileTrafficTopUpCellH);
        _priceBtn.backgroundColor = [UIColor clearColor];
        [_priceBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_priceBtn];

        
        [self.contentView bringSubviewToFront:self.lineView];
        self.lineView.backgroundColor = [UIColor jrColorWithHex:@"#eeeeee"];
    }
    return self;
}


-(void) buttonClicked:(id)sender {
    
}



-(void) reloadData:(MobileTrafficEntity *)entity {
    
    _entity = entity;
    
    CGFloat poinW = [entity.faceAmountName jr_sizeWithFont:self.lUpLabel.font].width;
    if (poinW > kLLabelMaxWith) {
        poinW = kLLabelMaxWith;
    }
    CGRect rect = CGRectMake(kOffsetX, 14.0, poinW, 25.0);
    [_lUpLabel setFrame:rect];
    _lDownLabel.hidden = NO;
    
    if ([entity.desc isEqualToString:@""]) {
        
        CGFloat pointY = (kMobileTrafficTopUpCellH - 25.0)/2.0;
        rect = self.lUpLabel.frame;
        rect.origin.y = pointY;
        [_lUpLabel setFrame:rect];
        _lDownLabel.hidden = YES;
    }
    
    [self.lUpLabel setText:entity.faceAmountName]; // 30M
    [self.lDownLabel setText:entity.desc]; // 订购后月底失效
    [self.priceLabel setText:entity.salePriceName]; // 9.98元
    
    self.priceLabel.textColor = [UIColor jrColorWithHex:@"#cccccc"];
    self.priceLabel.layer.borderColor = [UIColor jrColorWithHex:@"#cccccc"].CGColor;
    [self.priceLabel setBackgroundColor:[UIColor whiteColor]];
    UIImage* imageDisabled = [UIImage jrImageFromView:self.priceLabel];
    
    self.priceLabel.textColor = [UIColor jrColorWithHex:kBlueColor];
    self.priceLabel.layer.borderColor = [UIColor jrColorWithHex:kBlueColor].CGColor;
    [self.priceLabel setBackgroundColor:[UIColor whiteColor]];
    UIImage* imageU = [UIImage jrImageFromView:self.priceLabel];
    
    self.priceLabel.textColor = [UIColor whiteColor];
    self.priceLabel.layer.borderColor = [UIColor jrColorWithHex:kBlueColor].CGColor;
    [self.priceLabel setBackgroundColor:[UIColor jrColorWithHex:kBlueColor]];
    UIImage* imageD = [UIImage jrImageFromView:self.priceLabel];
    
    [_priceBtn setImage:imageDisabled forState:UIControlStateDisabled];
    [_priceBtn setImage:imageU forState:UIControlStateNormal];
    [_priceBtn setImage:imageD forState:UIControlStateHighlighted];
    [_priceBtn setImage:imageD forState:UIControlStateSelected];
    [_priceBtn addTarget:self action:@selector(btnClicked:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    _priceBtn.enabled = entity.enabled;
    
    if (entity.enabled) {
        _lUpLabel.textColor = [UIColor jrColorWithHex:@"#444444"];
        _lDownLabel.textColor = [UIColor jrColorWithHex:@"#999999"];
    }
    else{
        _lUpLabel.textColor = [UIColor jrColorWithHex:@"#cccccc"];
        _lDownLabel.textColor = [UIColor jrColorWithHex:@"#cccccc"];
    }
    
    if (entity.enabled) {
        
        if (entity.discount == 1) {
            _discoutLabel.hidden = NO;
        }
        else{
            _discoutLabel.hidden = YES;
        }
    }
    else{
        _discoutLabel.hidden = YES;
    }

    // discout
    rect = _discoutLabel.frame;
    rect.origin.x = CGRectGetMaxX(self.lUpLabel.frame) + 7.f;
    rect.origin.y = CGRectGetMinY(self.lUpLabel.frame) + 3.5;
    _discoutLabel.frame = rect;
}



-(void) btnClicked:(UIButton*)btn withEvent:(UIEvent*)event{
    
    UITouch* touch = [[event allTouches] anyObject];
    if(touch.tapCount != 1) return;
    
    btn.selected = YES;
    [self performSelector:@selector(btnUnSelected:) withObject:btn afterDelay:0.2];
}



-(void) btnUnSelected:(UIButton*)btn{
    
    btn.selected = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchTrafficTopUp:)]) {
        [self.delegate didTouchTrafficTopUp:_entity];
    }
}

@end













