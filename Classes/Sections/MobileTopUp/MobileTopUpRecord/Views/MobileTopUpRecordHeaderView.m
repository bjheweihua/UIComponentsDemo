//
//  MobileTopUpRecordHeaderView.m
//  JDMobile
//
//  Created by heweihua on 16/4/25.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTopUpRecordHeaderView.h"
#import "MobileTopUpRecordEntity.h"


@interface MobileTopUpRecordHeaderView ()

@property(nonatomic, strong) UILabel* leftTextLabel;
@end


@implementation MobileTopUpRecordHeaderView

-(instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self){
        
        self.frame = CGRectMake(0, 0, kMainScreenW, kMobileTopUpRecordHeaderViewH);
//        self.lineView.hidden = YES;
        self.contentView.backgroundColor = [UIColor jrColorWithHex:@"#f5f5f5"];
        
        // left
        _leftTextLabel = [[UILabel alloc] init];
//        [self.leftTextLabel setFont:[UIFont systemFontOfSize:14.f]];
//        [self.leftTextLabel setFont:[UIFont getSanFranciscoFont:12.0 Weight:KSFWeightRegular]];
        [self.leftTextLabel setFont:[UIFont getSystemFont:12.0 Weight:KFontWeightRegular]];
        [self.leftTextLabel setTextColor:[UIColor jrColorWithHex:@"#999999"]];
        self.leftTextLabel.frame = CGRectMake(kOffsetX, 7.5, kMainScreenW - kOffsetX*2, 20.f);
        [self.contentView addSubview:self.leftTextLabel];
    }
    return self;
}

-(void) reloadData:(MobileTopUpRecordEntity*)entity{
    
    [self.leftTextLabel setText:entity.monthText];
}


@end
