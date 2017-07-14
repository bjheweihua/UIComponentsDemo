//
//  MobileTopUpRecordView.m
//  JDMobile
//
//  Created by heweihua on 16/5/23.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTopUpRecordView.h"
#import "MobileTopUpRecordHeaderView.h"
#import "MobileTopUpRecordCell.h"
#import "MobileTopUpRecordEntity.h"
#import "MobileTopUpNetwork.h"
//#import "NoRecordCell.h"
#import "SRRefreshView.h"
#import "MobileTopUpRecordViewController.h"
//#import "FinNoRecordCell.h"

@interface MobileTopUpRecordView ()
<
UITableViewDataSource,
UITableViewDelegate,
//JDRefreshBaseViewDelegate,
SRRefreshDelegate
>
{
    //  table 数据数组
    UITableView*    _tableView;
    
    // 0:无刷新 1:下拉刷新  2:上啦加载
    NSInteger     _nIsRefresh;
    BOOL          _bIsRecord;
    BOOL          _bIsRemoveData;
//    FinNoRecordCell* _noDataCell;
    
    NSInteger       _nType; // 0:话费  1：流量
    NSMutableArray *_netArr;
    MobileTopUpRecordViewController* _controller;
    
    NSUInteger _nPage;
}
@end

@implementation MobileTopUpRecordView



-(void) dealloc{
    
//    NetWorkCancle(_network);
}


-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self){
        
        _nPage = 0;
        _totalCount = -1;
        _tableDataArr = [[NSMutableArray alloc] init];
        [self initTableView];
        
    }
    return self;
}

-(void) setController:(MobileTopUpRecordViewController*)vc type:(NSInteger)type{
    
    _nType = type;
    _controller = vc;
}

// init UITableView
-(void) initTableView{
    
    CGFloat pointH = CGRectGetHeight(self.frame);
    CGRect rect = CGRectMake(0, 0, kMainScreenW, pointH);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionHeaderHeight = 0.0f;
    _tableView.sectionFooterHeight = 0.0f;
    _tableView.scrollsToTop = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tableView];
    
    self.refreshFooter = [[CfRefreFooterView alloc] init];
    self.refreshFooter.activity.color = [UIColor grayColor];
    
    // 分隔线
    [_tableView setSeparatorColor:[UIColor jrColorWithHex:@"#eeeeee"]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    _noDataCell = [[FinNoRecordCell alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW,BaseViewHeight) initWithReuseIdentifier:@"FBD_nodata" withText1:@"" withText2:@""];
//    [_noDataCell setImage:[UIImage imageNamed:@"fund_nodata"] andText1:@"本月无订单"];
//    _noDataCell.selectionStyle=UITableViewCellSelectionStyleNone;
//    _noDataCell.hidden = YES;
    
    // 刷新控件
    [self setHeadRefresh:_tableView];
    
    //请求网络
    _nIsRefresh = 1;
    _bIsRemoveData = YES;
    [_slimeView setLoadingWithexpansion];
    [self endHeadRefresh:2.0f];
}


-(void)setHeadRefresh:(UIScrollView*)scrollView{
    
    _slimeView = [[SRRefreshView alloc] initWithHeight:32.0f];
    _slimeView.backgroundColor = [UIColor clearColor];
    _slimeView.delegate = self;
    _slimeView.upInset = 0;
    _slimeView.slimeMissWhenGoingBack = YES;
    _slimeView.slime.bodyColor = [UIColor jrColorWithHex:@"#cccccc"];//外边可以设置
    _slimeView.slime.skinColor = [UIColor clearColor];
    _slimeView.slime.lineWith = 1;
    _slimeView.slime.shadowBlur = 4;
    _slimeView.slime.shadowColor = [UIColor clearColor];
    [scrollView addSubview:_slimeView];
}

