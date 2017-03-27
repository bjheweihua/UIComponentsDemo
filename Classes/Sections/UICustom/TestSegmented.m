//
//  MobileTrafficTopUpSegmented.m
//  JDMobile
//
//  Created by heweihua on 16/6/28.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "TestSegmented.h"

#define kSegment_W  (kMainScreenW)
#define kSegment_H  (kTestSegmentedH)
#define kTextFont   ([UIFont getSanFranciscoFont:16.0 Weight:KSFWeightRegular])
//#define kTextFont   ([UIFont getSystemFont:16.0 Weight:KFontWeightRegular])

@interface TestSegmented (){
}

@end


@implementation TestSegmented

-(instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        

        CGFloat pointX = (CGRectGetWidth(self.frame)-kSegment_W)/2;
        CGRect rect = CGRectMake(pointX, 0, kSegment_W, kSegment_H);
        
        NSArray *titleArr = @[@"全国通用",@"省内通用"];
        _segmentControl = [[UISegmentedControl alloc] initWithItems:titleArr];
        _segmentControl.frame = rect;
        _segmentControl.tintColor = [UIColor whiteColor];
        _segmentControl.selectedSegmentIndex = 0;
        [self addSubview:_segmentControl];
        [_segmentControl addTarget:self action:@selector(segmentContrClick:) forControlEvents:UIControlEventValueChanged];

        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor jrColorWithHex:@"#508cee"],NSForegroundColorAttributeName,kTextFont,NSFontAttributeName, nil];
        [_segmentControl setTitleTextAttributes:dic forState:UIControlStateSelected];//选中时候的字体属性

        dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor jrColorWithHex:@"#666666"],NSForegroundColorAttributeName,kTextFont,NSFontAttributeName, nil];
        [_segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];//未选中时候的字体属性
        
        // line
        CGFloat pointH = 1.0;
        rect = CGRectMake(0, CGRectGetHeight(self.frame) - pointH, kMainScreenW, pointH);
        UIView* lineView = [[UIView alloc] initWithFrame:rect];
        lineView.backgroundColor = [UIColor jrColorWithHex:kLineColor];
        [self addSubview:lineView];

        // line
//        pointH = SINGLE_LINE_HEIGHT(1.0f);
        rect = CGRectMake(0, CGRectGetHeight(self.frame) - pointH, kMainScreenW/2.0, pointH);
        _lineView = [[UIView alloc] initWithFrame:rect];
        _lineView.backgroundColor = [UIColor jrColorWithHex:@"#508cee"];
        [self addSubview:_lineView];
    }
    return self;
}


//-(void)reloadData:(NSArray *)titleArray{
//    
//    [_segmentControl removeAllSegments];//删除之前的segment
//    
//    CGFloat pointX = (CGRectGetWidth(self.frame)-kSegment_W)/2;
//    CGRect rect = CGRectMake(pointX, 0, kSegment_W, kSegment_H);
//    
////    NSArray *titleArr = @[@"全国通用",@"省内通用"];
//    _segmentControl = [[UISegmentedControl alloc] initWithItems:titleArray];
//    _segmentControl.frame = rect;
//    _segmentControl.tintColor = [UIColor whiteColor];
//    _segmentControl.selectedSegmentIndex = 0;
//    [_segmentControl addTarget:self action:@selector(segmentContrClick:) forControlEvents:UIControlEventValueChanged];
//    [self addSubview:_segmentControl];
//    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor jrColorWithHex:kBlueColor],NSForegroundColorAttributeName,kTextFont,NSFontAttributeName, nil];
//    [_segmentControl setTitleTextAttributes:dic forState:UIControlStateSelected];//选中时候的字体属性
//    
//    dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor jrColorWithHex:@"#666666"],NSForegroundColorAttributeName,kTextFont,NSFontAttributeName, nil];
//    [_segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];//未选中时候的字体属性
//    
//    // line
//    CGFloat pointH = SINGLE_LINE_HEIGHT(1.0f);
//    rect = CGRectMake(0, CGRectGetHeight(self.frame) - pointH, UIScreen_W, pointH);
//    UIView* lineView = [[UIView alloc] initWithFrame:rect];
//    lineView.backgroundColor = [UIColor jrColorWithHex:@"#eeeeee"];
//    [self addSubview:lineView];
//    
//    // line
//    if (_lineView) {
//        [_lineView removeFromSuperview];
//    }
//    pointH = 2.0;//SINGLE_LINE_HEIGHT(1.0f);
//    rect = CGRectMake(0, CGRectGetHeight(self.frame) - pointH, UIScreen_W/2.0, pointH);
//    _lineView = [[UIView alloc] initWithFrame:rect];
//    _lineView.backgroundColor = [UIColor jrColorWithHex:kBlueColor];
//    [self addSubview:_lineView];
//}
//
-(void) segmentContrClick:(UISegmentedControl*)seg {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControlClick:)]) {
        [self.delegate segmentControlClick:seg];
    }
}

@end
