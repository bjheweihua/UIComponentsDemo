//
//  TestTableViewCell.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/2.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "TestTableViewCell.h"
#import "TestEntity.h"

@interface TestTableViewCell ()
//@property(nonatomic, weak) TestEntity *entity;

@end


@implementation TestTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        // 系统的小箭头
        [self setAccessoryType:UITableViewCellAccessoryNone];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
//        _clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
//        [_clickBtn setBackgroundColor:[UIColor clearColor]];
//        [_clickBtn addTarget:self action:@selector(btnClick:withEvent:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_clickBtn];
//        
//        //        CGFloat pointH = GetPointWith(0.5);
//        CGFloat pointH = 0.5;
//        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - pointH, kMainScreenW, pointH)];
//        [_lineView setBackgroundColor:[UIColor jrColorWithHex:@"#eeeeee"]];
//        [self.contentView addSubview:_lineView];
//        _lineView.hidden = YES;
        
        self.clickBtn.height = CGRectGetHeight(self.frame);
        self.lineView.height = CGRectGetHeight(self.frame) - CGRectGetHeight(self.lineView.frame);
    }
    return self;
}


-(void) reloadData:(TestEntity *)entity{
    
    if (self.entity == entity)
        return;
    self.entity = entity;
    
    self.textLabel.text = entity.title;
//
//    NSInteger count = [entity.list count];
//    if (entity.list.count >= 5) {
//        count = 5;
//    }
//    CGFloat width = (kMainScreenW - 20)/count;
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
//    flowLayout.itemSize = CGSizeMake(width, kGridIconCellH);
//    
//    [_dataArray removeAllObjects];
//    if (entity.list.count > 0) {
//        [_dataArray addObjectsFromArray:entity.list];
//    }
//    [_collectionView reloadData];
}



@end




