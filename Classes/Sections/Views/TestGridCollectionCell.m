//
//  TestGridCollectionCell.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/2.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "TestGridCollectionCell.h"
#import "TestEntity.h"
#import "TestTableViewCell.h"
#import "GestureUITableView.h"



@interface TestGridCollectionCell ()
<
UITableViewDataSource,
UITableViewDelegate
>
{
    GestureUITableView*      _tableView;
    NSMutableArray*   _tableDataArr;       //  table 数据数组
}
@property(nonatomic, assign) CGFloat oldY;
@end

@implementation TestGridCollectionCell

-(instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        // 需要登录的通知中心
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headerChange:) name:@"kHeaderChange" object:nil];
        
        self.bHighLight = NO;
        [self initData];
        [self initTableView];
    }
    return self;
}




-(void)reloadData:(BaseEntity*)entity{
    
}


// init UITableView
-(void) initTableView{
    
    // table _naviBarView
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    _tableView = [[GestureUITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionHeaderHeight = 0.0;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.tableFooterView.backgroundColor = [UIColor jrColorWithHex:@"#f9f9f9"];
//    _tableView.scrollEnabled = NO;
    [self.contentView addSubview:_tableView];
}

-(void) initData {
    
    _tableDataArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 100 ; ++i) {
        
        TestEntity* entity = [[TestEntity alloc] init];
        entity.title = @(i).stringValue;
        entity.type = 0;
        [_tableDataArr addObject:entity];
    }
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

// header
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    TestEntity* sectionEntity = _tableDataArr[section];
//    return sectionEntity.height;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    TestEntity* sectionEntity = _tableDataArr[section];
//    if (sectionEntity.type == 0) {
//        
//        return [[UIView alloc] init];
//    }
//    
//    static NSString *headerId = @"TestHeaderView";
//    TestHeaderView  *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
//    if (!headView) {
//        headView = [[TestHeaderView alloc] initWithReuseIdentifier:headerId];
//        headView.contentView.backgroundColor = [UIColor jrColorWithHex:@"#f9f9f9"];
//    }
//    //     [headView reloadData:sectionEntity.hEntity];
//    
//    return headView;
//}



// footer
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//
//    return 10.f;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

//    static NSString *footerId = @"UITableViewHeaderFooterView";
//    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerId];
//    if (!footer) {
//        footer = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footerId];
//        footer.contentView.backgroundColor = [UIColor jrColorWithHex:@"#f9f9f9"];
//    }
//    return footer;
//    return nil;
//}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
//    _tableView.scrollEnabled = YES;
    
//    if (newY > self.oldY) { // up
////        NSLog(@"up");
//        
//    }else if(newY < self.oldY){// down
////        NSLog(@"down");
//    }
//    else{
//    }
    
    if (_tableView != scrollView) {
        return;
    }
    @synchronized (self) {
        
        CGFloat newY = scrollView.contentOffset.y;
        NSLog(@"newY ======= %@",@(newY));
        if (newY <= 0) {
//            _tableView.scrollEnabled = NO;
            [_tableView setContentOffset:CGPointZero];
            
        }
//        else if (newY == 0){
//            
//            if (newY > self.oldY) { // up
//                _tableView.scrollEnabled = YES;
//                
//            }else if(newY < self.oldY){// down
//                _tableView.scrollEnabled = NO;
//            }
//        }
        else{
//            _tableView.scrollEnabled = YES;
        }
        self.oldY = newY;
    }
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_tableDataArr count];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TestEntity* entity = _tableDataArr[indexPath.row];
    if (!entity) {
        return [[UITableViewCell alloc] init];
    }
    static NSString *cellId = @"TestTableViewCell";
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell){
        
        cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell reloadData:entity];
    if ((indexPath.row + 1) % 2) {
        cell.contentView.backgroundColor = [UIColor redColor];
    }
    else{
        cell.contentView.backgroundColor = [UIColor jrColorWithHex:@"#ffffff"];
    }
    return cell;
}


#pragma mark - Table view delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}


- (void)headerChange:(NSNotification *)notification{
    
    @synchronized (self) {
        BOOL enabled  = [notification.object boolValue];
//        _tableView.scrollEnabled = enabled;
        if(enabled == NO){
            [_tableView setContentOffset:CGPointZero];
        }
    }
}



@end











