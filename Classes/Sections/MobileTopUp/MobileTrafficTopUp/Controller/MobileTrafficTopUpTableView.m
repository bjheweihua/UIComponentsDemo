//
//  MobileTrafficTopUpTableView.m
//  JDMobile
//
//  Created by heweihua on 16/6/28.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTrafficTopUpTableView.h"
#import "MobileTrafficTopUpViewController.h"
#import "MobileTrafficEntity.h"
#import "MobileTrafficTopUpCell.h"
#import "BillEntity.h"
#import "MobileTrafficTopUpFooter.h"
#import "MobileTopUpRecordViewController.h"


@interface MobileTrafficTopUpTableView ()
<
UITableViewDataSource,
UITableViewDelegate
//MobileTrafficTopUpCellDelegate
>
{
    MobileTrafficTopUpViewController* _controller;
    NSMutableArray* _tableDataArr;
}
@end

@implementation MobileTrafficTopUpTableView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initTableView];
    }
    return self;
}


-(void) setController:(MobileTrafficTopUpViewController*)vc{
    
    _controller = vc;
}

-(void) reloadData:(NSMutableArray*) array {
    
    _tableDataArr = array;
    [_tableView reloadData];
}


// init UITableView
-(void) initTableView{
    
    CGRect rect = CGRectMake(0, 0, kMainScreenW, CGRectGetHeight(self.frame));
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
    
    _tableView.allowsSelection = NO;
    _tableView.backgroundColor = [UIColor jrColorWithHex:@"#f5f5f5"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.contentSize = CGSizeMake(kMainScreenW, _tableView.height);
    
    
    UIFont *fontsize = [UIFont getSanFranciscoFont:12.0 Weight:KSFWeightRegular];
    rect = CGRectMake(0, 0, kMainScreenW, 40.f);
    
    UIButton* tableFooterView = [UIButton buttonWithType:UIButtonTypeCustom];
    tableFooterView.frame = rect;
    tableFooterView.backgroundColor = [UIColor clearColor];
    [tableFooterView addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIColor* btncolor = [UIColor jrColorWithHex:@"#999999"];
    tableFooterView.titleLabel.font = fontsize;
    [tableFooterView setTitleColor:btncolor forState:UIControlStateNormal];
    [tableFooterView setTitleColor:btncolor forState:UIControlStateHighlighted];
    [tableFooterView setTitle:@"充值记录" forState:UIControlStateNormal];
    _tableView.tableFooterView = tableFooterView;
}



#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (!_tableDataArr || [_tableDataArr count] == 0) {
        return 0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_tableDataArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MobileTrafficEntity* entity = _tableDataArr[indexPath.row];
    return entity.height;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MobileTrafficEntity *entity = _tableDataArr[indexPath.row];
    static NSString *cellId = @"MobileTrafficTopUpCell";
    MobileTrafficTopUpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MobileTrafficTopUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell setDelegate:(id)_controller];
    [cell reloadData:entity];
    [cell setLineType:EBottomShortLine];
    if ([_tableDataArr count]-1 == indexPath.row) {
        [cell setLineType:ELineUnknow];
    }
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}




// 充值记录
-(void) buttonClicked:(id)sender {
    
    MobileTopUpRecordViewController* vc = [[MobileTopUpRecordViewController alloc] initWithType:1];
    [_controller.navigationController pushViewController:vc animated:YES];
}



//-(void) reloadFooterData:(NSString*)title problemUrl:(NSString*)url {

//    _problem_href = url;
//    if (title && url) {
//    
//        _button.hidden = NO;
//        [_button setTitle:title forState:UIControlStateNormal];
//        
//    }
//    else{
//        _button.hidden = YES;
//    }

//    // 常见问题
//    self.tableView.tableFooterView = nil;
//    if (title && url) {
//        
//        static NSString *footerId = @"MobileTrafficTopUpFooter";
//        MobileTrafficTopUpFooter* footer = [[MobileTrafficTopUpFooter alloc] initWithReuseIdentifier:footerId];
//        [footer reloadData:title problemUrl:url];
//        self.tableView.tableFooterView = footer;
//    }
//}


@end





