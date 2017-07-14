//
//  MobileTopUpRecordSegmentedView.m
//  JDMobile
//
//  Created by heweihua on 16/5/24.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTopUpRecordSegmentedView.h"


#define kTitleFont  (16.0)
#define kSegment_W  (kMainScreenW)
#define kSegment_H  (50.0) // (40)


@implementation MobileTopUpRecordSegmentedView

-(instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
    
        CGFloat pointX = (CGRectGetWidth(self.frame)-kSegment_W)/2;
        CGRect rect = CGRectMake(pointX, 0, kSegment_W, kSegment_H);
        NSArray *titleArr = @[@"充话费",@"充流量"];
        _segmentControl = [[UISegmentedControl alloc] initWithItems:titleArr];
        _segmentControl.frame = rect;
        _segmentControl.tintColor = [UIColor whiteColor];
        _segmentControl.selectedSegmentIndex = 0;
        [self addSubview:_segmentControl];
        
        //字体的属性字典
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor jrColorWithHex:kBlueColor],NSForegroundColorAttributeName,[UIFont getSystemFont:kTitleFont Weight:KFontWeightRegular],NSFontAttributeName, nil];
        [_segmentControl setTitleTextAttributes:dic forState:UIControlStateSelected];//选中时候的字体属性

        //字体的属性字典
        dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor jrColorWithHex:@"#666666"],NSForegroundColorAttributeName,[UIFont getSystemFont:kTitleFont Weight:KFontWeightRegular],NSFontAttributeName, nil];
        [_segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];//未选中时候的字体属性

        
        CGFloat pointH = 2.0;//SINGLE_LINE_HEIGHT(1.0f);
        rect = CGRectMake(0, CGRectGetHeight(self.frame) - pointH, kMainScreenW/2.0, pointH);
        _lineView = [[UIView alloc] initWithFrame:rect];
        _lineView.backgroundColor = [UIColor jrColorWithHex:kBlueColor];
        [self addSubview:_lineView];
    }
    return self;
}


@end



