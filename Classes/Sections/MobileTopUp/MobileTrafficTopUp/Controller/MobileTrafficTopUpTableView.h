//
//  MobileTrafficTopUpTableView.h
//  JDMobile
//
//  Created by heweihua on 16/6/28.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MobileTrafficTopUpViewController;
@interface MobileTrafficTopUpTableView : UIView{
    
//    NSString *_problem_href;
}
@property (nonatomic, strong) UITableView* tableView;

-(void) setController:(MobileTrafficTopUpViewController*)vc;
-(void) reloadData:(NSMutableArray*) array;

//-(void) reloadFooterData:(NSString*)title problemUrl:(NSString*)url;
@end






