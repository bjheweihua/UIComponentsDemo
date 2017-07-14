//
//  MobileTrafficEntity.m
//  JDMobile
//
//  Created by heweihua on 16/4/29.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTrafficEntity.h"

@implementation MobileTrafficEntity

-(instancetype) init {
    
    self = [super init];
    if (self) {
        
        self.skuId = @"";
        self.skuName = @"";
        self.faceAmount = @"";
        self.salePrice = @"";
        self.faceAmountName = @"";
        self.salePriceName = @"";
        self.desc = @"";
        
        self.enabled = NO;
        self.height = 70.0;
    }
    return self;
}




-(instancetype) initWithDict:(NSDictionary*)dict {
    
    self = [super init];
    if (self) {
        

        NSString* skuId = dict[@"skuId"];
        NSString* skuName = dict[@"skuName"];
        NSString* faceAmount = dict[@"faceAmount"];
        NSString* salePrice = dict[@"salePrice"];
        NSString* faceAmountName = dict[@"faceAmountName"];
        NSString* salePriceName = dict[@"salePriceName"];
        NSString* desc = dict[@"desc"];
        NSString* discount = dict[@"discount"];
        
        NullToBank(skuId);
        NullToBank(skuName);
        NullToBank(faceAmount);
        NullToBank(salePrice);
        NullToBank(faceAmountName);
        NullToBank(salePriceName);
        NullToBank(desc);
        NullToBank(discount);
        
        self.skuId = skuId;
        self.skuName = skuName;
        self.faceAmount = faceAmount;
        self.salePrice = salePrice;
        self.faceAmountName = faceAmountName;
        self.salePriceName = salePriceName;
        self.desc = desc;
        self.discount = [discount integerValue];

        self.enabled = YES;
        self.height = 70.0;
    }
    return self;
}


@end



@implementation TrafficSectionEntity

// 初始化默认值
-(instancetype) init {
    
    self = [super init];
    if (self) {
        

        
        _list = [[NSMutableArray alloc] init];
        /*
        MobileTrafficEntity* entity1 = [[MobileTrafficEntity alloc] init];
        entity1.faceAmountName = @"5M";
        entity1.salePriceName = @"0.95元";
        
        MobileTrafficEntity* entity2 = [[MobileTrafficEntity alloc] init];
        entity2.faceAmountName = @"10M";
        entity2.salePriceName = @"1.90元";
        
        MobileTrafficEntity* entity3 = [[MobileTrafficEntity alloc] init];
        entity3.faceAmountName = @"30M";
        entity3.salePriceName = @"4.75元";
        
        MobileTrafficEntity* entity4 = [[MobileTrafficEntity alloc] init];
        entity4.faceAmountName = @"50M";
        entity4.salePriceName = @"6.65元";
        
        MobileTrafficEntity* entity5 = [[MobileTrafficEntity alloc] init];
        entity5.faceAmountName = @"100M";
        entity5.salePriceName = @"9.50元";
        entity5.skuName = @"送5M 赠送于1天内到账";
        
        MobileTrafficEntity* entity6 = [[MobileTrafficEntity alloc] init];
        entity6.faceAmountName = @"200M";
        entity6.salePriceName = @"14.45元";
        entity6.skuName = @"送10M 赠送于1天内到账";
        
        MobileTrafficEntity* entity7 = [[MobileTrafficEntity alloc] init];
        entity7.faceAmountName = @"500M";
        entity7.salePriceName = @"29.75元";
        entity7.skuName = @"送30M 赠送于1天内到账";
        
        MobileTrafficEntity* entity8 = [[MobileTrafficEntity alloc] init];
        entity8.faceAmountName = @"1G";
        entity8.salePriceName = @"47.50元";
        
        [_list addObjectCheck:entity1];
        [_list addObjectCheck:entity2];
        [_list addObjectCheck:entity3];
        [_list addObjectCheck:entity4];
        [_list addObjectCheck:entity5];
        [_list addObjectCheck:entity6];
        [_list addObjectCheck:entity7];
        [_list addObjectCheck:entity8];
        */
        
        //        30M、100M、300M、500M、1G、2G，金额处文案为“去购买”
        MobileTrafficEntity* entity1 = [[MobileTrafficEntity alloc] init];
        entity1.faceAmountName = @"30M";
        entity1.salePriceName = @"去购买";
        
        MobileTrafficEntity* entity2 = [[MobileTrafficEntity alloc] init];
        entity2.faceAmountName = @"100M";
        entity2.salePriceName = @"去购买";
        
        MobileTrafficEntity* entity3 = [[MobileTrafficEntity alloc] init];
        entity3.faceAmountName = @"300M";
        entity3.salePriceName = @"去购买";
        
        MobileTrafficEntity* entity4 = [[MobileTrafficEntity alloc] init];
        entity4.faceAmountName = @"500M";
        entity4.salePriceName = @"去购买";
        
        MobileTrafficEntity* entity5 = [[MobileTrafficEntity alloc] init];
        entity5.faceAmountName = @"1G";
        entity5.salePriceName = @"去购买";
        
        MobileTrafficEntity* entity6 = [[MobileTrafficEntity alloc] init];
        entity6.faceAmountName = @"2G";
        entity6.salePriceName = @"去购买";

        [_list addObjectCheck:entity1];
        [_list addObjectCheck:entity2];
        [_list addObjectCheck:entity3];
        [_list addObjectCheck:entity4];
        [_list addObjectCheck:entity5];
        [_list addObjectCheck:entity6];
        
        self.bshow = NO;
        self.height = 37.f;
    }
    return self;
}

-(instancetype) initWithDict:(NSDictionary*)dict {
    
    self = [super init];
    if (self) {
        
        // 原始字段
        NSString* tabTitle = dict[@"tabTitle"];
        NSString* tips = dict[@"tips"];
        NSArray* list = dict[@"list"];
        NullToBank(tabTitle);
        NullToBank(tips);
        StringIsNull(list);
        self.tabTitle = tabTitle;
        self.tips = tips;
        _list = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < [list count]; ++i) {
            
            NSDictionary* subDict = list[i];
            MobileTrafficEntity* entity = [[MobileTrafficEntity alloc] initWithDict:subDict];
            [_list addObjectCheck:entity];
        }
        self.bshow = YES;
        self.height = 37.f;
    }
    return self;
}

@end








