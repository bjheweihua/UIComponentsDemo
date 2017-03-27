//
//  TestViewController.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/2.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "TestViewController.h"
#import "TestEntity.h"
#import "TestTableViewCell.h"
#import "TestGridTableCell.h"
#import "TestHeaderView.h"
#import "GestureUITableView.h"


static NSString *headerId = @"TestHeaderView";
#define kContentOffset @"contentOffset"

@interface TestViewController ()
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




@implementation TestViewController


-(void) dealloc {
    
    [_tableView removeObserver:self forKeyPath:kContentOffset context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor jrColorWithHex:@"#f9f9f9"];
    [self addNavigationBar:@"test page"];
    
    // init data
    [self initData];
    
    // init table
    [self initTableView];
}



-(void)tableToTop{
    
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}




// init UITableView
-(void) initTableView{
    
    // table _naviBarView
    CGRect rect = CGRectMake(0, 0, kMainScreenW, kMainScreenH);
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
    [self.view addSubview:_tableView];
    [_tableView addObserver:self forKeyPath:kContentOffset options:NSKeyValueObservingOptionInitial context:nil];
}

-(void) initData {
    
    _tableDataArr = [[NSMutableArray alloc] init];
    TestEntity* secton1 = [[TestEntity alloc] init];
    secton1.type = 0;
    secton1.height = 0;
    for (int i = 0; i < 6 ; ++i) {
        
        TestEntity* entity = [[TestEntity alloc] init];
        entity.type = 0;
        
        [secton1.list addObject:entity];
    }
    [_tableDataArr addObject:secton1];
    
    
    TestEntity* secton2 = [[TestEntity alloc] init];
    secton2.type = 1;
    secton2.height = 50;
    for (int i = 0; i < 1 ; ++i) {
        
        TestEntity* entity = [[TestEntity alloc] init];
        entity.type = 1;
        
        [secton2.list addObject:entity];
    }
    [_tableDataArr addObject:secton2];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

// header
 -(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 
     TestEntity* sectionEntity = _tableDataArr[section];
     return sectionEntity.height;
 }
 
 -(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
 
     TestEntity* sectionEntity = _tableDataArr[section];
     if (sectionEntity.type == 0) {
         
         return [[UIView alloc] init];
     }
     
     TestHeaderView  *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
     if (!headView) {
         headView = [[TestHeaderView alloc] initWithReuseIdentifier:headerId];
         headView.contentView.backgroundColor = [UIColor jrColorWithHex:@"#f9f9f9"];
     }
//     [headView reloadData:sectionEntity.hEntity];
     
     return headView;
 }
 


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



-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_tableDataArr count];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    TestEntity* sectionEntity = _tableDataArr[section];
    return [sectionEntity.list count];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TestEntity* section = _tableDataArr[indexPath.section];
//    TestEntity* entity = section.list[indexPath.row];
    
    switch (section.type) {
        case 0:{
            
            return 50;
        }
            break;
        case 1:{
            
            return kMainScreenH - 64;
        }
            break;
        default:
            break;
    }
    
    return 0;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    return [self jr_TableView:tableView cellForRowAtIndexPath:indexPath];
    
    TestEntity* section = _tableDataArr[indexPath.section];
    TestEntity* entity = section.list[indexPath.row];
    
    switch (entity.type) {
        case 0:{
            
            static NSString *cellId = @"TestTableViewCell";
            TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell){
                
                cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [cell reloadData:entity];
            if ((indexPath.row + 1) % 2) {
                cell.contentView.backgroundColor = [UIColor jrColorWithHex:@"#cccccc"];
            }
            else{
                cell.contentView.backgroundColor = [UIColor jrColorWithHex:@"#ffffff"];
            }
            return cell;
        }
            break;
        case 1:{
            
            static NSString *cellId = @"TestGridTableCell";
            TestGridTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell){
                
                cell = [[TestGridTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
//            [cell reloadData:entity];
            return cell;
        }
            break;
        default:
            break;
    }

    return [[UITableViewCell alloc] init];
}


#pragma mark - Table view delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}




- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (![keyPath isEqualToString:kContentOffset] || ![object isKindOfClass:[UITableView class]])
        return;
    
    if (_tableView != object) {
        return;
    }
    
    CGFloat newY = _tableView.contentOffset.y;
    
    // 看下边内容， 隐藏
    UITableViewHeaderFooterView  *headView = [_tableView headerViewForSection:1];
    if (!headView) {
        return;
    }
    CGRect rect = [_tableView convertRect:headView.frame toView:_tableView];
    if (CGRectGetMinY(rect) > 300) {
        
        // 需要登录的通知中心
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kHeaderChange" object:@(1)];
    }
//    else if (300 == CGRectGetMinX(rect)){
//        if (newY < _oldY || newY == 0) {
//            // 看上边内容， 显示
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"kHeaderChange" object:@(1)];
//        } else if (newY > _oldY) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"kHeaderChange" object:@(0)];
//        }
//    }
    else{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kHeaderChange" object:@(0)];
    }
    NSLog(@"rect = %@", @(CGRectGetMinY(rect)));

    
    _oldY = newY;
}


#pragma mark- ScrollViewDelegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    if (scrollView == _tableView) {
//        
////        _oneVc.tableView.scrollEnabled = NO;
////        _twoVc.tableView.scrollEnabled = NO;
////        _threeVc.tableView.scrollEnabled = NO;
////        _fourVc.tableView.scrollEnabled = NO;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"kHeaderChange" object:@(0)];
//        
//    }
//    
//}

@end
