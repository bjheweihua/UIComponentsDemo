//
//  HistoryRecordEntity.m
//  JDMobile
//
//  Created by heweihua on 16/4/21.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "HistoryRecordEntity.h"

@implementation HistoryRecordEntity

-(instancetype) initWithCoder:(NSCoder *)coder{
    
    if (self = [super init]){
        
        self.type = [[coder decodeObjectForKey:@"_type"] integerValue];
        self.mobileNumber = [coder decodeObjectForKey:@"_mobileNumber"];
        self.status = [coder decodeObjectForKey:@"_status"];
        self.phoneOperator = [coder decodeObjectForKey:@"_phoneOperator"];
        self.name = [coder decodeObjectForKey:@"_name"];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)coder{
    
    [coder encodeObject:@(self.type) forKey:@"_type"];
    [coder encodeObject:self.mobileNumber forKey:@"_mobileNumber"];
    [coder encodeObject:self.status forKey:@"_status"];
    [coder encodeObject:self.phoneOperator forKey:@"_phoneOperator"];
    [coder encodeObject:self.name forKey:@"_name"];
}  


@end


