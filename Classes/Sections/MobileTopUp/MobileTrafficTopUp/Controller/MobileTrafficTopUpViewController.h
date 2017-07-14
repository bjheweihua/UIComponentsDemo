//
//  MobileTrafficTopUpViewController.h
//  JDMobile
//
//  Created by heweihua on 16/4/28.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "UIBaseViewController.h"
#import "MobileTrafficTopUpViewCell.h"
#import <AddressBookUI/AddressBookUI.h>

@class MobileTrafficTopUpHeader;
@interface MobileTrafficTopUpViewController : UIBaseViewController
<
ABPeoplePickerNavigationControllerDelegate
>
{
//    NetworkController  *_network;
    MobileTrafficTopUpHeader* _headerView;
    
    NSString *_tel;
    NSString *_name;
    NSString *_problem_href;

}
@property (nonatomic, strong) NSMutableArray* tableDataArr;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) MobileTrafficTopUpViewCell* cell;
//@property (nonatomic, strong) ClickEntity * downClick;

-(instancetype) initWithTel:(NSString *)aTel phoneOperator:(NSString *)phoneOperator;

@end