-(void)endHeadRefresh:(CGFloat)sec{
    
    [_slimeView performSelector:@selector(endRefresh)
                    withObject:nil afterDelay:sec
                       inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
}




- (void)reloadTableView{
    
    if (_nIsRefresh == 0)
        return;
    _nIsRefresh = 0;
    // 结束刷新状态
//    [_footer endRefreshing];
}




#pragma mark - UITableViewDelegate && UITableViewDataSource
// header
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return kMobileTopUpRecordHeaderViewH;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    

    MobileTopUpRecordEntity *entity = [[_tableDataArr objectAtIndexCheck:section] objectAtIndexCheck:0];
    static NSString *headerId = @"MobileTopUpRecordHeaderView";
    MobileTopUpRecordHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    if (!headView) {
        headView = [[MobileTopUpRecordHeaderView alloc] initWithReuseIdentifier:headerId];
    }
    [headView reloadData:entity];
    return headView;
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (!_tableDataArr || _tableDataArr.count == 0){
        _bIsRecord = NO;
//        _footer.scrollView = nil;
//        _footer.delegate = nil;
        return 1;
    }
    else{
        _bIsRecord = YES;
//        _footer.scrollView = _tableView;
//        _footer.delegate = self;
        return [_tableDataArr count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_bIsRecord){
        return [_tableDataArr[section] count];
    }
    else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_bIsRecord){
        return kMobileTopUpRecordCellH;
    }
    else{
//        return _noDataCell.frame.size.height;
        return 0;
    }
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_bIsRecord){
//        return _noDataCell;
        return [UITableViewCell new];
    }
    MobileTopUpRecordEntity* entity = _tableDataArr[indexPath.section][indexPath.row];
    
    static NSString *cellId = @"MobileTopUpRecordCell";
    MobileTopUpRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MobileTopUpRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell reloadData:entity];
    [cell setLineType:EBottomShortLine];
    if ([_tableDataArr[indexPath.section] count] == indexPath.row+1) {
        [cell setLineType:ELineUnknow];
    }
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}



#pragma mark - 话费充值--根据条件查询满足条件的订单列表信息--充值

-(void) requestData{
    
    if(0 == _nType){
        [self requestDataWithMobileTopUpRecord];
    }
    else if (1 == _nType){
        [self requestDataWithTrafficTopUpRecord];
    }
}


