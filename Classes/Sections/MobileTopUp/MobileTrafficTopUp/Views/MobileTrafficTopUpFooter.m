//
//  MobileTrafficTopUpFooter.m
//  JDMobile
//
//  Created by heweihua on 16/5/3.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTrafficTopUpFooter.h"
@class MobileTrafficTopUpViewController;

@interface MobileTrafficTopUpFooter ()
{
    NSString* _url;
}
@end

@implementation MobileTrafficTopUpFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self){
        
        self.contentView.backgroundColor = [UIColor jrColorWithHex:@"#f5f5f5"];
        self.frame = CGRectMake(0, 0, kMainScreenW, kMobileTrafficTopUpFooterH);
    }
    return self;
}

-(void) reloadData:(NSString*)title problemUrl:(NSString*)url{
    
    // 常见问题
    UIFont *font = [UIFont getSanFranciscoFont:12.0 Weight:KSFWeightRegular];
    CGSize size = [title jr_sizeWithFont:font];
    
    CGFloat pointW = size.width + 16*2.0;
    CGFloat pointX = (kMainScreenW - pointW)/2.f;
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(pointX, 0.0, pointW, kMobileTrafficTopUpFooterH);
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = font;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor jrColorWithHex:@"#999999"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    _url = url;
}

-(void) btnClicked:(id)sender {
    
//    ClickEntity * entity = [[ClickEntity alloc]init];
//    entity.jumpType = 2;
//    entity.jumpUrl = _url;
//    [[JRPodsPublic shareInstance]JRPublicJump:entity];
    
}

@end







