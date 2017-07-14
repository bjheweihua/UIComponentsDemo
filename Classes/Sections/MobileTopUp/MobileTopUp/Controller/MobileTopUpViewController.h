//
//  MobileTopUpViewController.h
//  JDMobile
//
//  Created by heweihua on 16/4/18.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "UIBaseViewController.h"
#import <AddressBookUI/AddressBookUI.h>


@interface MobileTopUpViewController : UIBaseViewController
<
ABPeoplePickerNavigationControllerDelegate
>
{
    
//    NetworkController  *_network;
    UIButton *_button;
    NSString *_problem_href;
    
    NSString *_tel; // tel
}
@property (nonatomic, strong) NSMutableArray* tableDataArr;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, strong) NSString *name;
//@property (nonatomic, strong) ClickEntity *downClick;

@end



