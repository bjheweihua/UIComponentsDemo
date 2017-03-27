//
//  UIBannerCollectionCell.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIBannerCollectionCell.h"
#import "UICellEntity.h"


@interface UIBannerCollectionCell (){

    UIImage* _placeholderImage;
}
@property (nonatomic, strong) UIImageView* imgView;
@end

@implementation UIBannerCollectionCell

-(instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, CGRectGetHeight(self.frame))];
        _imgView.backgroundColor = [UIColor clearColor];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        [self.contentView addSubview:_imgView];
        
        UIImageView* placeImgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brickChannelNoImage"]];
        CGFloat pointX = (kMainScreenW - CGRectGetWidth(placeImgv.frame))/2.f;
        CGFloat pointY = (CGRectGetHeight(self.frame) - CGRectGetHeight(placeImgv.frame))/2.f;
        [placeImgv setFrame:CGRectMake(pointX, pointY, CGRectGetWidth(placeImgv.frame), CGRectGetHeight(placeImgv.frame))];
        UIView* placeholderview = [[UIImageView alloc] initWithFrame:_imgView.frame];
        [placeholderview addSubview:placeImgv];
        placeholderview.backgroundColor = [UIColor jrColorWithHex:@"#fafafa"];
        _placeholderImage = [UIImage jrImageFromView:placeholderview];
        [_imgView setImage:_placeholderImage];
    }
    return self;
}

-(void) reloadData:(UIElementEntity*)entity {
    
    if (self.entity == (BaseEntity*)entity) {
        return;
    }
    [super reloadData:(BaseEntity*)entity];
    self.imgView.height = CGRectGetHeight(self.frame);
    self.clickBtn.height = CGRectGetHeight(self.frame);
    
    if(entity.imgUrl){
        
        [_imgView sd_setImageWithURL:[NSURL URLWithString:entity.imgUrl] placeholderImage:_placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
            
        }];
    }
    else{
        [_imgView setImage:_placeholderImage];
    }
}


-(void) buttonClicked:(id)sender {

}


@end




