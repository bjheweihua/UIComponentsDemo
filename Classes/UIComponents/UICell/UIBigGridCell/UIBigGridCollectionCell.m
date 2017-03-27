//
//  UIBigGridView.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIBigGridCollectionCell.h"
#import "UICellEntity.h"


@interface UIBigGridCollectionCell(){
}
@property(nonatomic, strong) NSMutableParagraphStyle *par;
@property(nonatomic, strong) UIImage *placeholderImage;

@end


@implementation UIBigGridCollectionCell


-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        // icon
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
        _imgView.userInteractionEnabled = NO;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        _imgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_imgView];
        
        // placeholderImage
        UIImageView* placeImgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brickChannelNoImage"]];
        CGFloat pointX = (kMainScreenW - CGRectGetWidth(placeImgv.frame))/2.f;
        CGFloat pointY = (CGRectGetHeight(self.frame) - CGRectGetHeight(placeImgv.frame))/2.f;
        [placeImgv setFrame:CGRectMake(pointX, pointY, CGRectGetWidth(placeImgv.frame), CGRectGetHeight(placeImgv.frame))];
        UIView* placeholderview = [[UIImageView alloc] initWithFrame:_imgView.frame];
        [placeholderview addSubview:placeImgv];
        placeholderview.backgroundColor = [UIColor jrColorWithHex:@"#fafafa"];
        _placeholderImage = [UIImage jrImageFromView:placeholderview];
        [_imgView setImage:_placeholderImage];
        
        // 主标题
        pointY = CGRectGetMaxY(_imgView.frame) + 10;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, pointY, CGRectGetWidth(self.frame), 20.f)];//40
        _titleLabel.font = [UIFont getSystemFont:14.f Weight:KFontWeightMedium];
        _titleLabel.numberOfLines = 2;
        [self addSubview:_titleLabel];
        
        // 副标题
        pointY = CGRectGetMaxY(_titleLabel.frame) + 4;
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, pointY, CGRectGetWidth(self.frame), 17.f)];
        _subTitleLabel.font = [UIFont getSystemFont:13.f Weight:KFontWeightMedium];
        [self addSubview:_subTitleLabel];
    }
    return self;
}



-(void) reloadData:(UIElementEntity *)entity{
    
    if (self.entity == (BaseEntity*)entity) {
        return;
    }
    [super reloadData:(BaseEntity*)entity];
    
    // backgroundColor
    if (entity.bgColor) {
        self.backgroundColor = [UIColor jrColorWithHex:entity.bgColor];
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
    
    // imgUrl
    if(entity.imgUrl){
        
        [_imgView sd_setImageWithURL:[NSURL URLWithString:entity.imgUrl] placeholderImage:_placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        }];
    }
    else{
        [_imgView setImage:_placeholderImage];
    }
    
    
    // titile
    if (!entity.titleColor) {
        entity.titleColor = @"#444444";
    }
//    NSString* subTitleColor1 = [dic objectForKey:@"etitle2Color"];
//    ThingsToNull(subTitleColor1);
//    
//    NSString* subTitleColor2 = [dic objectForKey:@"etitle3Color"];
//    ThingsToNull(subTitleColor2);
    
    CGSize size = [entity.title sizeForLimitWidth:((kMainScreenW - 42.f)/2.f) font:[UIFont getSystemFont:14.f Weight:KFontWeightMedium]];
    
    // title
    NSMutableParagraphStyle* par = [[NSMutableParagraphStyle alloc] init];
    if (size.height > 20) {
        [par setLineSpacing:6.0f];//3.0
    }
    else{
        [par setLineSpacing:0.f];//0
    }
    NSMutableAttributedString*_title = [[NSMutableAttributedString alloc] initWithString:entity.title];
    [_title addAttribute:NSParagraphStyleAttributeName value:par range:NSMakeRange(0, [entity.title length])];
    
    // subTitle
    if (!entity.title1Color) {
        entity.title1Color = @"#FF801A";
    }
    if (!entity.title2Color) {
        entity.title2Color = @"#3f3f3f";
    }
    UIFont* font = [UIFont getSystemFont:13.f Weight:KFontWeightMedium];;
    UIColor *color1 = [UIColor jrColorWithHex:entity.title1Color];
    UIColor *color2 = [UIColor jrColorWithHex:entity.title2Color];
    NSString* text = [NSString stringWithFormat:@"%@%@",entity.title1,entity.title2];
    NSDictionary* dic0 = [[NSDictionary alloc] initWithObjectsAndKeys:font,NSFontAttributeName, color1, NSForegroundColorAttributeName,nil];
    NSDictionary* dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:font,NSFontAttributeName, color2, NSForegroundColorAttributeName,nil];
    
    NSMutableAttributedString* _subTitle = [[NSMutableAttributedString alloc] initWithString:text];
    [_subTitle addAttributes:dic0 range:NSMakeRange(0, entity.title1.length)];
    [_subTitle addAttributes:dic1 range:NSMakeRange(entity.title1.length, entity.title2.length)];
    
    _titleLabel.attributedText = _title;
    _titleLabel.textColor = [UIColor jrColorWithHex:entity.titleColor];
    [_titleLabel sizeToFit];
    
    CGRect rect = _titleLabel.frame;
    rect.size.width = CGRectGetWidth(self.frame);
    
    // 为了解决动态计算出来的高度不符合UI设计的高度，区分写死高度, 这里配合setLineSpacing来控制的
    if (FCMP_G(rect.size.height, 20)) { // x > y
        rect.size.height = 40;
    }
    else{
        rect.size.height = 20;
    }
    _titleLabel.frame = rect;
    
    
    // subTitleLabel
    _subTitleLabel.attributedText = _subTitle;
    
    rect = _subTitleLabel.frame;
    rect.origin.y = CGRectGetMaxY(_titleLabel.frame) + 4;
    _subTitleLabel.frame = rect;
}

@end




