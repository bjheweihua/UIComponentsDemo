//
//  MobileTopUpRecordCell.m
//  JDMobile
//
//  Created by heweihua on 16/4/25.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTopUpRecordCell.h"
#import "MobileTopUpRecordEntity.h"


#define kOffsetX           (16.0)
#define kInnerOffsetW      (5.0)
#define kRLabelMaxWith     (80.0)
#define kLLabelMaxWith     (kMainScreenW - kRLabelMaxWith - (kOffsetX*2) - kInnerOffsetW)

@interface MobileTopUpRecordCell ()

@property(nonatomic, strong) UILabel* lUpLabel;
@property(nonatomic, strong) UILabel* lDownLabel;

@property(nonatomic, strong) UILabel* rUpLabel;
@property(nonatomic, strong) UILabel* rDownLabel;
@end

@implementation MobileTopUpRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        ;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, kMainScreenW, kMobileTopUpRecordCellH);
        
//        NSString *text = @"充话费300元 - 153 1142 6057";
//        UIFont* font = [UIFont systemFontOfSize:16.f];
//        CGSize size = [text jr_sizeWithFont:font];
//        CGFloat maxwith = size.width;
        
        // left 主标题
        CGRect rect = CGRectMake(kOffsetX, 14.0, kLLabelMaxWith, 22.5);
        _lUpLabel = [[UILabel alloc] initWithFrame:rect];
        _lUpLabel.backgroundColor = [UIColor clearColor];
        _lUpLabel.textColor = [UIColor jrColorWithHex:@"#444444"];
        _lUpLabel.font = [UIFont getSystemFont:16.0 Weight:KFontWeightMedium];
        [self.contentView addSubview:_lUpLabel];
        
        // left 副标题
        rect = _lUpLabel.frame;
        rect.origin.y = (CGRectGetMaxY(_lUpLabel.frame)) + 3.f;
        rect.size.width = 80.f;
        rect.size.height = 14.5;
        _lDownLabel = [[UILabel alloc] initWithFrame:rect];
        _lDownLabel.backgroundColor = [UIColor clearColor];
        _lDownLabel.textColor = [UIColor jrColorWithHex:@"#999999"];
        _lDownLabel.font = [UIFont getSystemFont:12.0 Weight:KFontWeightRegular];
//        _lDownLabel.font = [UIFont getSanFranciscoFont:12.0 Weight:KSFWeightRegular];
        [self.contentView addSubview:_lDownLabel];
        
        
        // right 主标题
        CGFloat pointX = CGRectGetMaxX(_lUpLabel.frame) + kInnerOffsetW;
        CGFloat pointW = kMainScreenW - pointX - kOffsetX;
//        rect = CGRectMake(pointX, 14.0, kRLabelMaxWith, 21.5);
        rect = CGRectMake(pointX, 14.0, pointW, 21.5);
        _rUpLabel = [[UILabel alloc] initWithFrame:rect];
        _rUpLabel.backgroundColor = [UIColor clearColor];
        _rUpLabel.textColor = [UIColor jrColorWithHex:@"#444444"];
//        _rUpLabel.font = [UIFont getSystemFont:18.0 Weight:KFontWeightLight];
//        _rUpLabel.font = [UIFont getSanFranciscoFont:16.0 Weight:KSFWeightRegular];
        _rUpLabel.font = [UIFont getSystemFont:16.0 Weight:KFontWeightMedium];
        [_rUpLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_rUpLabel];
        
        // right 副标题
        rect = _rUpLabel.frame;
        rect.origin.x = CGRectGetMaxX(_lDownLabel.frame) + 5.f;
        rect.origin.y = (CGRectGetMaxY(_rUpLabel.frame)) + 3.f;
        rect.size.width = kMainScreenW - kOffsetX - rect.origin.x;
        rect.size.height = 16.5;
        
        _rDownLabel = [[UILabel alloc] initWithFrame:rect];
        _rDownLabel.backgroundColor = [UIColor clearColor];
        _rDownLabel.textColor = [UIColor jrColorWithHex:@"#999999"];
//        _rDownLabel.font = [UIFont getSystemFont:12.0 Weight:KFontWeightLight];
//        _rDownLabel.font = [UIFont getSanFranciscoFont:12.0 Weight:KSFWeightRegular];
        _rDownLabel.font = [UIFont getSystemFont:12.0 Weight:KFontWeightRegular];
        [_rDownLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_rDownLabel];
        
        [self.contentView bringSubviewToFront:self.lineView];
        self.lineView.backgroundColor = [UIColor jrColorWithHex:@"#eeeeee"];
    }
    return self;
}

-(void) reloadData:(MobileTopUpRecordEntity *)entity {
    
    [_lUpLabel setText:entity.leftUpText];
    [_lDownLabel setText:entity.timeText];
    
    [_rUpLabel setText:entity.chargePrice];
    [_rDownLabel setText:entity.orderStatusName];
    [_rDownLabel setTextColor:[UIColor jrColorWithHex:entity.statusTextColor]];
}


@end








