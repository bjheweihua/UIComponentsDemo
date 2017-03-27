//
//  UICellEntity.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UICellEntity.h"


@implementation UIElementEntity

-(instancetype) initWithDict:(NSDictionary*)dict {
    
    self = [super init];
    if (self) {
        if (!dict) {
            return nil;
        }
        
        NSString *type = dict[@"type"];
        NSString *imgUrl = dict[@"imgUrl"];
        NSString *bgColor = dict[@"bgColor"];
        NSString *title = dict[@"title"];
        NSString *titleColor = dict[@"titleColor"];
        NSString *title1 = dict[@"title1"];
        NSString *title1Color = dict[@"title1Color"];
        NSString *title2 = dict[@"title2"];
        NSString *title2Color = dict[@"title2Color"];
        NSString *labelText = dict[@"labelText"];
        
        StringIsNull(type);
        StringIsNull(imgUrl);
        StringIsNull(bgColor);
        NullToBank(title);
        StringIsNull(titleColor);
        NullToBank(title1);
        StringIsNull(title1Color);
        NullToBank(title2);
        StringIsNull(title2Color);
        NullToBank(labelText);
        
        self.type = [type integerValue];
        self.imgUrl = imgUrl;
        self.bgColor = bgColor;
        self.title = title;
        self.titleColor = titleColor;
        self.title1 = title1;
        self.title1Color = title1Color;
        self.title2 = title2;
        self.title2Color = title2Color;
        self.labelText = labelText;

        // reload click state
        [self reloadHeight];
    }
    return self;
}


-(void) reloadHeight {
    
    switch (self.type) {
        
        case EElement102:{ //ok
            CGFloat pointH = (kMainScreenW*210.f)/375.f; // 210:默认高度
            if(self.imgUrl) {
                pointH = [self.imgUrl getImageHeightWithImageWidth:kMainScreenW];
            }
            self.height = ceilf(pointH);
        }
        break;
        case EElement103:{ //ok
            self.height = 89.f;
        }
        break;
        case EElement104:{//ok
            
            self.height = (((kMainScreenW - 42.f)/2.f) + 91.0);
        }
            break;
        case EElement105:
        case EElement106:{//ok
            
            self.height = 166.f;
        }
            break;
        case EElement107:{//ok
            
            self.height = 40.f;
        }
        break;
        default:
        self.height = 0;
        break;
    }
}



@end




@implementation UICellEntity

-(instancetype) initWithDict:(NSDictionary*)dict {
    
    self = [super init];
    if (self) {
        if (!dict) {
            return nil;
        }
        
        NSString *type = dict[@"type"];
        NSString *imgUrl = dict[@"imgUrl"];
        NSString *bgColor = dict[@"bgColor"];
        NSString *title = dict[@"title"];
        NSString *titleColor = dict[@"titleColor"];
        NSString *title1 = dict[@"title1"];
        NSString *title1Color = dict[@"title1Color"];
        NSString *title2 = dict[@"title2"];
        NSString *title2Color = dict[@"title2Color"];
        NSString *labelText = dict[@"labelText"];
        
        ThingsToNull(type);
        ThingsToNull(imgUrl);
        ThingsToNull(bgColor);
        NullToBank(title);
        ThingsToNull(titleColor);
        NullToBank(title1);
        ThingsToNull(title1Color);
        NullToBank(title2);
        ThingsToNull(title2Color);
        NullToBank(labelText);
        
        self.type = [type integerValue];
        self.imgUrl = imgUrl;
        self.bgColor = bgColor;
        self.title = title;
        self.titleColor = titleColor;
        self.title1 = title1;
        self.title1Color = title1Color;
        self.title2 = title2;
        self.title2Color = title2Color;
        self.labelText = labelText;
        
        NSArray *list = dict[@"list"];
        StringIsNull(list);
        
        self.type = [type integerValue];
        _list = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < [list count]; ++i) {
            
            UIElementEntity* entity = [[UIElementEntity alloc] initWithDict:list[i]];
            if (!entity) {
                continue;
            }
            [_list addObject:entity];
        }
        self.height = 0;
        // reload click state
        [self reloadHeight];
    }
    return self;
}


-(void) reloadHeight {
    
    switch (self.type) {
            
        case EElement100:
        case EElement101:{ 
            self.height = 56;
        }
            break;

        case EElement102:{ //ok
            if (_list.count >0) {
                
                UIElementEntity *entity = [_list objectAtIndexCheck:0];
                self.height = entity.height;
            }
        }
            break;
        case EElement103:{//ok
            
            if (_list.count >0) {
                
                UIElementEntity *entity = [_list objectAtIndexCheck:0];
                self.height = entity.height;
            }
        }
            break;
        case EElement104:{//ok
            
            if (_list.count >0) {
                
                UIElementEntity *entity = [_list objectAtIndexCheck:0];
                self.height = entity.height;
            }
        }
            break;
        case EElement105:{//ok
            
            if (_list.count >0) {
                
                UIElementEntity *entity = [_list objectAtIndexCheck:0];
                self.height = entity.height;
            }
        }
            break;
        case EElement106:{//ok
            
            if (_list.count >0) {
                
                UIElementEntity *entity = [_list objectAtIndexCheck:0];
                self.height = entity.height;
            }
        }
            break;
        case EElement107:{//ok
            
            if (_list.count >0) {
                
                UIElementEntity *entity = [_list objectAtIndexCheck:0];
                self.height = entity.height;
            }
        }
            break;
        default:
            self.height = 0;
            break;
    }
}


@end






@implementation UISectionEntity

-(instancetype) initWithDict:(NSDictionary*)dict{
    
    self = [super init];
    if (self){
        
        NSNumber* groupType = dict[@"groupType"];
        StringIsNull(groupType);
        self.groupType = [groupType integerValue];
        
        NSArray *list = dict[@"list"];
        StringIsNull(list);
        _list = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < [list count]; ++i) {
            
            UICellEntity* entity = [[UICellEntity alloc] initWithDict:list[i]];
            if (!entity) {
                continue;
            }
            
            if (entity.type >= EElement100 && entity.type <= EElement107) {
                [_list addObject:entity];
            }
        }
    }
    return self;
}


@end
