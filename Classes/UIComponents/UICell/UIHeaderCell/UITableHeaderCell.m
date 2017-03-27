//
//  UITableHeaderCell.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/1.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UITableHeaderCell.h"
#import "UICellEntity.h"

#define kRightArrowW  (7.5)
#define kRightArrowH  (12.5)

@interface UITableHeaderCell ()

@property(nonatomic, strong) UILabel *titleLabel;    // 主标题
@property(nonatomic, strong) UILabel *subTitleLabel;  // 副标题
@property(nonatomic, strong) UIImageView *arrowView;
@end

@implementation UITableHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        [self setAccessoryType:UITableViewCellAccessoryNone];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        
        //右箭头
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"com_arrow_r"]];
        CGFloat pointY = (CGRectGetHeight(self.frame) - kRightArrowH)/2;
        _arrowView.frame = CGRectMake(kMainScreenW - kOffsetX - kRightArrowW, pointY, kRightArrowW, kRightArrowH);
        [self.contentView addSubview:_arrowView];
        _arrowView.hidden = YES;
        
        // left
        UIFont* font = [UIFont systemFontOfSize:16.f];
        CGSize size = [@"计算高度" jr_sizeWithFont:font];
        pointY = (CGRectGetHeight(self.frame) - size.height)/2.f;
        CGRect rect = CGRectMake(kOffsetX, pointY, kMainScreenW/2.f - kOffsetX, size.height);
        _titleLabel = [[UILabel alloc] initWithFrame:rect];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor jrColorWithHex:@"#333333"]];
        [_titleLabel setFont:font];
        [self.contentView addSubview:_titleLabel];
        
        // right
        rect = CGRectMake(kMainScreenW/2.f, pointY, kMainScreenW/2.f - kOffsetX - kRightArrowW -10, size.height);
        _subTitleLabel = [[UILabel alloc] initWithFrame:rect];
        [_subTitleLabel setBackgroundColor:[UIColor clearColor]];
        [_subTitleLabel setTextColor:[UIColor jrColorWithHex:@"#999999"]];
        [_subTitleLabel setFont:font];
        [_subTitleLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_subTitleLabel];
    }
    return self;
}

-(void) reloadData:(UICellEntity*)entity {
    
    if (self.entity == (BaseEntity*)entity) {
        return;
    }
    [super reloadData:(BaseEntity*)entity];
    self.titleLabel.midY = self.center.y;
    self.subTitleLabel.midY = self.center.y;
    self.arrowView.midY = self.center.y;
    self.lineView.minY = (CGRectGetHeight(self.frame) - CGRectGetHeight(self.lineView.frame));
    
    if (!entity.bgColor) {
        entity.bgColor = @"#ffffff";
    }
    if(!entity.titleColor){
        
        entity.titleColor = @"#444444";
    }
    if(!entity.title1Color){
        
        entity.title1Color = @"#999999";
    }
    
    self.contentView.backgroundColor = [UIColor jrColorWithHex:entity.bgColor];
    self.titleLabel.text = entity.title;
    self.titleLabel.textColor = [UIColor jrColorWithHex:entity.titleColor];
    
    self.subTitleLabel.text = entity.title1;
    self.subTitleLabel.textColor = [UIColor jrColorWithHex:entity.title1Color];
    
    self.arrowView.hidden = YES;
    if ([entity.title1 length] > 0) {
        self.arrowView.hidden = NO;
    }
}

@end


