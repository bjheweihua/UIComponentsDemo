//
//  TestHeaderView.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/5.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "TestHeaderView.h"
#import "TestSegmented.h"

@implementation TestHeaderView

-(void) dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self){
        
        self.contentView.backgroundColor = [UIColor jrColorWithHex:@"#f5f5f5"];
        self.frame = CGRectMake(0, 0, kMainScreenW, 50);
        
        [self initWithSegmentedControl];
    }
    return self;
}


-(void) initWithSegmentedControl {
    
    _segControl = [[TestSegmented alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, 50)];
    [_segControl setDelegate:self];
    _segControl.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_segControl];
}


#pragma mark scrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x >= 0 && scrollView.contentOffset.x < kMainScreenW) {
        
        //选中左边
//        [self leftTabClick:nil];
        _segControl.segmentControl.selectedSegmentIndex = 0;
    }else{
        
        //选中右边
//        [self rightTabClick:nil];
        _segControl.segmentControl.selectedSegmentIndex = 1;
    }
}



-(void) reloadDataWithArr:(NSArray*)arr {
    
    _tableArr = arr;
}





@end
