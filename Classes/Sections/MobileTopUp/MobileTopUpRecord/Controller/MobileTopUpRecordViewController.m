//
//  MobileTopUpRecordViewController.m
//  JDMobile
//
//  Created by heweihua on 16/4/22.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTopUpRecordViewController.h"
#import "MobileTopUpRecordSegmentedView.h"
#import "MobileTopUpRecordView.h"

@interface MobileTopUpRecordViewController ()
<
UIScrollViewDelegate
>
{
    NSInteger       _nType; // 0:话费  1：流量
    MobileTopUpRecordSegmentedView* _segControl;
    UIScrollView* _slView;
    
    MobileTopUpRecordView* _lTableView;
    MobileTopUpRecordView* _rTableView;
}
@end


@implementation MobileTopUpRecordViewController

-(void) dealloc{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(instancetype) initWithType:(NSInteger)type{
    
    self = [super init];
    if (self) {
        
        _nType = type;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNavigationBar:@"充值记录"];
    [self initWithSegmentedControlAndScrollView];
}

/*
-(void) initWithSegmentedControlAndScrollView {
    
    CGFloat pointX = (kMainScreenW - 200)/2;
    _segControl = [[MobileTopUpRecordSegmentedView alloc] initWithFrame:CGRectMake(pointX, 64.f, 200, 64 - 0.5)];
    _segControl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_segControl];
    [_segControl.segmentControl addTarget:self action:@selector(segmentControlClick:) forControlEvents:UIControlEventValueChanged];
    
    CGFloat pointY = CGRectGetMaxY(_segControl.frame);
    CGRect rect = CGRectMake(0, pointY, kMainScreenW, kMainScreenH - pointY);
    _slView = [[UIScrollView alloc] initWithFrame:rect];
    _slView.contentSize = CGSizeMake(kMainScreenW*2, 0);
    _slView.pagingEnabled = YES;
    _slView.delegate = self;
    _slView.scrollsToTop = NO;
    _slView.showsHorizontalScrollIndicator = NO;
    _slView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_slView];
    
    
    // left table view
    rect = CGRectMake(0, 0, CGRectGetWidth(_slView.frame), CGRectGetHeight(_slView.frame));
    _lTableView = [[MobileTopUpRecordView alloc] initWithFrame:rect];
    [_lTableView setController:self type:0];
    [_slView addSubview:_lTableView];
    [_lTableView requestData];
    
    // right table view
    rect = CGRectMake(CGRectGetWidth(_lTableView.frame), 0, CGRectGetWidth(_slView.frame), CGRectGetHeight(_slView.frame));
    _rTableView = [[MobileTopUpRecordView alloc] initWithFrame:rect];
    [_rTableView setController:self type:1];
    [_slView addSubview:_rTableView];
    [_rTableView requestData];
    
    if(1 == _nType){
        
        _slView.contentOffset=CGPointMake(kMainScreenW, 0);
        _segControl.segmentControl.selectedSegmentIndex = 1;
    }
    else if(0 == _nType){
        
        _slView.contentOffset=CGPointMake(0, 0);
        _segControl.segmentControl.selectedSegmentIndex = 0;
    }
}*/

-(void) initWithSegmentedControlAndScrollView {
    
    self.view.backgroundColor = [UIColor jrColorWithHex:@"#f5f5f5"];
    _segControl = [[MobileTopUpRecordSegmentedView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenW, 50)];
    _segControl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_segControl];
    [_segControl.segmentControl addTarget:self action:@selector(segmentControlClick:) forControlEvents:UIControlEventValueChanged];
    
    CGFloat pointY = CGRectGetMaxY(_segControl.frame);
    CGRect rect = CGRectMake(0, pointY, kMainScreenW, kMainScreenH - pointY);
    _slView = [[UIScrollView alloc] initWithFrame:rect];
    _slView.contentSize = CGSizeMake(kMainScreenW*2, 0);
    _slView.pagingEnabled = YES;
    _slView.delegate = self;
    _slView.scrollsToTop = NO;
    _slView.showsHorizontalScrollIndicator = NO;
    _slView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_slView];
    
    
    // left table view
    rect = CGRectMake(0, 0, CGRectGetWidth(_slView.frame), CGRectGetHeight(_slView.frame));
    _lTableView = [[MobileTopUpRecordView alloc] initWithFrame:rect];
    [_lTableView setController:self type:0];
    [_slView addSubview:_lTableView];
    [_lTableView requestData];
    
    // right table view
    rect = CGRectMake(CGRectGetWidth(_lTableView.frame), 0, CGRectGetWidth(_slView.frame), CGRectGetHeight(_slView.frame));
    _rTableView = [[MobileTopUpRecordView alloc] initWithFrame:rect];
    [_rTableView setController:self type:1];
    [_slView addSubview:_rTableView];
    [_rTableView requestData];
    
    if(1 == _nType){
        
        _slView.contentOffset=CGPointMake(kMainScreenW, 0);
        _segControl.segmentControl.selectedSegmentIndex = 1;
        
        CGRect rect = _segControl.lineView.frame;
        rect.origin.x = kMainScreenW/2.f;
        [_segControl.lineView setFrame:rect];
    }
    else if(0 == _nType){
        
        _slView.contentOffset=CGPointMake(0, 0);
        _segControl.segmentControl.selectedSegmentIndex = 0;
        
        CGRect rect = _segControl.lineView.frame;
        rect.origin.x = 0;
        [_segControl.lineView setFrame:rect];
    }
}

-(void) leftButtonDown {
    
    [super leftButtonDown];
}


-(void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}





#pragma mark segment点击
-(void)segmentControlClick:(UISegmentedControl *)segmentControl{
    
    if (segmentControl.selectedSegmentIndex == 0) {
        //
        [self leftTabClick:nil];
    }else{
        [self rightTabClick:nil];
    }
}


#define mark 点击左侧按钮
-(void)leftTabClick:(UIButton *)btn{
    
    [UIView animateWithDuration:0.5f animations:^{
        _slView.contentOffset=CGPointMake(0, 0);
        
        CGRect rect = _segControl.lineView.frame;
        rect.origin.x = 0;
        [_segControl.lineView setFrame:rect];
    }];
}

#pragma mark 点击右侧按钮
-(void)rightTabClick:(UIButton *)btn{
    
    [UIView animateWithDuration:0.5f animations:^{
        _slView.contentOffset = CGPointMake(CGRectGetWidth(_slView.frame), 0);
        
        CGRect rect = _segControl.lineView.frame;
        rect.origin.x = kMainScreenW/2.f;
        [_segControl.lineView setFrame:rect];
    }];
}


#pragma mark scrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x >= 0 && scrollView.contentOffset.x < kMainScreenW) {
        
        //选中左边
        [self leftTabClick:nil];
        _segControl.segmentControl.selectedSegmentIndex = 0;
    }else{
        
        //选中右边
        [self rightTabClick:nil];
        _segControl.segmentControl.selectedSegmentIndex = 1;
    }
}


@end

