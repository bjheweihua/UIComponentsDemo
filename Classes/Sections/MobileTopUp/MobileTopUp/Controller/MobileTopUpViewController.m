//
//  MobileTopUpViewController.m
//  JDMobile
//
//  Created by heweihua on 16/4/18.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTopUpViewController.h"
#import "MobileTopUpHeaderView.h"
#import "MobileTopUpGridCell.h"
#import "MobileNumberCell.h"
#import "HistoryRecordView.h"
#import "HistoryRecordEntity.h"
#import "MobileTopUpRecordViewController.h"
#import "UIBannerView.h"
#import "MobileTopUpViewController+Manager.h"
#import "BillEntity.h"
#import "MobileTrafficTopUpViewController.h"
#import "MobileTopUpHistoryRecordManager.h"

@interface MobileTopUpViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
MobileNumberCellDelegate,
HistoryRecordViewDelegate,
MobileTopUpGridCellDelegate
>
{
    HistoryRecordView* _recordView;
    
}

@end

@implementation MobileTopUpViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
    
//    NetWorkCancle(_network);
}

-(instancetype) init{
    
    self = [super init];
    if (self) {
        
        _tableDataArr = [[NSMutableArray alloc] init];
        _name = @"";
        _tel = @"";
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    [self addNavigationBar:@"充值中心"];
    [self addRightButtonItemWithTitle:@"客服" target:self selector:@selector(rightbtnAction)];//客服
    [self initTableView];
    [self initHistoryRecordView];
    [self initButton];
    [self defaultInitializeData]; // 默认初始化数据
    [self requestData]; // 网络请求
    [self requestWithBannerPitures];
}



// 客服
-(void) rightbtnAction{
    
//    ClickEntity *entity = [[ClickEntity alloc]init];
//    entity.jumpType = 2;
//    entity.jumpUrl = _problem_href;
//    [[JRPodsPublic shareInstance]JRPublicJump:entity];
//
}



// init UITableView
-(void) initTableView{

    CGRect rect = CGRectMake(0, 0, kMainScreenW, kMainScreenH);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionHeaderHeight = 0.0f;
    _tableView.sectionFooterHeight = 0.0f;
    _tableView.scrollsToTop = NO;
    [self.view addSubview:_tableView];
    _tableView.allowsSelection = NO;
    _tableView.backgroundColor = [UIColor jrColorWithHex:@"#f5f5f5"];
    [_tableView setSeparatorColor:[UIColor clearColor]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [_tableView addGestureRecognizer:gesture];
}

-(void) handleTapGesture:(UITapGestureRecognizer*)tap {
    
    [self mobileFieldWithResignFirstResponder];
}

-(void) initHistoryRecordView {
    
    CGFloat pointY = 10 + 70;
    CGRect rect = CGRectMake(0, pointY, kMainScreenW, kMainScreenH - pointY);
    _recordView = [[HistoryRecordView alloc] initWithFrame:rect];
    [_recordView setDelegate:self];
    [_tableView addSubview:_recordView];
    _recordView.hidden = YES;
    [_recordView reloadData:0];
}

-(void) initButton {
    
    UIFont *fontsize = [UIFont getSanFranciscoFont:12.0 Weight:KSFWeightRegular];
    CGFloat pointY = CGRectGetHeight(self.tableView.frame) - 22.5 - 40 + (40 - 12)/2.f;
    CGRect rect = CGRectMake(0, pointY, kMainScreenW, 40.f);
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = rect;
    _button.backgroundColor = [UIColor clearColor];
    [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_button];
    
    UIColor* btncolor = [UIColor jrColorWithHex:@"#999999"];
    _button.titleLabel.font = fontsize;
    [_button setTitleColor:btncolor forState:UIControlStateNormal];
    [_button setTitleColor:btncolor forState:UIControlStateHighlighted];
    [_button setTitle:@"充值记录" forState:UIControlStateNormal];
}

-(void) buttonClicked:(id)sender {
    
    // 充值记录
    MobileTopUpRecordViewController* vc = [[MobileTopUpRecordViewController alloc] initWithType:0];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - UITableViewDelegate && UITableViewDataSource

// header
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    BillSectionEntity* sectionEntity = _tableDataArr[section];
    if (section == 0) {
        if (self.tableView.tableHeaderView && CGRectGetHeight(self.tableView.tableHeaderView.frame) == kMobileTopUpBannerH) {
            return 0.01;
        }
    }
    return sectionEntity.height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    BillSectionEntity* sectionEntity = _tableDataArr[section];
    static NSString *headerId = @"MobileTopUpHeaderView";
    MobileTopUpHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    if (!headView) {
        headView = [[MobileTopUpHeaderView alloc] initWithReuseIdentifier:headerId];
    }
    [headView reloadData:sectionEntity];
    return headView;
}



- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _tableDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    BillSectionEntity* sectionEntity = _tableDataArr[section];
    return [sectionEntity.billList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BillSectionEntity* sectionEntity = _tableDataArr[indexPath.section];
    BillEntity* entity = sectionEntity.billList[indexPath.row];
    return entity.height;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BillSectionEntity* sectionEntity = _tableDataArr[indexPath.section];
    BillEntity* entity = sectionEntity.billList[indexPath.row];
    switch (sectionEntity.billType) {
        case 0:
        case 1:{
            
            static NSString *cellId = @"MobileTopUpGridCell";
            MobileTopUpGridCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[MobileTopUpGridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                [cell setDelegate:self];
            }
            [cell reloadData:entity];
            return cell;
        }
            break;
        case 2:{
            
            static NSString *cellId = @"MobileNumberCell";
            MobileNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[MobileNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [cell setDelegate:self];
            [cell reloadData:entity];
            return cell;
        }
            break;
        default:
            break;
    }
    return [UITableViewCell new];
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}




#pragma mark - MobileNumberCellDelegate
-(void) mobileTextFieldDidInputWithNumber:(NSString*) mobileNumber {
    
    _tel = mobileNumber;
    _name = @"";
    // to do 请求接口
    [self requestBillList:mobileNumber localUserName:@""];
}


-(void) mobileTextFieldDidInput:(BOOL) hidden {
    
    if (hidden == YES) {
        [self keyBoardWillHide];
    }
    else{
        [self keyBoardWillShow];
    }
    BOOL bflag = [self setBillEntityWithEnabled:NO];
    if (bflag == NO) {
        return;
    }
    NSRange range = NSMakeRange(1, 2);
    NSIndexSet* sections = [NSIndexSet indexSetWithIndexesInRange:range];
    [_tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];

    return;
}


-(void) didClickHeadButton {
    
    [self openContacts];
    
}

#pragma mark - HistoryRecordViewDelegate
-(void) didSelectHistoryRecord:(HistoryRecordEntity*)entity {
    
    _recordView.hidden = YES;

    [self mobileFieldWithResignFirstResponder];
    if(1 == entity.type){
        
        // 情况历史数据
        [MobileTopUpHistoryRecordManager deleteAllMobileTopUpHistoryRecord];
        [_recordView reloadData:0];
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    MobileNumberCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    [cell hiddenMobileTextFieldWithTel:entity.mobileNumber name:entity.status];
    // to do 请求接口
    _name = entity.name;
    _tel = entity.mobileNumber;
    [self requestBillList:entity.mobileNumber localUserName:entity.name];
}

-(void) didTapHiddenHistoryRecordView{
    
    _recordView.hidden = YES;
    [self mobileFieldWithResignFirstResponder];
}

// 缩回键盘
-(void) mobileFieldWithResignFirstResponder {
    
    NSIndexPath *_indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    MobileNumberCell *_cell = [_tableView cellForRowAtIndexPath:_indexPath];
    if (_cell) {
        [_cell mobileTextFieldWithResignFirstResponder];
    }
}

-(void) openContacts {
    
    @JDJRWeakify(self);
    [SystemGrantedManager getGrantedContacts:^(bool granted, CFErrorRef error) {
        @JDJRStrongify(self);
        if (!granted) {
            
            [self openSettingsURLString];
            return;
        }
        else{
            ABPeoplePickerNavigationController *vc = [[ABPeoplePickerNavigationController alloc] init];
            vc.peoplePickerDelegate = self;
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        }
    }];
}


-(void) openSettingsURLString {
    
    // 非第一次显示alert
    @JDJRWeakify(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"APP需要访问通讯录"
                                                                   message:@"请前往“设置”授权APP访问通讯录"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        @JDJRStrongify(self);
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [alert addAction:moreAction];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - MobileTopUpGridCellDelegate

-(void) didTouchMobileGrid:(BillEntity*) entity {
    
    [self mobileFieldWithResignFirstResponder];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    MobileNumberCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    if (!_tel || [_tel isEqualToString:@""]) {
        return;
    }
    
    // 流量
    if (entity.billType == 1) {
        
        if (YES == entity.flowjump){
            // 选流量包
            NSString* phoneOperator = [cell getPhoneOperator];
            MobileTrafficTopUpViewController* vc = [[MobileTrafficTopUpViewController alloc] initWithTel:_tel phoneOperator:phoneOperator];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else{
            
//            if (!entity.jumpEntity) {
//                return;
//            }
            // 领流量
//            [[JRPodsPublic shareInstance]JRPublicJump:entity.jumpEntity];
        }
        return;
    }
    
    // 5. 根据商品，用户等信息提交订单--充值
    [self requestWithSubmitOrder:_tel entity:entity];
}

// 键盘显示|隐藏
-(void) keyBoardWillShow {
    
    [self performSelectorOnMainThread:@selector(runkeyBoardWillShow) withObject:nil waitUntilDone:NO];
}

-(void) runkeyBoardWillShow {
    
    // 话费历史记录
    NSArray *arr = [MobileTopUpHistoryRecordManager getMobileTopUpHistoryRecord];
    if(!arr || [arr count] < 1)
        return;
    
    [_tableView bringSubviewToFront:_recordView];
    // 耗时的操作
    CGFloat pointY = 10 + 70;
    if (self.tableView.tableHeaderView.tag == 0) {
        pointY = 70 + kMobileTopUpBannerH;
    }
    CGRect rect = CGRectMake(0, pointY, kMainScreenW, _tableView.bounds.size.height);
    [_recordView setFrame:rect];
    _recordView.hidden = NO;
}


-(void) keyBoardWillHide {
    
    [_tableView bringSubviewToFront:_recordView];
    _recordView.hidden = YES;
    CGFloat pointY = 10 + 70;
    if (self.tableView.tableHeaderView.tag == 0) {
        pointY = 70 + kMobileTopUpBannerH;
    }
    CGRect rect = CGRectMake(0, pointY, kMainScreenW, _tableView.bounds.size.height);
    [_recordView setFrame:rect];
}





#pragma mark ABPeoplePickerNavigationControllerDelegate methods

// Dismisses the people picker and shows the application when users tap Cancel.
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    
    @JDJRWeakify(self);
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
        @JDJRStrongify(self);
    }];
}


#pragma mark - ABPeoplePickerNavigationControllerDelegate <NSObject>

// iOS8 Called after a property has been selected by the user.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    if(property != kABPersonPhoneProperty) {
        return ;
    }
    
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    // telephone
    CFStringRef telValue = ABMultiValueCopyValueAtIndex(valuesRef,index);
    // full name
    CFStringRef fullName = ABRecordCopyCompositeName(person);
    
    
    NSString* tel = [NSString stringWithFormat:@"%@",telValue];
    tel = [tel stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    tel = [tel stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    tel = [tel stringByReplacingOccurrencesOfString:@"+" withString:@""];
    tel = [tel stringByReplacingOccurrencesOfString:@"-" withString:@""];
    tel = [tel stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* name = [NSString stringWithFormat:@"%@",fullName];
    name = [name stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    
    if (telValue) {
        CFRelease(telValue);
    }
    if (fullName) {
        CFRelease(fullName);
    }
    if (valuesRef){
        CFRelease(valuesRef);
    }
    
    self->_tel = tel;
    self->_name =  name;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    MobileNumberCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell hiddenMobileTextFieldWithTel:self->_tel name:self->_name];
    
    // to do 请求接口
    [self requestBillList:self->_tel localUserName:self->_name];
}



@end












