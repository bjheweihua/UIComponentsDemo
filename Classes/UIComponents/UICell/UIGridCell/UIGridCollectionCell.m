//
//  UIGridView.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIGridCollectionCell.h"
#import "UICellEntity.h"
#import "JRBubbleView.h"

#define kIconWidth     (64.f)//(36.f)
#define kIconHeight    (42.f)//(36.f)

@interface UIGridCollectionCell(){
}
@end


@implementation UIGridCollectionCell


-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        // icon
        CGFloat pointX = (CGRectGetWidth(self.frame) - kIconWidth)/2.f;
        CGRect rect = CGRectMake(pointX, 11.f, kIconWidth, kIconHeight);
        _imgView = [[UIImageView alloc] initWithFrame:rect];
        [_imgView setBackgroundColor:[UIColor clearColor]];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.clipsToBounds = YES;
        [self.contentView addSubview:_imgView];
        
        
        pointX = CGRectGetWidth(frame)/2.f;
        rect = CGRectMake(pointX, 10.5f, 0, 15);
        _bubbleView = [[JRBubbleView alloc] initWithFrame:rect];
        [self.contentView addSubview:_bubbleView];
        [_bubbleView setBackgroundColor:[UIColor jrColorWithHex:@"#ff801a"]];
        _bubbleView.hidden = YES;
        
        // 主标题
        rect = CGRectMake(0, 59, CGRectGetWidth(self.frame), 20.f);
        _titleLabel = [[UILabel alloc] initWithFrame:rect];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor jrColorWithHex:@"#444444"];
        _titleLabel.font = [UIFont getSystemFont:12.f Weight:KFontWeightMedium];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}


-(void) btnClicked:(UIButton*)btn withEvent:(UIEvent*)event{
    
    UITouch* touch = [[event allTouches] anyObject];
    if(touch.tapCount != 1) return;
    
    btn.selected = YES;
    [self performSelector:@selector(btnUnSelected:) withObject:btn afterDelay:0.2];
}



-(void) btnUnSelected:(UIButton*)btn{
    
    btn.selected = NO;
}

-(void) reloadData:(UIElementEntity *)entity{
    
    if (self.entity == (BaseEntity*)entity) {
        return;
    }
    [super reloadData:(BaseEntity*)entity];
    
    if([entity.titleColor isEqualToString:@""]){
        
        entity.titleColor = @"#444444";
    }
    if([entity.title1Color isEqualToString:@""]){
        
        entity.title1Color = @"#FF801A";
    }
    if([entity.bgColor isEqualToString:@""]){
        
        entity.bgColor = @"#ffffff";
    }
    
    
    self.backgroundColor = [UIColor jrColorWithHex:entity.bgColor];
    _titleLabel.text = entity.title;
    _titleLabel.textColor = [UIColor jrColorWithHex:entity.titleColor];
    
    _imgView.hidden = YES;
    if(entity.imgUrl && ![entity.imgUrl isEqualToString:@""]){
        
        _imgView.hidden = NO;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:entity.imgUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
        }];
    }
    
    _bubbleView.hidden = YES;
    if (entity.labelText && ![entity.labelText isEqualToString:@""]) {
        
        if ([entity.labelText length] > 4) {
            entity.labelText = [entity.labelText substringToIndex:4]; // 限制4个字符
        }
        [_bubbleView setText:entity.labelText maxWidth:CGRectGetWidth(self.frame) - CGRectGetMinX(_bubbleView.frame)];
    }
    
//    _contentBtn.enabled = YES;
//    if (!entity.jumpEntity) {
//        _contentBtn.enabled = NO;
//    }
}

@end




