//
//  TestGridTableCell.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/3/2.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "TestGridTableCell.h"
#import "TestEntity.h"
#import "TestGridCollectionCell.h"


@interface TestGridTableCell ()
<
UIScrollViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource
>
{
    UICollectionView *_collectionView;
    TestEntity* _entity;
}

@property(nonatomic, strong) NSMutableArray* dataArray;
@end



@implementation TestGridTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        self.frame = CGRectMake(0, 0, kMainScreenW, kMainScreenH - 50);
        _dataArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 2 ; ++i) {
            
            TestEntity* entity = [[TestEntity alloc] init];
            entity.type = 1;
            [_dataArray addObject:entity];
        }
        
        [self setAccessoryType:UITableViewCellAccessoryNone];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.directionalLockEnabled = YES;
        _collectionView.bounces = NO;
        [self.contentView addSubview:_collectionView];
        
        [_collectionView registerClass:[TestGridCollectionCell class] forCellWithReuseIdentifier:@"TestGridCollectionCell"];
    }
    return self;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TestGridCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestGridCollectionCell" forIndexPath:indexPath];
    TestEntity *entity = [self.dataArray objectAtIndex:indexPath.row];
    [cell reloadData:entity];
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor brownColor];
    }
    else{
        cell.contentView.backgroundColor = [UIColor grayColor];
    }
    return cell;
}


-(void) reloadData:(TestEntity *)entity{
    
//    if (_entity == entity)
//        return;
//    _entity = entity;
    
//    NSInteger count = [entity.list count];
//    if (entity.list.count >= 5) {
//        count = 5;
//    }
//    CGFloat width = (kMainScreenW - 20)/count;
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
//    flowLayout.itemSize = CGSizeMake(width, kGridIconCellH);
    
//    [_dataArray removeAllObjects];
//    if (entity.list.count > 0) {
//        [_dataArray addObjectsFromArray:entity.list];
//    }
//    [_collectionView reloadData];
}



@end
