//
//  UIHorizontalView.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/28.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIHorizontalView.h"


@interface UIHorizontalView (){
    
    UIImage *_placeholderImage;
}
@end

@implementation UIHorizontalView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        // icon
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(42.5, 16.f, 60, 60)];
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
        pointY = CGRectGetMaxY(_imgView.frame) + 12;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, pointY, CGRectGetWidth(self.frame) - 20, 20.f)];
        _titleLabel.font = [UIFont getSystemFont:14.f Weight:KFontWeightMedium];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        // 副标题
        pointY = CGRectGetMaxY(_titleLabel.frame) + 4;
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, pointY, CGRectGetWidth(self.frame) - 20, 20.f)];
        _detailLabel.font = [UIFont getSystemFont:13.f Weight:KFontWeightRegular];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_detailLabel];
    }
    return self;
}


-(void) reloadData:(UIElementEntity *)entity{
    
    if (self.entity == entity) {
        return;
    }
    [super reloadData:entity];
    
    // backgroundColor
    if (entity.bgColor) {
        self.backgroundColor = [UIColor jrColorWithHex:entity.bgColor];
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
    
    // _imgView
    if(entity.imgUrl && ![entity.imgUrl isEqualToString:@""]){
        
        [_imgView sd_setImageWithURL:[NSURL URLWithString:entity.imgUrl] placeholderImage:_placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        }];
    }
    else{
        [_imgView setImage:_placeholderImage];
    }
    
    // _titleLabel
    if (!entity.titleColor) {
        entity.titleColor = @"#444444";
    }
    if (!entity.title1Color) {
        entity.title1Color = @"#FF801A";
    }
    
    UIFont *font = [UIFont getSystemFont:14.f Weight:KFontWeightMedium];
    UIColor *color1 = [UIColor jrColorWithHex:entity.titleColor];
    UIColor *color2 = [UIColor jrColorWithHex:entity.title1Color];
    NSString* text = [NSString stringWithFormat:@"%@%@",entity.title, entity.title1];
    NSDictionary* dic0 = [[NSDictionary alloc] initWithObjectsAndKeys:font,NSFontAttributeName, color1, NSForegroundColorAttributeName,nil];
    NSDictionary* dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:font,NSFontAttributeName, color2, NSForegroundColorAttributeName,nil];
    
    NSMutableAttributedString* _title = [[NSMutableAttributedString alloc] initWithString:text];
    [_title addAttributes:dic0 range:NSMakeRange(0, entity.title.length)];
    [_title addAttributes:dic1 range:NSMakeRange(entity.title.length, entity.title1.length)];
    
    _titleLabel.attributedText = _title;
    
    // _detailLabel
    if (entity.title2Color) {
        _detailLabel.textColor = [UIColor jrColorWithHex:entity.title2Color];
    }else{
        _detailLabel.textColor = [UIColor jrColorWithHex:@"#999999"];
    }
    _detailLabel.text = entity.title2;
}


@end
