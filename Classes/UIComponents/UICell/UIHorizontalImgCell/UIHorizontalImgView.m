//
//  UIHorizontalView.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/28.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIHorizontalImgView.h"


@interface UIHorizontalImgView (){
    
    UIImage *_placeholderImage;
}
@end

@implementation UIHorizontalImgView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        // icon
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 90)];
        _imgView.userInteractionEnabled = NO;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        _imgView.backgroundColor = [UIColor clearColor];
        [self addSubview:_imgView];
        
        
        // placeholderImage
        UIImageView* pImgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brickChannelNoImage"]];
        CGFloat pointX = (CGRectGetWidth(_imgView.frame) - CGRectGetWidth(pImgview.frame))/2.f;
        CGFloat pointY = (CGRectGetHeight(_imgView.frame) - CGRectGetHeight(pImgview.frame))/2.f;
        [pImgview setFrame:CGRectMake(pointX, pointY, CGRectGetWidth(pImgview.frame), CGRectGetHeight(pImgview.frame))];
        UIView* pView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [pView addSubview:pImgview];
        pView.backgroundColor = [UIColor jrColorWithHex:@"#fafafa"];
        _placeholderImage = [UIImage jrImageFromView:pView];
        [_imgView setImage:_placeholderImage];
        
        // 主标题
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(10, CGRectGetMaxY(_imgView.frame) + 9, CGRectGetWidth(self.frame) - 2 * 10, 36);
        _titleLabel.font = [UIFont getSystemFont:13.0 Weight:KFontWeightMedium];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 2;
        [self addSubview:_titleLabel];
    }
    return self;
}


//赋值
-(void) reloadData:(UIElementEntity *)entity{
    
    [super reloadData:entity];
    
    if (entity.bgColor) {
        self.backgroundColor = [UIColor jrColorWithHex:entity.bgColor];
    }else{
        self.backgroundColor = [UIColor jrColorWithHex:@"#FFFFFF"];
    }
    
    // _imgView
    if(entity.imgUrl && ![entity.imgUrl isEqualToString:@""]){
        
        [_imgView sd_setImageWithURL:[NSURL URLWithString:entity.imgUrl] placeholderImage:_placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        }];
    }
    else{
        [_imgView setImage:_placeholderImage];
    }
    
    if (entity.titleColor) {
        
        _titleLabel.textColor = [UIColor jrColorWithHex:entity.titleColor];
    }else{
        _titleLabel.textColor = [UIColor jrColorWithHex:@"#666666"];
    }
    
    if (entity.title) {
        NSMutableParagraphStyle* par = [[NSMutableParagraphStyle alloc] init];
        [par setLineSpacing:3.f];//0
        NSMutableAttributedString* att = [[NSMutableAttributedString alloc] initWithString:entity.title];
        [att addAttribute:NSParagraphStyleAttributeName value:par range:NSMakeRange(0, [entity.title length])];
        _titleLabel.attributedText = att;
    }else{
        _titleLabel.attributedText = nil;
    }
}


@end
