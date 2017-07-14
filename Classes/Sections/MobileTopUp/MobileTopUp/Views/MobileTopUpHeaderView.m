//
//  MobileTopUpHeaderView.m
//  JDMobile
//
//  Created by heweihua on 16/4/18.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTopUpHeaderView.h"
#import "BillEntity.h"



@interface MobileTopUpHeaderView ()

@end


@implementation MobileTopUpHeaderView

-(instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self){
        
        self.frame = CGRectMake(0, 0, kMainScreenW, kMobileTopUpHeaderH);
        self.lineView.hidden = YES;
//        self.contentView.backgroundColor = [UIColor jrColorWithHex:@"#f5f5f5"];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        // left
//        [self.leftTextLabel setFont:[UIFont systemFontOfSize:16.f]];
        self.leftTextLabel.font = [UIFont getSanFranciscoFont:16.0 Weight:KSFWeightRegular];
        [self.leftTextLabel setTextColor:[UIColor jrColorWithHex:@"#666666"]];
        self.leftTextLabel.frame = CGRectMake(kOffsetX, 20, kMainScreenW - kOffsetX*2, 22.5f);
        
        // right
        self.rightTextLabel.hidden = YES;
        self.arrowView.hidden = YES;
        
        self.contentBtn.enabled = NO;
    }
    return self;
}

-(void) reloadData:(BillSectionEntity*)entity{
    
    [self.leftTextLabel setText:entity.title];
}


@end









