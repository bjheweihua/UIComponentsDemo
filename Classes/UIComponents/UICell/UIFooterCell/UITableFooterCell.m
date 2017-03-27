//
//  UITableFooterCell.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/1.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UITableFooterCell.h"
#import "UICellEntity.h"



@interface UITableFooterCell ()

@property(nonatomic, strong) UILabel *titleLabel;    // 主标题
@end

@implementation UITableFooterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        [self setAccessoryType:UITableViewCellAccessoryNone];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        
        // 主标题
        UIFont* font = [UIFont getSystemFont:16.f Weight:KFontWeightRegular];
        CGRect rect = CGRectMake(kOffsetX, 18.0, kMainScreenW - kOffsetX*2, 22.5);
        _titleLabel = [[UILabel alloc] initWithFrame:rect];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor jrColorWithHex:@"#508cee"]];
        [_titleLabel setFont:font];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_titleLabel];
        
        [self.contentView bringSubviewToFront:self.lineView];
        self.lineView.hidden = NO;
    }
    return self;
}

-(void) reloadData:(UICellEntity*)entity {
    
    if (self.entity == (BaseEntity*)entity) {
        return;
    }
    [super reloadData:(BaseEntity*)entity];
    self.titleLabel.midY = self.center.y;
    self.lineView.minY = 0;
    
    
    if (!entity.bgColor) {
        entity.bgColor = @"#ffffff";
    }
    if(!entity.titleColor){
        
        entity.titleColor = @"#508cee";
    }
    self.contentView.backgroundColor = [UIColor jrColorWithHex:entity.bgColor];
    _titleLabel.text = entity.title;
    _titleLabel.textColor = [UIColor jrColorWithHex:entity.titleColor];
}


@end
