//
//  UIHorizontalCell.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/28.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIHorizontalImgTableCell.h"
#import "UIScrollView+ElasticRefresh.h"
#import "UIHorizontalImgView.h"
#import "UICellEntity.h"


@interface UIHorizontalImgCollectionCell : UICollectionViewCell

@property (nonatomic,strong) UIHorizontalImgView *cardView;
-(void)reloadData:(UIElementEntity *)entity;

@end

@implementation UIHorizontalImgCollectionCell


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        _cardView = [[UIHorizontalImgView alloc] initWithFrame:CGRectMake(0, 0, kUIHorizontalImgView_W, kUIHorizontalImgView_H-21.f)];
        [self.contentView addSubview:_cardView];
        _cardView.clipsToBounds = NO;
        _cardView.layer.shadowColor = [UIColor jrColorWithHex:@"#EBECEE"].CGColor;
        _cardView.layer.shadowOffset = CGSizeMake(0, 2.f);
        _cardView.layer.shadowOpacity = 0.9;
        _cardView.layer.shadowRadius = 3.5f;
    }
    return self;
}

-(void)reloadData:(UIElementEntity *)entity{
    
    [_cardView reloadData:entity];
}

@end






@interface UIHorizontalImgTableCell ()
<
UIScrollViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource
>
{
    UICollectionView *_collectionView;
    UICellEntity *_entity;
}
@end

@implementation UIHorizontalImgTableCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        [self setAccessoryType:UITableViewCellAccessoryNone];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(kUIHorizontalImgView_W, kUIHorizontalImgView_H-21.f);
        flowLayout.sectionInset = UIEdgeInsetsMake(5.f, kSafePadding, 16.f, kSafePadding);// 阴影：top:5, bottom:16
        flowLayout.minimumLineSpacing = 10;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, kUIHorizontalImgView_H) collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        [self.contentView addSubview:_collectionView];
        
        [_collectionView registerClass:[UIHorizontalImgCollectionCell class] forCellWithReuseIdentifier:@"UIHorizontalImgCollectionCell"];
    }
    return self;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _entity.list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIHorizontalImgCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UIHorizontalImgCollectionCell" forIndexPath:indexPath];
    UIElementEntity *model = [_entity.list objectAtIndexCheck:indexPath.row];
    [cell reloadData:model];
    return cell;
}


-(void)reloadData:(UICellEntity *)entity{
    
    if (_entity == entity)
        return;
    _entity = entity;
    [_collectionView reloadData];
    
    if (_entity.list && [_entity.list count] >= 3) {
        
//        @JDJRWeakify(self);
        [_collectionView refreshHeaderWithBlock:^{
            
//            @JDJRStrongify(self);
//            [JRJumpCenter clictToView:self.signalModel.MoreEntity];
        }elasticH:kUIHorizontalImgView_H];
        
    }else{
        [_collectionView removeElasticViewFromSuperview];
    }
    
}

@end













