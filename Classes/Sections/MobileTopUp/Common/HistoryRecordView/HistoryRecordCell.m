//
//  HistoryRecordCell.m
//  JDMobile
//
//  Created by heweihua on 16/4/20.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "HistoryRecordCell.h"
#import "HistoryRecordEntity.h"

#define kOffsetX (16.0)
@interface HistoryRecordCell (){
    
    UILabel* _leftTextLabel;
    UILabel* _rightTextLabel;
}
@property(nonatomic, strong) UIView *upLineView;
@end

@implementation HistoryRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        self.frame = CGRectMake(0, 0, kMainScreenW, kHistoryRecordCellH);
        self.contentView.backgroundColor = [UIColor whiteColor];

        
        [self.contentView bringSubviewToFront:self.lineView];
        [self.lineView setBackgroundColor:[UIColor jrColorWithHex:@"#eeeeee"]];
        self.lineView.hidden = YES;
        
        
        // left
//        UIFont* font = [UIFont systemFontOfSize:18.f];
        UIFont* font = [UIFont getSanFranciscoFont:18.0 Weight:KSFWeightMedium];
        CGSize size = [@"计算高度" jr_sizeWithFont:font];
        CGFloat pointY = (kHistoryRecordCellH - size.height)/2.f;
        CGRect rect = CGRectMake(kOffsetX, pointY, kMainScreenW/2.f - kOffsetX, size.height);
        _leftTextLabel = [[UILabel alloc] initWithFrame:rect];
        [_leftTextLabel setBackgroundColor:[UIColor clearColor]];
        [_leftTextLabel setTextColor:[UIColor jrColorWithHex:@"#444444"]];
        [_leftTextLabel setFont:font];
        [self.contentView addSubview:_leftTextLabel];
//        [_leftTextLabel setText:@"153 1142 6057"];
        
        // right
        font = [UIFont getSystemFont:16.f Weight:KFontWeightRegular];
        size = [@"计算高度" jr_sizeWithFont:font];
        pointY = (kHistoryRecordCellH - size.height)/2.f;
        rect = CGRectMake(kMainScreenW/2.f - kOffsetX*3, pointY, kMainScreenW/2.f - kOffsetX + kOffsetX*3, size.height);
        _rightTextLabel = [[UILabel alloc] initWithFrame:rect];
        [_rightTextLabel setBackgroundColor:[UIColor clearColor]];
        [_rightTextLabel setTextColor:[UIColor jrColorWithHex:@"#666666"]];
        [_rightTextLabel setFont:font];
        [_rightTextLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_rightTextLabel];
//        [_rightTextLabel setText:@"已经绑定"];
        
        CGFloat pointH = GetPointWith(0.5);
        _upLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenW, pointH)];
        [_upLineView setBackgroundColor:[UIColor jrColorWithHex:@"#eeeeee"]];
        [self.contentView addSubview:_upLineView];
        _upLineView.hidden = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, kMainScreenW, kHistoryRecordCellH);
        [button setTitle:@"" forState: UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];

    }
    return self;
}

-(void) hiddenTopLine:(BOOL)hidden{
    
    _upLineView.hidden = hidden;
}

-(void) reloadData:(HistoryRecordEntity *)entity{
    
//    NSString* mobile = [self getTelPhoneWithDo:entity.mobileNumber];
    [_leftTextLabel setText:entity.mobileNumber];
    [_rightTextLabel setText:entity.status];
}

-(void) buttonClicked:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectHistoryRecordCell:)]) {
        [self.delegate didSelectHistoryRecordCell:self.tag];
    }
}


-(NSString*) getTelPhoneWithDo:(NSString*)tel {
    
    
    if ([tel length]==11) {
        
        NSMutableString* string = [NSMutableString stringWithFormat:@"%@",tel];
        NSInteger index = 0;
        while (index < string.length) {
            
            if(index == 3 || index == 8){
                
                [string insertString:@" " atIndex:index];
            }
            index++;
        }
        return string;
    }
    else{
        return tel;
    }
}


@end








