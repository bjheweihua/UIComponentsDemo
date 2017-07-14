//
//  MobileTrafficTopUpViewCell.m
//  JDMobile
//
//  Created by heweihua on 16/6/28.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTrafficTopUpViewCell.h"
#import "MobileTrafficTopUpSegmented.h"
#import "MobileTrafficTopUpTableView.h"
#import "MobileTrafficTopUpViewController.h"
#import "MobileTrafficEntity.h"


@interface MobileTrafficTopUpViewCell ()
<
UIScrollViewDelegate,
MobileTrafficTopUpSegmentedDelegate
>
{
    NSInteger       _nType; // 0:全国通用  1：省内通用
    MobileTrafficTopUpSegmented* _segControl;
    UIScrollView* _slView;
    
    MobileTrafficTopUpTableView* _lTableView;
    MobileTrafficTopUpTableView* _rTableView;
    MobileTrafficTopUpViewController* _controller;
    
    NSInteger _tableIndex;
    NSArray*  _tableArr;
}

@property(nonatomic, strong) UILabel *headerLabel;// 全国通用，立即生效
@end

@implementation MobileTrafficTopUpViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.contentView.backgroundColor = [UIColor jrColorWithHex:@"#f5f5f5"];
    }
    return self;
}


-(void) setController:(MobileTrafficTopUpViewController*)vc{
    
    _controller = vc;
    // 全国通用，立即生效
    _tableIndex = 0;
    _tableArr = nil;
    [self initHeaderView];
    [self initWithSegmentedControlAndScrollView];
}

-(void) initHeaderView {
    
    // 全国通用，立即生效
    CGFloat pointW = kMainScreenW - kOffsetX*2;
    CGFloat pointY = 10;
    CGRect rect = CGRectMake(kOffsetX, pointY, pointW, 16.5f);
    _headerLabel = [[UILabel alloc] initWithFrame:rect];
    _headerLabel.backgroundColor = [UIColor clearColor];
    _headerLabel.textColor = [UIColor jrColorWithHex:@"#999999"];
    _headerLabel.font = [UIFont getSanFranciscoFont:12.0 Weight:KSFWeightRegular];
    [self.contentView addSubview:_headerLabel];
}



-(void) initWithSegmentedControlAndScrollView {
    
    _segControl = [[MobileTrafficTopUpSegmented alloc] initWithFrame:CGRectMake(0, 10, kMainScreenW, 50)];
    [_segControl setDelegate:self];
    _segControl.backgroundColor = [UIColor whiteColor];
    [self addSubview:_segControl];
    
    
    CGFloat pointY = CGRectGetMaxY(_segControl.frame);
    CGRect rect = CGRectMake(0, pointY, kMainScreenW, kMainScreenH - pointY);
    _slView = [[UIScrollView alloc] initWithFrame:rect];
    _slView.contentSize = CGSizeMake(kMainScreenW*2, 0);
    _slView.pagingEnabled = YES;
    _slView.delegate = self;
    _slView.scrollsToTop = NO;
    _slView.showsHorizontalScrollIndicator = NO;
    _slView.showsVerticalScrollIndicator = NO;
    _slView.alwaysBounceVertical = NO;
    [self addSubview:_slView];
    
    
    // left table view
    rect = CGRectMake(0, 0, CGRectGetWidth(_slView.frame), CGRectGetHeight(_slView.frame));
    _lTableView = [[MobileTrafficTopUpTableView alloc] initWithFrame:rect];
    [_lTableView setController:_controller];
    [_slView addSubview:_lTableView];

    
    // right table view
    rect = CGRectMake(CGRectGetWidth(_lTableView.frame), 0, CGRectGetWidth(_slView.frame), CGRectGetHeight(_slView.frame));
    _rTableView = [[MobileTrafficTopUpTableView alloc] initWithFrame:rect];
    [_rTableView setController:_controller];
    [_slView addSubview:_rTableView];
    
    if(1 == _nType){
        
        _slView.contentOffset=CGPointMake(kMainScreenW, 0);
        _segControl.segmentControl.selectedSegmentIndex = 1;
    }
    else if(0 == _nType){
        
        _slView.contentOffset=CGPointMake(0, 0);
        _segControl.segmentControl.selectedSegmentIndex = 0;
    }
}



