//
//  MobileTrafficTopUpViewController.m
//  JDMobile
//
//  Created by heweihua on 16/4/28.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTrafficTopUpViewController.h"
#import "HistoryRecordView.h"
#import "BillEntity.h"
#import "MobileTopUpHeaderView.h"
#import "MobileTopUpRecordViewController.h"
#import "MobileTrafficTopUpCell.h"
#import "HistoryRecordEntity.h"
#import "MobileTrafficEntity.h"
#import "MobileTrafficTopUpCell.h"
#import "MobileTrafficTopUpHeader.h"
#import "MobileTopUpHistoryRecordManager.h"
#import "MobileTopUpNetwork.h"
#import "MobileTrafficTopUpViewController+Manager.h"

@interface MobileTrafficTopUpViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
HistoryRecordViewDelegate,
MobileTrafficTopUpHeaderDelegate,
MobileTrafficTopUpCellDelegate
>
{
    
    HistoryRecordView* _recordView;
    NSString *_phoneOperator;
    NSInteger _tableIndex;
}

@end

@implementation MobileTrafficTopUpViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
    
//    NetWorkCancle(_network);
}

-(instancetype) initWithTel:(NSString *)aTel phoneOperator:(NSString *)phoneOperator{
    
    self = [super init];
    if (self) {
        
        _tableIndex = 0;
        _tel = aTel;
        _phoneOperator = phoneOperator;
        _tableDataArr = [[NSMutableArray alloc] init];
        _name = @"";
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addNavigationBar:@"流量充值"];
    [self addRightButtonItemWithTitle:@"客服" target:self selector:@selector(rightbtnAction)];// 客服
    [self initMobileTrafficTopUpCell];
    [self initTableView];
    [self initHeaderView];
    [self initHistoryRecordView];
    [self defaultInitializeData]; // 默认初始化数据
    [self requestWithBannerPitures];
    [self requestData];
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
    
    //1 默认情况(导航栏透明，cell自适应:空出导航栏位置开始布局)
    //
    
    //2 情况一(导航栏透明，cell禁止自适应：从UITaleView顶端开始布局)
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //3 情况三(cell禁止自适应,导航栏不透明，空出导航栏位置开始布局)
//    self.navigationController.navigationBar.translucent = NO;
    //self.extendedLayoutIncludesOpaqueBars = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //4 情况四(cell禁止自适应,导航栏不透明,从UITaleView顶端开始布局)
    //self.navigationController.navigationBar.translucent = NO;
    //self.extendedLayoutIncludesOpaqueBars = YES;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    //5 情况五(导航栏透明，cell禁止自适应，extendedLayoutIncludesOpaqueBars的设置是无效的)
    
    CGRect rect = CGRectMake(0, 0, kMainScreenW, CGRectGetHeight(self.view.frame));
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionHeaderHeight = 0.0f;
    _tableView.sectionFooterHeight = 0.0f;
    _tableView.scrollsToTop = NO;
    [self.view addSubview:_tableView];
    _tableView.allowsSelection = NO;
    _tableView.backgroundColor = [UIColor jrColorWithHex:@"#f5f5f5"];
    // 分隔线
    [_tableView setSeparatorColor:[UIColor clearColor]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [_tableView addGestureRecognizer:gesture];
}

-(void) handleTapGesture:(UITapGestureRecognizer*)tap {
    
    if (_headerView) {
        [_headerView mobileTextFieldWithResignFirstResponder];
    }
}

-(void) initHistoryRecordView {
    
    CGFloat pointY = CGRectGetHeight(_headerView.frame);
    CGRect rect = CGRectMake(0, pointY, kMainScreenW, kMainScreenH - pointY);
    _recordView = [[HistoryRecordView alloc] initWithFrame:rect];
    [_recordView setDelegate:self];
    [_tableView addSubview:_recordView];
    _recordView.hidden = YES;
    [_recordView reloadData:1];
}


-(void) initHeaderView {

    static NSString *headerId = @"MobileTopUpHeaderView";
    _headerView = [[MobileTrafficTopUpHeader alloc] initWithReuseIdentifier:headerId];
    [_headerView setDelegate:self];
    _tableView.tableHeaderView = _headerView;
    [_headerView reloadDataWithTel:_tel name:_phoneOperator];
}


-(void) initMobileTrafficTopUpCell {
    
    static NSString *cellId = @"MobileTrafficTopUpViewCell";
    _cell = [_tableView dequeueReusableCellWithIdentifier:cellId];
    if (_cell == nil) {
        _cell = [[MobileTrafficTopUpViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [_cell setController:self];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (!_tableDataArr || [_tableDataArr count] == 0) {
        return 0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CGFloat pointH = kMainScreenH - 64 - CGRectGetHeight(_headerView.frame);
    _cell.frame = CGRectMake(0, 0, kMainScreenW, pointH);
    return pointH;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_cell reloadDataWithArr:self.tableDataArr];
    return _cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}




#pragma mark - MobileTrafficTopUpHeaderDelegate
-(void) mobileTextFieldDidInputWithNumber:(NSString*) mobileNumber {
    
    // to do 请求接口
    _tel = mobileNumber;
    _name = @"";
    [self requestData];
}


-(void) mobileTextFieldDidInput:(BOOL) hidden {
    
    if (hidden == YES) {
        [self keyBoardWillHide];
    }
    else{
        [self keyBoardWillShow];
    }
    
    [self setTrafficEntityWithEnabled:NO];
}




-(void) didClickHeadButton {
    
    [self openContacts];
    
}

// 键盘显示|隐藏
-(void) keyBoardWillShow {

    [self performSelectorOnMainThread:@selector(runkeyBoardWillShow) withObject:nil waitUntilDone:NO];
}

-(void) runkeyBoardWillShow {
    
    // 流量历史记录
    NSArray *arr = [MobileTopUpHistoryRecordManager getMobileTopUpHistoryRecord];
    if(!arr || [arr count] < 1)
        return;
    
    // 耗时的操作
    CGFloat pointY = [_headerView getMobileMaxY];
    CGRect rect = CGRectMake(0, pointY, kMainScreenW, CGRectGetHeight(_tableView.frame)*2);
    [_recordView setFrame:rect];
    
    // 更新界面
    [_tableView bringSubviewToFront:_recordView];
    _recordView.hidden = NO;
}

-(void) keyBoardWillHide {
    
    [self performSelectorOnMainThread:@selector(runkeyBoardWillHide) withObject:nil waitUntilDone:NO];
}

-(void) runkeyBoardWillHide {
    
    _recordView.hidden = YES;
    CGFloat pointY = CGRectGetHeight(_headerView.frame);
    CGRect rect = CGRectMake(0, pointY, kMainScreenW, CGRectGetHeight(_tableView.frame)*2);
    [_recordView setFrame:rect];
}


#pragma mark - HistoryRecordViewDelegate <NSObject>

-(void) didSelectHistoryRecord:(HistoryRecordEntity*)entity {
    
    _recordView.hidden = YES;
    [_headerView mobileTextFieldWithResignFirstResponder];
    if(1 == entity.type){
        // 清空历史数据
        [MobileTopUpHistoryRecordManager deleteAllMobileTopUpHistoryRecord];
        [_recordView reloadData:1];
        return;
    }
    [_headerView reloadDataWithTel:entity.mobileNumber name:entity.phoneOperator];
    // to do 请求接口
    _tel = entity.mobileNumber;
    _name = entity.name;
    [self requestData];
}


-(void) didTapHiddenHistoryRecordView{
    
    _recordView.hidden = YES;
    [_headerView mobileTextFieldWithResignFirstResponder];
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


#pragma mark - MobileTrafficTopUpCellDelegate

-(void) didTouchTrafficTopUp:(MobileTrafficEntity *)entity {
    
    [_headerView mobileTextFieldWithResignFirstResponder];
    if (!_tel || [_tel isEqualToString:@""]) {
        return;
    }
    
    // 5. 根据商品，用户等信息提交订单--充值
    [self requestWithSubmitOrder:_tel entity:entity];
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
    [self->_headerView reloadDataWithTel:self->_tel name:self->_name];
    
    // to do 请求接口
    [self requestData];
}


@end