// 话费记录
-(void) requestDataWithMobileTopUpRecord {
    
    self.isLoading = YES;
    if (self.isFull){
        
        if (_nIsRefresh)
            [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:0.1];
        if (self.slimeView.loading)
            [self endHeadRefresh:0.1f];
        return;
    }
//    if(_network)
//        [_network cancel];
//    
//    NSInteger page = _nPage + 1;
//    if (_bIsRemoveData == YES) {
//        page = 1;
//    }
//    @JDJRWeakify(self);
//    _network = [[MobileTopUpNetwork sharedInstance] getMobileTopUpRecord:page pageSize:kTopUpRecordCount];
//    [[AppManager sharedInstance] receiveObject:^(id object){
//        
//        @JDJRStrongify(self);
//        self.isLoading = NO;
//        [self reloadData:object];
//    }withIdentifier:kMobileTopUp_BillOrderList];
    
    
    
    self.isLoading = NO;
    NSString *path = [[NSBundle mainBundle]  pathForResource:@"billOrderList" ofType:@"json"];
    NSData *rdata = [[NSData alloc] initWithContentsOfFile:path];
    NSString *result = [[NSString alloc] initWithData:rdata encoding:NSUTF8StringEncoding];
    result = [result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    [self reloadData:dict];
}


-(void) reloadData:(id) object {
    
    if (_nIsRefresh)
        [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:0.1];
    if (self.slimeView.loading)
        [self endHeadRefresh:0.1f];
    
    if ([object isKindOfClass:[NSMutableDictionary class]]){
        
        if (_bIsRemoveData){
            if (_netArr && _netArr.count)
                [_netArr removeAllObjects];
            _netArr = nil;
            _bIsRemoveData = NO;
            _nPage = 0;
        }
//        _noDataCell.hidden = NO;
        _totalCount = [[object objectForKey:@"totalCount"] integerValue];
        NSArray * arr = [object objectForKey:@"orderDetails"];
        if (!arr || arr.count == 0){
            self.isFull = YES;
            return;
        }
        
        NSMutableArray* array = [[NSMutableArray alloc] init];
        for (int i = 0; i < arr.count; ++i){
            
            NSDictionary* dic = [arr objectAtIndexCheck:i];
            MobileTopUpRecordEntity* entity = [[MobileTopUpRecordEntity alloc] initWithDict:dic withType:_nType];
            [array addObjectCheck:entity];
        }
        
        if (!_netArr || _netArr.count == 0)
            _netArr = [[NSMutableArray alloc] initWithArray:array];
        else
            [_netArr addObjectsFromArray:array];
        
        self.isFull = (_totalCount <= _netArr.count);
        _nPage += 1;
        
        //转化数据 网络数据转化为本地数据）
        [self transNetToArr:_netArr];
        [_tableView reloadData];
    }
    else{
        [_tableView reloadData];
    }
}

//重新组织数据（按月）
-(void) transNetToArr:(NSArray*)netArr {
    
    if (!netArr || netArr.count == 0) return;
    
    if (_tableDataArr)
        [_tableDataArr removeAllObjects];
    _tableDataArr = nil;
    
    NSString *str = @"";
    NSMutableArray *arr = nil;
    NSString *month = nil;
    
    // 日期进行分组
    for (int i = 0; i < netArr.count; ++i)
    {
        MobileTopUpRecordEntity* entity = [netArr objectAtIndexCheck:i];
        if (!entity.monthText)
            continue;
        month = entity.monthText;
        if (![month isEqualToString:str])
        {
            if (arr)
            {
                if (!_tableDataArr)
                    _tableDataArr = [[NSMutableArray alloc]init];
                [_tableDataArr addObjectCheck:arr];
            }
            
            str = month;
            arr = [[NSMutableArray alloc] init];
            [arr addObjectCheck:entity];
        }
        else
        {
            [arr addObjectCheck:entity];
        }
    }
    if (arr)
    {
        if (!_tableDataArr)
            _tableDataArr = [[NSMutableArray alloc]init];
        [_tableDataArr addObjectCheck:arr];
    }
    return;
}



// 流量记录
-(void) requestDataWithTrafficTopUpRecord {
    
    self.isLoading = YES;
    if (self.isFull){
        
        if (_nIsRefresh)
            [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:0.1];
        if (self.slimeView.loading)
            [self endHeadRefresh:0.1f];
        return;
    }
//    NSInteger page = _nPage + 1;
//    if (_bIsRemoveData == YES) {
//        page = 1;
//    }
//    if(_network)
//        [_network cancel];
//    _network = [[MobileTopUpNetwork sharedInstance] getTrafficRecord:page pageSize:kTopUpRecordCount];
//    [[AppManager sharedInstance] receiveObject:^(id object){
//        
//        self.isLoading = NO;
//        [self reloadData:object];
//    }withIdentifier:kMobileTopUp_TrafficOrderList];
    
    
    self.isLoading = NO;
    NSString *path = [[NSBundle mainBundle]  pathForResource:@"flowOrderList" ofType:@"json"];
    NSData *rdata = [[NSData alloc] initWithContentsOfFile:path];
    NSString *result = [[NSString alloc] initWithData:rdata encoding:NSUTF8StringEncoding];
    result = [result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    [self reloadData:dict];
}




#pragma mark - JDPayRefreshBaseViewDelegate
-(void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView{
    
    _nIsRefresh = 1;
    _bIsRemoveData = YES;
    self.isFull = NO;
    [self requestData];
    [self endHeadRefresh:2.0f];
}

//
//- (void)refreshViewBeginRefreshing:(JDRefreshBaseView *)refreshView{
//    
////    if(_footer == refreshView) {
////        _nIsRefresh = 2;
////        [self requestData];
////        [self performSelector:@selector(reloadTableView) withObject:nil afterDelay:2.0f];
////    }
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_slimeView scrollViewDidEndDraging];
}



#pragma mark 上拉加载
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 如果滚动到最后一段的倒数第三个，就开始加载。特殊情况：当最后一段不足三个时，滚动到最后一个加载
    NSArray* section = [_tableDataArr objectAtIndexCheck:indexPath.section];
    if (!self.isFull && !self.isLoading && (section && section.count >0 && indexPath.row == section.count - 1)) {
        [self jr_startFootView];
        
//        _nIsRefresh = 2;
        [self requestData];
    }
}




- (void)jr_startFootView
{
    [_refreshFooter start];
}

- (void)jr_stopFootView
{
    [_refreshFooter stop];
}

-(void)setIsFull:(BOOL)isFull
{
    _isFull = isFull;
    [self jr_stopFootView];
    if (isFull) {
        
        UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 20.f)];
//        footer.text = @"没有更多了";
        footer.font = [UIFont systemFontOfSize:10.f];
        footer.textColor = [UIColor jrColorWithHex:@"#999999"];
        footer.textAlignment = NSTextAlignmentCenter;
        footer.contentMode = UIViewContentModeCenter;
        footer.backgroundColor = [UIColor clearColor];
        footer.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(__didTapTheFooterView:)];
//        [footer addGestureRecognizer:tap];
        _tableView.tableFooterView = footer;
    }else{
        _tableView.tableFooterView = _refreshFooter;
//        [self jr_stopFootView];
    }
}





@end






