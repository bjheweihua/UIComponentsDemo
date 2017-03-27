//
//  UICellEntity.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "BaseEntity.h"


typedef NS_ENUM(NSInteger, ElementType){
    
    EElement100 = 100, // UITableHeaderCell
    EElement101 = 101, // UITableFooterCell
    EElement102 = 102, // UIBannerTableCell
    EElement103 = 103, // UIBigGridTableCell
    EElement104 = 104, // UIBigGridTableCell
    EElement105 = 105, // UIHorizontalTableCell
    EElement106 = 106, // UIHorizontalImgTableCell
    EElement107 = 107, // UIScrollTimerTableCell
};

@interface UIElementEntity : BaseEntity

@property(nonatomic, assign) ElementType type;       // 元素类型
@property(nonatomic, copy  ) NSString* bgColor;      // 背景色
@property(nonatomic, copy  ) NSString* imgUrl;       // imgUrl
@property(nonatomic, copy  ) NSString* title;        // 主标题
@property(nonatomic, copy  ) NSString* titleColor;   // 主标题颜色
@property(nonatomic, copy  ) NSString* title1;       // 副标题
@property(nonatomic, copy  ) NSString* title1Color;  // 副标题颜色
@property(nonatomic, copy  ) NSString* title2;       // bottom标题
@property(nonatomic, copy  ) NSString* title2Color;  // bottom标题颜色
@property(nonatomic, copy  ) NSString* labelText;    // 标签：“立减5元”
-(instancetype) initWithDict:(NSDictionary*)dict;

@end



@interface UICellEntity : BaseEntity

@property(nonatomic, assign) ElementType type;       // 元素类型
@property(nonatomic, copy  ) NSString* bgColor;      // 背景色
@property(nonatomic, copy  ) NSString* imgUrl;       // imgUrl
@property(nonatomic, copy  ) NSString* title;        // 主标题
@property(nonatomic, copy  ) NSString* titleColor;   // 主标题颜色
@property(nonatomic, copy  ) NSString* title1;       // 副标题
@property(nonatomic, copy  ) NSString* title1Color;  // 副标题颜色
@property(nonatomic, copy  ) NSString* title2;       // bottom标题
@property(nonatomic, copy  ) NSString* title2Color;  // bottom标题颜色
@property(nonatomic, copy  ) NSString* labelText;    // 标签：“立减5元”
@property(nonatomic, copy  ) NSMutableArray* list;   // UIElementEntity
-(instancetype) initWithDict:(NSDictionary*)dict;

@end




@interface UISectionEntity : BaseEntity

@property(nonatomic, assign) NSInteger groupType;      // 元素类型
@property(nonatomic, copy  ) NSMutableArray* list;    // cell：UICellEntity
-(id) initWithDict:(NSDictionary*)dict;
@end









