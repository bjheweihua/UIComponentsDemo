//
//  UIBaseHeaderFooterView.h
//  ClassmateParty
//
//  Created by heweihua on 15/7/26.
//  Copyright (c) 2015年 heweihua. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHeaderFooterH (22.f)

@interface UIBaseHeaderFooterView : UITableViewHeaderFooterView

//@property(nonatomic, strong) UILabel* titleLabel;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
