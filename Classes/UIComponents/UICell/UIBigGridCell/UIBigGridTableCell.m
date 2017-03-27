//
//  UIBigGridCell.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIBigGridTableCell.h"
#import "UIBigGridCollectionCell.h"
#import "UICellEntity.h"


@interface UIBigGridTableCell ()
<
UIScrollViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource
>
{
    UICollectionView *_collectionView;
    UICellEntity* _entity;
}
@property(nonatomic, strong) NSMutableArray* dataArray;
@end



@implementation UIBigGridTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        _dataArray = [[NSMutableArray alloc] init];
        
        [self setAccessoryType:UITableViewCellAccessoryNone];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(kUIBigGridView_W, kUIBigGridView_H);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 16.f, 0, 16.f);
        flowLayout.minimumLineSpacing = 10;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, kUIBigGridView_H) collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.scrollEnabled = NO;
        [self.contentView addSubview:_collectionView];
        
        [_collectionView registerClass:[UIBigGridCollectionCell class] forCellWithReuseIdentifier:@"UIBigGridCollectionCell"];
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
    
    UIBigGridCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UIBigGridCollectionCell" forIndexPath:indexPath];
    UIElementEntity *entity = [self.dataArray objectAtIndex:indexPath.row];
    [cell reloadData:entity];
    return cell;
}


-(void) reloadData:(UICellEntity *)entity{
    
    if (_entity == entity)
        return;
    _entity = entity;
    
    [_dataArray removeAllObjects];
    if (entity.list.count > 0) {
        [_dataArray addObjectsFromArray:entity.list];
    }
    [_collectionView reloadData];
}


@end



