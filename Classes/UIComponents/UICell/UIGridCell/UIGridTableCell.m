//
//  UIGridTableCell.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIGridTableCell.h"
#import "UIGridCollectionCell.h"
#import "UICellEntity.h"



@interface UIGridTableCell ()
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



@implementation UIGridTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        _dataArray = [[NSMutableArray alloc] init];
        
        [self setAccessoryType:UITableViewCellAccessoryNone];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        flowLayout.itemSize = CGSizeMake(kIousGridIconW, kGridIconCellH);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, kGridIconCellH) collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.scrollEnabled = NO;
        [self.contentView addSubview:_collectionView];
        
        //     keep 10px on left and right
        UIEdgeInsets insets = _collectionView.contentInset;
        insets.left = 10.f;
        insets.right = 10.f;
        _collectionView.contentInset = insets;
        [_collectionView registerClass:[UIGridCollectionCell class] forCellWithReuseIdentifier:@"UIGridCollectionCell"];
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
    
    UIGridCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UIGridCollectionCell" forIndexPath:indexPath];
    UIElementEntity *entity = [self.dataArray objectAtIndex:indexPath.row];
    [cell reloadData:entity];
    return cell;
}


-(void) reloadData:(UICellEntity *)entity{
    
    if (_entity == entity)
        return;
    _entity = entity;
    
    NSInteger count = [entity.list count];
    if (entity.list.count >= 5) {
        count = 5;
    }
    CGFloat width = (kMainScreenW - 20)/count;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(width, kGridIconCellH);
    
    [_dataArray removeAllObjects];
    if (entity.list.count > 0) {
        [_dataArray addObjectsFromArray:entity.list];
    }
    [_collectionView reloadData];
}


@end



