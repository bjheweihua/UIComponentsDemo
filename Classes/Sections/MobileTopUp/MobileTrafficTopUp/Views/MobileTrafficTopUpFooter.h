//
//  MobileTrafficTopUpFooter.h
//  JDMobile
//
//  Created by heweihua on 16/5/3.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMobileTrafficTopUpFooterH (40.0 + 16.5)

@interface MobileTrafficTopUpFooter : UITableViewHeaderFooterView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

-(void) reloadData:(NSString*)title problemUrl:(NSString*)url;
@end

