//
//  UIBannerView.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UIBannerView.h"
#import "UIBannerEntity.h"
#import "MobileUIBannerCollectionCell.h"
#import "DCScrollPageControll.h"
#import "JRPageControl.h"

@interface UIBannerView ()
<
UIScrollViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, assign) BOOL autoScroll;
@property (nonatomic, strong) NSTimer *timer; // timer clock
@property (nonatomic, weak  ) NSArray *arr;// 保留数据源
@property (nonatomic, strong) NSMutableArray *dataArr;//前边插一个元素，后边插一个元素
@property (nonatomic, strong) UICollectionView *collectionView;
//@property (nonatomic, strong) DCScrollPageControll *pageControl;
@property (nonatomic, assign) CGFloat cellH;
@property (nonatomic, strong) JRPageControl *pageControlN;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end


static NSString *cellID = @"MobileUIBannerCollectionCell";
@implementation UIBannerView


-(void) dealloc {
    
    [_dataArr removeAllObjects];
    [self removeTimer];
}

//-(void)prepareForReuse{
//    
//    [super prepareForReuse];
//    [self removeTimer];
//}


- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self){
        
        self.backgroundColor = [UIColor whiteColor];
        self.cellH = CGRectGetHeight(self.frame);
        
        _dataArr = [[NSMutableArray alloc] initWithCapacity:0];
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControlN];
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
    
    MobileUIBannerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    UIBannerEntity *model = [self.dataArr objectAtIndex:indexPath.row];
    [cell reloadData:model];
    cell.tag = self.tag;
    return cell;
}

//每个Cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kMainScreenW, self.cellH);
}


-(void)reloadData:(NSArray *)array{
    
    if (array == self.arr) return;
    
    UIBannerEntity* entity0 = [array objectAtIndexCheck:0];
    if (!entity0) return;
    
    self.arr = array;
    self.cellH = entity0.height;
    self.height = entity0.height;
    self.collectionView.height = entity0.height;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(kMainScreenW, self.cellH);
    
//    _pageControl.centerY_jr = self.cellH - 15;
    
    //新创建一个_turnArray是为了上边的if能起作用
    [_dataArr removeAllObjects];
    if (array.count >= 2) {
        
        [_dataArr addObject:[array lastObject]];
        [_dataArr addObjectsFromArray:array];
        [_dataArr addObject:[array firstObject]];
        
    }else{
        
        [_dataArr addObjectsFromArray:array];
    }
    
    [self removeTimer];
    [_collectionView reloadData];
    
    if (_dataArr.count < 2) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.autoScroll = NO;
//            self.pageControl.hidden = YES;
//            [self.pageControl setItemCount:0];
            _collectionView.contentOffset = CGPointMake(0, 0);
            self.pageControlN.hidden = YES;
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self setupTimer];
            
            self.autoScroll = YES;
//            self.pageControl.hidden = NO;
            self.pageControlN.hidden = NO;
//            [self.pageControl setItemCount:array.count];
            _collectionView.contentOffset = CGPointMake(CGRectGetWidth(_collectionView.frame), 0);
            self.pageControlN.numberOfPages = array.count;
        });
    };
}

- (void)layoutSubviews {
    self.pageControlN.maxY = self.height - 4;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.dataArr.count < 2) return;
    
    if (scrollView.contentOffset.x <= 0) {
        
        scrollView.contentOffset = CGPointMake((self.dataArr.count - 2)*CGRectGetWidth(_collectionView.frame), scrollView.contentOffset.y);
        
    }else if (scrollView.contentOffset.x >= (self.dataArr.count - 1)*CGRectGetWidth(_collectionView.frame)) {
        
        scrollView.contentOffset = CGPointMake(CGRectGetWidth(_collectionView.frame), scrollView.contentOffset.y);
    }
//    [self resetCurrentPageWithContentOffSet:scrollView.contentOffset];
    
    NSInteger itemIndex = 0;
    itemIndex = [self currentIndex];
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    self.pageControlN.currentPage = indexOnPageControl;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
//    [self.pageControl isScrolling:YES];
    if (self.autoScroll) {
        [self removeTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
//    [self.pageControl isScrolling:NO];
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
        _flowLayout = flowLayout;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenW, self.cellH) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[MobileUIBannerCollectionCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

//- (DCScrollPageControll *)pageControl {
//    
//    if (!_pageControl) {
//        _pageControl = [[DCScrollPageControll alloc] init];
//        _pageControl.size_jr = CGSizeMake(100, 2);
//        _pageControl.centerX_jr = kMainScreenW * 0.5;
//        _pageControl.layer.cornerRadius = 1;
//        _pageControl.clipsToBounds = YES;
//    }
//    _pageControl.centerY_jr = self.cellH - 15;
//    return _pageControl;
//}

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
    
    if ((num > self.dataArr.count - 1) || (num < 0)) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        if (!indexPath) return;
        if ([_collectionView numberOfItemsInSection:0] <= 0) return;
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }else{
        
        NSInteger item = num + 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        if (!indexPath) return;
        if ([_collectionView numberOfItemsInSection:0] - 1 < item) return;
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}



//-(void)resetCurrentPageWithContentOffSet:(CGPoint)contentOffSet{
//    
//    CGFloat width = CGRectGetWidth(_collectionView.frame);
//    CGFloat rate = ceil((_collectionView.contentOffset.x - width) / (self.arr.count * width));
//    CGFloat indicatorX = CGRectGetWidth(self.pageControl.frame) * rate;
//    [self.pageControl setIndicatorX:indicatorX];
//}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    if (!newSuperview) {
        [self removeTimer];
    }
}

- (int)currentIndex
{
    if (_collectionView.width == 0 || _collectionView.height == 0) {
        return 0;
    }
    
    int index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (_collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    } else {
        index = (_collectionView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    
    return MAX(0, index);
}

- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % (self.pageControlN.numberOfPages);
}

- (JRPageControl *)pageControlN {
    if (!_pageControlN) {
        JRPageControl *pageControl = [[JRPageControl alloc] initWithFrame:CGRectMake(16, 0, kMainScreenW -2*16, 12)];
        pageControl.currentPageIndicatorTintColor = [UIColor jrColorWithHex:@"#C6C6C6"];
        pageControl.pageIndicatorTintColor = [UIColor jrColorWithHex:@"#d8d8d8" withAlpha:0.5];
        pageControl.type = JRPageControlType_Circle;
        pageControl.subType = JRPageControlSubType_Jump;
        pageControl.hidesForSinglePage = YES;
        pageControl.circle_W = 5;
        pageControl.circle_H = 5;
        pageControl.interval = 6;
        pageControl.currentPage = 0;
        _pageControlN = pageControl;
    }
    return _pageControlN;
}

@end
