//
//  UIBannerTableCell.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIBannerTableCell.h"
#import "UICellEntity.h"
#import "UIBannerCollectionCell.h"
#import "UIPageControlView.h"


@interface UIBannerTableCell ()
<
UIScrollViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, assign) BOOL autoScroll;
@property (nonatomic, strong) NSTimer *timer; // timer clock
@property (nonatomic, strong) NSMutableArray *dataArr;//前边插一个元素，后边插一个元素
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControlView *pageControl;
@property (nonatomic, assign) CGFloat cellH;
@property (nonatomic, weak  ) UICellEntity *entity;
@end


static NSString *cellID = @"UIBannerCollectionCell";
@implementation UIBannerTableCell

-(void) dealloc {
    
    [_dataArr removeAllObjects];
    [self removeTimer];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        // 隐藏系统的小箭头
        [self setAccessoryType:UITableViewCellAccessoryNone];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.cellH = CGRectGetHeight(self.frame);
        
        _dataArr = [[NSMutableArray alloc] initWithCapacity:0];
        [self.contentView addSubview:self.collectionView];
        [self.contentView addSubview:self.pageControl];
    }
    return self;
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIBannerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    UIElementEntity *model = [self.dataArr objectAtIndex:indexPath.row];
    [cell reloadData:model];
    return cell;
}

//每个Cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kMainScreenW, self.cellH);
}


-(void)reloadData:(UICellEntity *)entity{
    
    if (_entity == entity) {
        return;
    }
    _entity = entity;
    self.cellH = entity.height;
    self.height = entity.height;
    self.collectionView.height = entity.height;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(kMainScreenW, self.cellH);
    
    _pageControl.minY = self.cellH - 15;
    
    //新创建一个_turnArray是为了上边的if能起作用
    [_dataArr removeAllObjects];
    if (entity.list.count >= 2) {
        
        [_dataArr addObject:[entity.list lastObject]];
        [_dataArr addObjectsFromArray:entity.list];
        [_dataArr addObject:[entity.list firstObject]];
        
    }else{
        
        [_dataArr addObjectsFromArray:entity.list];
    }
    
    [_collectionView reloadData];
    
    if (_dataArr.count < 2) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self removeTimer];
            
            self.autoScroll = NO;
            self.pageControl.hidden = YES;
            [self.pageControl setItemCount:0];
            _collectionView.contentOffset = CGPointMake(0, 0);
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self setupTimer];
            
            self.autoScroll = YES;
            self.pageControl.hidden = NO;
            [self.pageControl setItemCount:entity.list.count];
            _collectionView.contentOffset = CGPointMake(CGRectGetWidth(_collectionView.frame), 0);
        });
    };
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.dataArr.count < 2) return;
    
    if (scrollView.contentOffset.x <= 0) {
        
        scrollView.contentOffset = CGPointMake((self.dataArr.count - 2)*CGRectGetWidth(_collectionView.frame), scrollView.contentOffset.y);
        
    }else if (scrollView.contentOffset.x >= (self.dataArr.count - 1)*CGRectGetWidth(_collectionView.frame)) {
        
        scrollView.contentOffset = CGPointMake(CGRectGetWidth(_collectionView.frame), scrollView.contentOffset.y);
    }
    [self resetCurrentPageWithContentOffSet:scrollView.contentOffset];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.pageControl isScrolling:YES];
    if (self.autoScroll) {
        [self removeTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self.pageControl isScrolling:NO];
    if (self.autoScroll) {
        [self setupTimer];
    }
}


-(UICollectionView*) collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0.0;
        flowLayout.itemSize = CGSizeMake(kMainScreenW, self.cellH);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, self.cellH) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UIBannerCollectionCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

- (UIPageControlView *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [[UIPageControlView alloc] init];
        _pageControl.size = CGSizeMake(100, 2);
        _pageControl.midX = kMainScreenW * 0.5;
        _pageControl.layer.cornerRadius = 1;
        _pageControl.clipsToBounds = YES;
    }
    _pageControl.minY = self.cellH - 15;
    return _pageControl;
}

- (void)setupTimer{
    
    [self removeTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.f target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}


- (void)removeTimer{
    
    [_timer invalidate];
    _timer = nil;
}

- (void)automaticScroll{
    
    NSInteger num = (_collectionView.contentOffset.x)/CGRectGetWidth(_collectionView.frame);
    
    if ((num > self.dataArr.count - 1) && (num < 0)) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }else{
        NSInteger item = num + 1;
        if (item > self.dataArr.count -1) {
            item = 0;
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

-(void)resetCurrentPageWithContentOffSet:(CGPoint)contentOffSet{
    
    CGFloat width = CGRectGetWidth(_collectionView.frame);
    CGFloat rate = (_collectionView.contentOffset.x - width) / (_entity.list.count * width);
    CGFloat indicatorX = CGRectGetWidth(self.pageControl.frame) * rate;
    [self.pageControl setIndicatorX:indicatorX];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    if (!newSuperview) {
        [self removeTimer];
    }
}

@end










