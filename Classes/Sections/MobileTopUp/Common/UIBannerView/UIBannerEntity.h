//
//  UIBannerEntity.h
//  JDMobile
//
//  Created by heweihua on 2017/3/6.
//  Copyright © 2017年 jr. All rights reserved.
//

#import "BaseEntity.h"

@interface UIBannerEntity : BaseEntity

@property(nonatomic, copy) NSString* imgUrl;
-(instancetype) initWithDict:(NSDictionary*) dict;
@end
