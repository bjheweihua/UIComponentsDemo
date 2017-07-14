//
//  MobileTrafficTopUpViewCell.h
//  JDMobile
//
//  Created by heweihua on 16/6/28.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMobileTrafficTopUpTitleH     (36.5) // 全国通用，立即生效
#define kMobileTrafficTopUpBottomH    (50.0)
#define kMobileTrafficTopUpHeaderH    (kMobileTrafficTopUpBottomH+ kMobileTrafficTopUpTitleH)


@class MobileTrafficTopUpViewController;
@interface MobileTrafficTopUpViewCell : UITableViewCell
-(void) setController:(MobileTrafficTopUpViewController*)vc;
-(void) reloadDataWithArr:(NSArray*)arr;

//-(void) reloadFooterData:(NSString*)title problemUrl:(NSString*)url;
-(void) reloadFooterData;
@end


