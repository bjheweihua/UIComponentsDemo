//
//  HistoryRecordClearCell.m
//  JDMobile
//
//  Created by heweihua on 16/4/20.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "HistoryRecordClearCell.h"
#import "HistoryRecordEntity.h"

#define kOffsetX (16.0)

@interface HistoryRecordClearCell (){
    
    UILabel* _textLabel;
}

@end

@implementation HistoryRecordClearCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        self.frame = CGRectMake(0, 0, kMainScreenW, kHistoryRecordClearCellH);
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        [self.contentView bringSubviewToFront:self.lineView];
        [self.lineView setBackgroundColor:[UIColor jrColorWithHex:@"#eeeeee"]];
        self.lineView.hidden = YES;
        
        
        // 清空历史记录
        UIFont* font = [UIFont getSystemFont:16.f Weight:KFontWeightRegular];
        CGSize size = [@"计算高度" jr_sizeWithFont:font];
        CGFloat pointY = (kHistoryRecordClearCellH - size.height)/2.f;
        CGRect rect = CGRectMake(kOffsetX, pointY, kMainScreenW - kOffsetX*2, size.height);
        _textLabel = [[UILabel alloc] initWithFrame:rect];
        [_textLabel setBackgroundColor:[UIColor clearColor]];
        [_textLabel setTextColor:[UIColor jrColorWithHex:kBlueColor]];
        [_textLabel setFont:font];
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_textLabel];
        [_textLabel setText:@"清空历史记录"];
    }
    return self;
}

-(void) reloadData:(HistoryRecordEntity *)entity{
    
    [_textLabel setText:entity.status];
}



@end