#pragma mark MobileTrafficTopUpSegmentedDelegate 点击
-(void)segmentControlClick:(UISegmentedControl *)segmentControl
{

    if (segmentControl.selectedSegmentIndex == 0) {
        
        [self leftTabClick:nil];
    }
    else
    {
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
        
        TrafficSectionEntity* section0 = [_tableArr objectAtIndexCheck:0];
        if (section0){
            [_headerLabel setText:section0.tips];
        }
        else{
            [_headerLabel setText:@""];
        }
    }];
}

#pragma mark 点击右侧按钮
-(void)rightTabClick:(UIButton *)btn{
    
    [UIView animateWithDuration:0.5f animations:^{
        _slView.contentOffset = CGPointMake(CGRectGetWidth(_slView.frame), 0);
        CGRect rect = _segControl.lineView.frame;
        rect.origin.x = kMainScreenW/2.f;
        [_segControl.lineView setFrame:rect];
        
        TrafficSectionEntity* section1 = [_tableArr objectAtIndexCheck:1];
        if (section1){
            [_headerLabel setText:section1.tips];
        }
        else{
            [_headerLabel setText:@""];
        }
        
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



-(void) reloadDataWithArr:(NSArray*)arr {
    
    _tableArr = arr;
    if (!_tableArr || [_tableArr count] <= 1) {
        
        TrafficSectionEntity* section0 = [_tableArr objectAtIndexCheck:0];
        if (section0) {
            [_headerLabel setText:section0.tips];
        }else{
            [_headerLabel setText:@""];
        }
        
        CGFloat pointY = 0;
        if (!_headerLabel.text || [_headerLabel.text isEqualToString:@""]) {
            pointY = 10;
        }
        else{
            pointY = kMobileTrafficTopUpTitleH;
        }
        _segControl.hidden = YES;
        
        _slView.contentSize = CGSizeMake(kMainScreenW, 0);
        [_lTableView reloadData:section0.list];
        
        CGRect rect = CGRectMake(0, pointY, kMainScreenW, CGRectGetHeight(self.frame) - pointY);
        [_slView setFrame:rect];
        

        // left table view
        rect = _slView.frame;
        rect.origin.y = 0;
        [_lTableView setFrame:rect];
        [_lTableView.tableView setFrame:rect];
        return;
    }
    
    TrafficSectionEntity* section0 = _tableArr[0];
    TrafficSectionEntity* section1 = _tableArr[1];
    TrafficSectionEntity* selEntity = _tableArr[_tableIndex];
    [_segControl reloadData:@[section0.tabTitle, section1.tabTitle]];
    _headerLabel.text = selEntity.tips;
    
    
    if (0 == _tableIndex) {

        [_headerLabel setText:section0.tips];
    }
    else if (1 == _tableIndex){
        
        [_headerLabel setText:section1.tips];
    }
    
    [_lTableView reloadData:section0.list];
    [_rTableView reloadData:section1.list];
    
    CGFloat pointY = 0;
    if (!_headerLabel.text || [_headerLabel.text isEqualToString:@""]) {
        pointY = 10;
    }
    else{
        pointY = kMobileTrafficTopUpTitleH;
    }
    _segControl.hidden = NO;
    [_segControl setFrame:CGRectMake(0, pointY, kMainScreenW, 50)];
    _slView.contentSize = CGSizeMake(kMainScreenW*2, 0);
    
    
    pointY = CGRectGetMaxY(_segControl.frame);
    CGRect rect = CGRectMake(0, pointY, kMainScreenW, CGRectGetHeight(self.frame) - pointY);
    [_slView setFrame:rect];
    
    
    // left table view
    rect = CGRectMake(0, 0, CGRectGetWidth(_slView.frame), CGRectGetHeight(_slView.frame));
    [_lTableView setFrame:rect];
    [_lTableView.tableView setFrame:rect];
    
    
    // right table view
    rect = CGRectMake(CGRectGetWidth(_lTableView.frame), 0, CGRectGetWidth(_slView.frame), CGRectGetHeight(_slView.frame));
    [_rTableView setFrame:rect];
    
    rect = CGRectMake(0, 0, CGRectGetWidth(_slView.frame), CGRectGetHeight(_slView.frame));
    [_rTableView.tableView setFrame:rect];
}



//-(void) reloadFooterData:(NSString*)title problemUrl:(NSString*)url{
//    
//    [_lTableView reloadFooterData:title problemUrl:url];
//    [_rTableView reloadFooterData:title problemUrl:url];
//}

-(void) reloadFooterData{
    
}
@end














