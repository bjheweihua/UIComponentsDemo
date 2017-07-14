//
//  UIBannerEntity.m
//  JDMobile
//
//  Created by heweihua on 2017/3/6.
//  Copyright © 2017年 jr. All rights reserved.
//

#import "UIBannerEntity.h"

@implementation UIBannerEntity

-(instancetype) initWithDict:(NSDictionary*) dict {
    
    self = [super init];
    if (self) {
        
        NSString* imgUrl = dict[@"imgUrl"];
        NSDictionary* jumEntity = dict[@"jumEntity"];
        ThingsToNull(imgUrl);
        StringIsNull(jumEntity);
        
        self.imgUrl = imgUrl;
//        self.jumpEntity = [[ClickEntity alloc] initWithData:jumEntity];
        self.height = ((kMainScreenW*84.f)/375.f);
    }
    return self;
}

@end
