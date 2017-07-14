//
//  BillEntity.m
//  JDMobile
//
//  Created by heweihua on 16/4/25.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "BillEntity.h"

@implementation BillEntity

-(instancetype) init {
    
    self = [super init];
    if (self) {
        
        self.billType = 0;
        self.discount = 0;
        self.facePrice = @"";
        self.jdPrice = @"";
        self.flowjump = NO;
        self.enabled = YES;
        self.height = 75.0;
        _billList = [[NSMutableArray alloc] init];
    }
    return self;
}




-(instancetype) initWithDict:(NSDictionary*)dict {
    
    self = [super init];
    if (self) {
        
        NSNumber* billType = dict[@"billType"];
        NSString* facePrice = dict[@"facePrice"];
        NSString* jdPrice = dict[@"jdPrice"];
        NSString* facePriceName = dict[@"facePriceName"];
        NSString* jdPriceName = dict[@"jdPriceName"];
        NSNumber* discount = dict[@"discount"];
        NSNumber* flowjump = dict[@"flowjump"];
        NSDictionary* jumEntity = dict[@"jumEntity"];
        StringIsNull(billType);
        NullToBank(facePrice);
        NullToBank(jdPrice);
        NullToBank(facePriceName);
        NullToBank(jdPriceName);
        StringIsNull(discount);
        StringIsNull(flowjump);
        StringIsNull(jumEntity);
        
        self.billType = [billType integerValue];
        self.facePrice = facePrice;
        self.jdPrice = jdPrice;
        self.facePriceName = facePriceName;
        self.jdPriceName = jdPriceName;
        self.discount = [discount integerValue];
        self.flowjump = NO;
        if (flowjump) {
            self.flowjump = [flowjump boolValue];
        }
        self.enabled = YES;
        self.height = 75.0;
        self.bErr = NO;
//        self.jumpEntity = [[ClickEntity alloc] initWithIousData:jumEntity];
    }
    return self;
}

@end





@implementation BillSectionEntity

-(instancetype) init {
    
    self = [super init];
    if (self) {
        
        self.bshow = YES;
        self.height = 0.f;
        _billList = [[NSMutableArray alloc] init];
        _flowList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(instancetype) initWithDict:(NSDictionary*)dict {
    
    self = [super init];
    if (self) {
        
        self.bshow = YES;
        self.height = 42.5f;
        _billList = [[NSMutableArray alloc] init];
        _flowList = [[NSMutableArray alloc] init];
        NSString* title = dict[@"title"];
        NSArray* billList = dict[@"skuParams"];
        NSArray *flowList = dict[@"jumpList"];
        
        NullToBank(title);
        StringIsNull(billList);
        StringIsNull(flowList);
        self.title = title;
        
        // 话费
        NSMutableArray* arrs = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < [billList count]; ++i) {
            
            BillEntity* entity = [[BillEntity alloc] initWithDict:billList[i]];
            entity.billType = 0; // 充话费
            if (!entity) {
                continue;
            }
            [arrs addObjectCheck:entity];
        }
        //[_billList addObjectCheck:[self getListWithArr:arrs]];
        
        
        
        // 分组
        BillEntity* entity = nil;
        for (NSInteger i = 0; i < [arrs count]; i ++) {
            
            // 只要读到0,3,6,9,12就开辟空间存储接下来的元素
            if (i % 3 == 0) {
                
                entity = [[BillEntity alloc] init];
                entity.height = 75.0;
                entity.billType = 0;
                //将小数组添加到大数组中进行管理
                [_billList addObjectCheck:entity];
            }
            [entity.billList addObjectCheck:[arrs objectAtIndexCheck:i]];
        }
        
        
        
        // 流量
        NSMutableArray* trafficlist = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < [flowList count]; ++i) {
            
            BillEntity* entity = [[BillEntity alloc] initWithDict:flowList[i]];
            entity.billType = 1; // 流量
            if (!entity) {
                continue;
            }
            [trafficlist addObjectCheck:entity];
        }
        //[_flowList addObjectCheck:[self getListWithArr:trafficlist]];
        
        // 分组
        BillEntity* entity2 = nil;
        for (NSInteger i = 0; i < [trafficlist count]; i ++) {
            
            // 只要读到0,3,6,9,12就开辟空间存储接下来的元素
            if (i % 3 == 0) {
                
                entity2 = [[BillEntity alloc] init];
                entity2.height = 75.0;
                entity2.billType = 1;
                //将小数组添加到大数组中进行管理
                [_flowList addObjectCheck:entity2];
            }
            [entity2.billList addObjectCheck:[trafficlist objectAtIndexCheck:i]];
        }
    }
    return self;
}






-(NSArray*) getListWithArr:(NSArray*)arrs {
    
    NSMutableArray* list = [[NSMutableArray alloc] init];
    // 分组
    BillEntity* entity = nil;
    for (NSInteger i = 0; i < [arrs count]; i ++) {
        
        // 只要读到0,3,6,9,12就开辟空间存储接下来的元素
        if (i % 3 == 0) {
            
            entity = [[BillEntity alloc] init];
            entity.height = 75.0;
            entity.billType = self.billType;
            //将小数组添加到大数组中进行管理
            [list addObjectCheck:entity];
        }
        [entity.billList addObjectCheck:[arrs objectAtIndexCheck:i]];
    }
    return arrs;
}

@end










