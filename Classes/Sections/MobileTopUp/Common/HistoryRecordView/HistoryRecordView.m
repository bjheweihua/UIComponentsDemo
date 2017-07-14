//
//  HistoryRecordView.m
//  JDMobile
//
//  Created by heweihua on 16/4/20.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "HistoryRecordView.h"
#import "HistoryRecordCell.h"
#import "HistoryRecordClearCell.h"
#import "HistoryRecordEntity.h"
#import "MobileTopUpHistoryRecordManager.h"
#import "HistoryRecordViewDelegate.h"

@interface HistoryRecordView ()
<
UITableViewDataSource,
UITableViewDelegate,
HistoryRecordCellDelegate
>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* tableDataArr;
@end

@implementation HistoryRecordView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        _tableDataArr = [[NSMutableArray alloc] init];
        
        UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self addGestureRecognizer:gesture];
        
        [self initTableView];
    }
    return self;
}

-(void) handleTapGesture:(UITapGestureRecognizer*)tap {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapHiddenHistoryRecordView)]) {
        [self.delegate didTapHiddenHistoryRecordView];
    }
}


-(void) reloadData:(NSInteger)type {// 0: 话费 1：流量
    
    [_tableDataArr removeAllObjects];
    
    NSMutableArray *arr = nil;
    if (0 == type) {
        arr = [MobileTopUpHistoryRecordManager getMobileTopUpHistoryRecord];
    }
    else if (1 == type) {
        arr = [MobileTopUpHistoryRecordManager getMobileTopUpHistoryRecord];
    }
    if (arr && [arr count] > 0){
        [_tableDataArr addObjectsFromArray:arr];
        
        HistoryRecordEntity* entity4 = [[HistoryRecordEntity alloc] init];
        entity4.type = 1;
        entity4.mobileNumber = @"";
        entity4.status = @"清空历史记录";
        [_tableDataArr addObjectCheck:entity4];
    }
    
    [_tableView reloadData];
}


// init UITableView
-(void) initTableView{
    
    CGRect rect = CGRectMake(0, 0, kMainScreenW, CGRectGetHeight(self.frame));
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionHeaderHeight = 0.0f;
    _tableView.sectionFooterHeight = 0.0f;
    _tableView.scrollsToTop = NO;
    _tableView.scrollEnabled = NO;
    [self addSubview:_tableView];
    // 分隔线
    [_tableView setSeparatorColor:[UIColor clearColor]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}



#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_tableDataArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kHistoryRecordClearCellH;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HistoryRecordEntity* entity = _tableDataArr[indexPath.row];
    if (1 == entity.type) {
      
        static NSString *cellId = @"HistoryRecordClearCell";
        HistoryRecordClearCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[HistoryRecordClearCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [cell setDelegate:self];
        [cell setTag:indexPath.row];
        [cell reloadData:entity];
        [cell setLineType:EBottomLongLine];
        if (([_tableDataArr count] -1) == indexPath.row) {
            [cell setLineType:ELineUnknow];
        }
        return cell;
    }

    static NSString *cellId = @"HistoryRecordCell";
    HistoryRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[HistoryRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell setDelegate:self];
    [cell setTag:indexPath.row];
    [cell reloadData:entity];
    [cell setLineType:EBottomLongLine];
    if (([_tableDataArr count] -1) == indexPath.row) {
        [cell setLineType:ELineUnknow];
    }
    
    [cell hiddenTopLine:YES];
    if (0 == indexPath.row) {
        [cell hiddenTopLine:NO];
    }
    return cell;
}

#pragma mark - Table view delegate --- 这个已经不起作用了
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    HistoryRecordEntity* entity = _tableDataArr[indexPath.row];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectHistoryRecord:)]) {
//        [self.delegate didSelectHistoryRecord:entity];
//    }
}



#pragma mark - HistoryRecordCellDelegate
-(void) didSelectHistoryRecordCell:(NSInteger)row {
    
    HistoryRecordEntity* entity = _tableDataArr[row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectHistoryRecord:)]) {
        [self.delegate didSelectHistoryRecord:entity];
    }
}

@end









