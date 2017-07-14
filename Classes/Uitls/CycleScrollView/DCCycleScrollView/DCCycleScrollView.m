//
//  SDCycleScrollView.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//



#import "DCCycleScrollView.h"
#import "DCCollectionViewCell.h"
#import "DCTAPageControl.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "DCScrollPageControll.h"
#import "JRPageControl.h"
#import "DCPageControl.h"

#define kDCCycleScrollViewInitialPageControlDotSize CGSizeMake(10, 10)

NSString * const DCID = @"cycleCell";

@interface DCCycleScrollView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *mainView; // 显示图片的collectionView
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *imagePathsGroup;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, weak) UIControl *pageControl;

@property (nonatomic, strong) UIImageView *backgroundImageView; // 当imageURLs为空时的背景图
@property (nonatomic, assign) CGFloat maxLeftOffsetX;
@property (nonatomic, strong) DCScrollPageControll *scrollPageControl;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) BOOL toRight;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) CGFloat currentPointX;

@end

@implementation DCCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupMainView];
//        self.maxLeftOffsetX = 
    }
    return self;
}

- (void)initialization
{
    _pageControlAliment = DCCycleScrollViewPageContolAlimentCenter;
    _autoScrollTimeInterval = 5.0;
    _titleLabelTextColor = [UIColor whiteColor];
    _titleLabelTextFont= [UIFont systemFontOfSize:14];
    _titleLabelBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _titleLabelHeight = 30;
    _autoScroll = YES;
    _infiniteLoop = YES;
    _showPageControl = YES;
    _pageControlDotSize = kDCCycleScrollViewInitialPageControlDotSize;
    _pageControlBottomOffset = 0;
    _pageControlRightOffset = 0;
    _pageControlStyle = DCCycleScrollViewPageContolStyleClassic;
    _hidesForSinglePage = YES;
    _currentPageDotColor = [UIColor whiteColor];
    _pageDotColor = [UIColor lightGrayColor];
    _bannerImageViewContentMode = UIViewContentModeScaleToFill;
    
    self.backgroundColor = [UIColor jrColorWithHex:@"#fafafa"];
    
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageNamesGroup:(NSArray *)imageNamesGroup
{
    DCCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.localizationImageNamesGroup = [NSMutableArray arrayWithArray:imageNamesGroup];
    return cycleScrollView;
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame shouldInfiniteLoop:(BOOL)infiniteLoop imageNamesGroup:(NSArray *)imageNamesGroup
{
    DCCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.infiniteLoop = infiniteLoop;
    cycleScrollView.localizationImageNamesGroup = [NSMutableArray arrayWithArray:imageNamesGroup];
    return cycleScrollView;
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLsGroup
{
    DCCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.imageURLStringsGroup = [NSMutableArray arrayWithArray:imageURLsGroup];
    return cycleScrollView;
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame delegate:(id<DCCycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage
{
    DCCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.delegate = delegate;
    cycleScrollView.placeholderImage = placeholderImage;
    
    return cycleScrollView;
}

// 设置显示图片的collectionView
- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[DCCollectionViewCell class] forCellWithReuseIdentifier:DCID];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.scrollsToTop = NO;
    [self addSubview:mainView];
    _mainView = mainView;
}


#pragma mark - properties


- (void)setPageControlDotSize:(CGSize)pageControlDotSize
{
    _pageControlDotSize = pageControlDotSize;
    if ([self.pageControl isKindOfClass:[DCTAPageControl class]]) {
        DCTAPageControl *pageContol = (DCTAPageControl *)_pageControl;
        pageContol.dotSize = pageControlDotSize;
    }
    
    if ([self.pageControl isKindOfClass:[JRPageControl class]]) {
        JRPageControl *pageControl = (JRPageControl *)_pageControl;
        pageControl.circle_W = pageControlDotSize.width;
        pageControl.circle_H = pageControlDotSize.height;
    }
}

- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    
    _pageControl.hidden = !showPageControl;
}

- (void)setCurrentPageDotColor:(UIColor *)currentPageDotColor
{
    _currentPageDotColor = currentPageDotColor;
    //[self setupPageControl];
    if ([self.pageControl isKindOfClass:[DCTAPageControl class]]) {
        DCTAPageControl *pageControl = (DCTAPageControl *)_pageControl;
        pageControl.dotColor = currentPageDotColor;
    } else if([self.pageControl isKindOfClass:[UIPageControl class]]){
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPageIndicatorTintColor = currentPageDotColor;
    }else if ([self.pageControl isKindOfClass:[JRPageControl class]]) {
        JRPageControl *pageConrtol = (JRPageControl *)self.pageControl;
        pageConrtol.currentPageIndicatorTintColor = currentPageDotColor;
    }
    
}

- (void)setPageDotColor:(UIColor *)pageDotColor
{
    _pageDotColor = pageDotColor;
    //[self setupPageControl];
    if ([self.pageControl isKindOfClass:[UIPageControl class]]) {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.pageIndicatorTintColor = pageDotColor;
    }else if ([self.pageControl isKindOfClass:[JRPageControl class]]) {
        JRPageControl *pageConrtol = (JRPageControl *)self.pageControl;
        pageConrtol.pageIndicatorTintColor = pageDotColor;
    }
}

- (void)setCurrentPageDotImage:(UIImage *)currentPageDotImage
{
    _currentPageDotImage = currentPageDotImage;
    
    if (self.pageControlStyle != DCCycleScrollViewPageContolStyleAnimated) {
        self.pageControlStyle = DCCycleScrollViewPageContolStyleAnimated;
    }
    
    [self setCustomPageControlDotImage:currentPageDotImage isCurrentPageDot:YES];
}

- (void)setPageDotImage:(UIImage *)pageDotImage
{
    _pageDotImage = pageDotImage;
    
    if (self.pageControlStyle != DCCycleScrollViewPageContolStyleAnimated) {
        self.pageControlStyle = DCCycleScrollViewPageContolStyleAnimated;
    }
    
    [self setCustomPageControlDotImage:pageDotImage isCurrentPageDot:NO];
}

- (void)setCustomPageControlDotImage:(UIImage *)image isCurrentPageDot:(BOOL)isCurrentPageDot
{
    if (!image || !self.pageControl) return;
    
    if ([self.pageControl isKindOfClass:[DCTAPageControl class]]) {
        DCTAPageControl *pageControl = (DCTAPageControl *)_pageControl;
        if (isCurrentPageDot) {
            pageControl.currentDotImage = image;
        } else {
            pageControl.dotImage = image;
        }
    }
}

- (void)setInfiniteLoop:(BOOL)infiniteLoop
{
    _infiniteLoop = infiniteLoop;
    
    if (self.imagePathsGroup.count) {
        self.imagePathsGroup = self.imagePathsGroup;
    }
}

-(void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    
    [self invalidateTimer];
    
    if (_autoScroll) {
        [self setupTimer];
    }
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    
    _flowLayout.scrollDirection = scrollDirection;
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [self setAutoScroll:self.autoScroll];
}

- (void)setPageControlStyle:(DCCycleScrollViewPageContolStyle)pageControlStyle
{
    _pageControlStyle = pageControlStyle;
    
    [self setupPageControl];
}

- (void)setImagePathsGroup:(NSArray *)imagePathsGroup
{
    [self invalidateTimer];
    
    _imagePathsGroup = imagePathsGroup;
    
    _totalItemsCount = self.infiniteLoop ? self.imagePathsGroup.count * 100 : self.imagePathsGroup.count;
    
    if (imagePathsGroup.count != 1) {
        self.mainView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    } else {
        self.mainView.scrollEnabled = NO;
    }
    
     [self setupPageControl];
    if (self.useScrollControl) {
        self.pageControl.hidden = YES;
    }else {
        self.pageControl.hidden = NO;
    }
    
    [self.mainView reloadData];
}

- (void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup
{
    _imageURLStringsGroup = imageURLStringsGroup;
    
    NSMutableArray *temp = [NSMutableArray new];
    [_imageURLStringsGroup enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * stop) {
        NSString *urlString;
        if ([obj isKindOfClass:[NSString class]]) {
            urlString = obj;
        } else if ([obj isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *)obj;
            urlString = [url absoluteString];
        }
        if (urlString) {
            [temp addObjectCheck:urlString];
        }
    }];
    self.imagePathsGroup = [temp copy];
    [self.scrollPageControl setItemCount:temp.count];
    if (temp.count) {
        self.scale = 100.0 / (temp.count * kMainScreenW);
    }
    
    if (imageURLStringsGroup.count <= 1) {
        [self hiddenScrollPageControl];
    }else {
        [self showScrollPageControl];
    }
}

- (void)setLocalizationImageNamesGroup:(NSArray *)localizationImageNamesGroup
{
    _localizationImageNamesGroup = localizationImageNamesGroup;
    self.imagePathsGroup = [localizationImageNamesGroup copy];
}

- (void)setTitlesGroup:(NSArray *)titlesGroup
{
    _titlesGroup = titlesGroup;
    if (self.onlyDisplayText) {
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < _titlesGroup.count; i++) {
            [temp addObjectCheck:@""];
        }
        self.backgroundColor = [UIColor clearColor];
        self.imageURLStringsGroup = [temp copy];
    }
}

#pragma mark - actions

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)setupPageControl
{
    if (_pageControl) [_pageControl removeFromSuperview]; // 重新加载数据时调整
    
    if (self.imagePathsGroup.count == 0 || self.onlyDisplayText) return;
    
    if ((self.imagePathsGroup.count == 1) && self.hidesForSinglePage) return;
    
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:[self currentIndex]];
    
    switch (self.pageControlStyle) {
        case DCCycleScrollViewPageContolStyleAnimated:
        {
            DCTAPageControl *pageControl = [[DCTAPageControl alloc] init];
            pageControl.numberOfPages = self.imagePathsGroup.count;
            pageControl.dotColor = self.currentPageDotColor;
            pageControl.userInteractionEnabled = NO;
            pageControl.currentPage = indexOnPageControl;
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
            break;
            
        case DCCycleScrollViewPageContolStyleClassic:
        {
            DCPageControl *pageControl = [[DCPageControl alloc] init];
            pageControl.numberOfPages = self.imagePathsGroup.count;
            pageControl.currentPageIndicatorTintColor = self.currentPageDotColor;
            pageControl.pageIndicatorTintColor = self.pageDotColor;
            pageControl.userInteractionEnabled = NO;
            pageControl.currentPage = indexOnPageControl;
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
            break;
        case DCCycleScrollViewPageContolStyleJR:
        {
            JRPageControl *pageControl = [[JRPageControl alloc] initWithFrame:CGRectMake(16, 0, kMainScreenW -2*16, 12)];
            pageControl.currentPageIndicatorTintColor = [UIColor jrColorWithHex:@"#000000" withAlpha:0.4];
            pageControl.pageIndicatorTintColor = [UIColor jrColorWithHex:@"#000000" withAlpha:0.15];
            pageControl.type = JRPageControlType_Circle;
            pageControl.subType = JRPageControlSubType_Jump;
            pageControl.hidesForSinglePage = YES;
            pageControl.circle_W = 5;
            pageControl.circle_H = 5;
            pageControl.interval = 6;
            pageControl.numberOfPages = self.imagePathsGroup.count;
            pageControl.currentPage = 0;
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
            break;
        case DCCycleScrollViewPageContolStyleScroll:
        {
           [self addSubview:self.scrollPageControl];
            self.useScrollControl = YES;
        }
            break;
            
        default:
            break;
    }
    
    // 重设pagecontroldot图片
    if (self.currentPageDotImage) {
        self.currentPageDotImage = self.currentPageDotImage;
    }
    if (self.pageDotImage) {
        self.pageDotImage = self.pageDotImage;
    }
    
    if (self.pageDotColor) {
        self.pageDotColor = self.pageDotColor;
    }
    
    self.pageControlDotSize = self.pageControlDotSize;
    
    if (self.currentPageDotColor) {
        self.currentPageDotColor = self.currentPageDotColor;
    }
}


- (void)automaticScroll
{
    if (0 == _totalItemsCount) return;
    int currentIndex = [self currentIndex];
    int targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}

- (void)scrollToIndex:(int)targetIndex
{
    if (targetIndex >= _totalItemsCount) {
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
            
            [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        return;
    }
    
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

- (int)currentIndex
{
    if (_mainView.width == 0 || _mainView.height == 0) {
        return 0;
    }
    
    int index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (_mainView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    } else {
        index = (_mainView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    
    return MAX(0, index);
}

- (int)currentIndexForScrollIndicator {
    if (_mainView.width == 0 || _mainView.height == 0) {
        return 0;
    }
    
    int index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        if (self.toRight) {
            index = _mainView.contentOffset.x / _flowLayout.itemSize.width;
        }else {
            index = (_mainView.contentOffset.x - 2) / _flowLayout.itemSize.width +  1;
        }
        
    }
    
    return index;
}

- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % self.imagePathsGroup.count;
}

- (void)clearCache
{
    [[self class] clearImagesCache];
}

+ (void)clearImagesCache
{
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
}

#pragma mark - life circles

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.frame.size;
    
    _mainView.frame = self.bounds;
    if (_mainView.contentOffset.x == 0 &&  _totalItemsCount) {
        int targetIndex = 0;
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
        }else{
            targetIndex = 0;
        }
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    CGSize size = CGSizeZero;
    if ([self.pageControl isKindOfClass:[DCTAPageControl class]]) {
        DCTAPageControl *pageControl = (DCTAPageControl *)_pageControl;
        if (!(self.pageDotImage && self.currentPageDotImage && CGSizeEqualToSize(kDCCycleScrollViewInitialPageControlDotSize, self.pageControlDotSize))) {
            pageControl.dotSize = self.pageControlDotSize;
        }
        size = [pageControl sizeForNumberOfPages:self.imagePathsGroup.count];
    } else {
        size = CGSizeMake(self.imagePathsGroup.count * self.pageControlDotSize.width * 1.5, self.pageControlDotSize.height);
    }
    CGFloat x = (self.width - size.width) * 0.5;
    if (self.pageControlAliment == DCCycleScrollViewPageContolAlimentRight) {
        x = self.mainView.width - size.width - 10;
    }
    //CGFloat y = self.mainView.sd_height - size.height - 10;
    
    if ([self.pageControl isKindOfClass:[DCTAPageControl class]]) {
        DCTAPageControl *pageControl = (DCTAPageControl *)_pageControl;
        [pageControl sizeToFit];
    }
    
    if ([self.pageControl isKindOfClass:[JRPageControl class]]) {
        
    }
    /*
    CGRect pageControlFrame = CGRectMake(x, y, size.width, size.height);
    pageControlFrame.origin.y -= self.pageControlBottomOffset;
    pageControlFrame.origin.x -= self.pageControlRightOffset;
    self.pageControl.frame = pageControlFrame;
     */
    self.pageControl.hidden = !_showPageControl;
    
    if (self.backgroundImageView) {
        self.backgroundImageView.frame = self.bounds;
    }
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _mainView.delegate = nil;
    _mainView.dataSource = nil;
}

#pragma mark - public actions

- (void)adjustWhenControllerViewWillAppera
{
    long targetIndex = [self currentIndex];
    if (targetIndex < _totalItemsCount) {
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCID forIndexPath:indexPath];
    long itemIndex = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    
    NSString *imagePath = self.imagePathsGroup[itemIndex];
    
    if (!self.onlyDisplayText && [imagePath isKindOfClass:[NSString class]]) {
        if ([imagePath hasPrefix:@"http"]) {
            
            cell.imageView.contentMode = UIViewContentModeCenter;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (image) {
                    cell.imageView.contentMode = UIViewContentModeScaleToFill;
                }
            }];
        } else {
            
            UIImage *image = [UIImage imageNamed:imagePath];
            if (!image) {
                image = [UIImage imageWithContentsOfFile:imagePath];
            }
            if (!image) {
                image = self.placeholderImage;
            }
            cell.imageView.image = image;
        }
    } else if (!self.onlyDisplayText && [imagePath isKindOfClass:[UIImage class]]) {
        cell.imageView.image = (UIImage *)imagePath;
    }
    
    if (_titlesGroup.count && itemIndex < _titlesGroup.count) {
        cell.title = _titlesGroup[itemIndex];
    }
    
    if (!cell.hasConfigured) {
        cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
        cell.titleLabelHeight = self.titleLabelHeight;
        cell.titleLabelTextColor = self.titleLabelTextColor;
        cell.titleLabelTextFont = self.titleLabelTextFont;
        cell.hasConfigured = YES;
        //cell.imageView.contentMode = self.bannerImageViewContentMode;
        cell.clipsToBounds = YES;
        cell.onlyDisplayText = self.onlyDisplayText;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(dccycleScrollView:didSelectItemAtIndex:)]) {
        [self.delegate dccycleScrollView:self didSelectItemAtIndex:[self pageControlIndexWithCurrentCellIndex:indexPath.item]];
    }
    if (self.clickItemOperationBlock) {
        self.clickItemOperationBlock([self pageControlIndexWithCurrentCellIndex:indexPath.item]);
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.currentPointX < scrollView.contentOffset.x) {
        self.toRight = YES;
    }else {
        self.toRight = NO;
    }
    
//    NSString *string = self.toRight ? @"右" : @"左边";
    
//    NSLog(@"%@", string);
    
    self.currentPointX = scrollView.contentOffset.x;
    
    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题

    int itemIndex = 0;
    if (self.useScrollControl) {
        itemIndex = [self currentIndexForScrollIndicator];
    }else {
        itemIndex = [self currentIndex];
    }
    
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
    if (self.useScrollControl) {
        
        if (self.maxLeftOffsetX == 0) {
            self.maxLeftOffsetX = scrollView.contentOffset.x;
        }
        
        if (indexOnPageControl == 0 && self.currentPage == (self.imageURLStringsGroup.count - 1)) {
            self.maxLeftOffsetX = scrollView.contentOffset.x;
        }
        
        if (self.currentPage == 0 && indexOnPageControl == self.imageURLStringsGroup.count - 1) {
            self.maxLeftOffsetX = scrollView.contentOffset.x - kMainScreenW * (self.imageURLStringsGroup.count - 1);
        }
        CGFloat offX = scrollView.contentOffset.x - self.maxLeftOffsetX;
        self.currentPage = indexOnPageControl;
        
        [self.scrollPageControl setIndicatorX:(offX * self.scale)];
    }else {
        if ([self.pageControl isKindOfClass:[DCTAPageControl class]]) {
            DCTAPageControl *pageControl = (DCTAPageControl *)_pageControl;
            pageControl.currentPage = indexOnPageControl;
        } else if([self.pageControl isKindOfClass:[UIPageControl class]]){
            UIPageControl *pageControl = (UIPageControl *)_pageControl;
            
            pageControl.currentPage = indexOnPageControl;
        }else if ([self.pageControl isKindOfClass:[JRPageControl class]]) {
            JRPageControl *pageControl = (JRPageControl *)self.pageControl;
            pageControl.currentPage = indexOnPageControl;
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.scrollPageControl isScrolling:YES];
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.scrollPageControl isScrolling:NO];
    if (self.autoScroll) {
        [self setupTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.mainView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (!self.imagePathsGroup.count) return; // 解决清除timer时偶尔会出现的问题
    int itemIndex = [self currentIndex];
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
    if ([self.delegate respondsToSelector:@selector(dccycleScrollView:didScrollToIndex:)]) {
        [self.delegate dccycleScrollView:self didScrollToIndex:indexOnPageControl];
    } else if (self.itemDidScrollOperationBlock) {
        self.itemDidScrollOperationBlock(indexOnPageControl);
    }
}

- (DCScrollPageControll *)scrollPageControl {
    if (!_scrollPageControl) {
        _scrollPageControl = [[DCScrollPageControll alloc] init];
        _scrollPageControl.size = CGSizeMake(100, 2);
        _scrollPageControl.midX = self.width * 0.5;
        _scrollPageControl.minY = 165;
        _scrollPageControl.layer.cornerRadius = 1;
        _scrollPageControl.clipsToBounds = YES;
    }
    return _scrollPageControl;
}

- (void)resetPageControlBottom:(CGFloat)pointBottom {
    self.scrollPageControl.maxY = pointBottom;
    self.scrollPageControl.midX = self.width * 0.5;
    
    self.pageControl.midX = self.width * 0.5;
    self.pageControl.maxY = pointBottom;
    
}

- (void)hiddenScrollPageControl {
    self.scrollPageControl.hidden = YES;
}

- (void)showScrollPageControl {
    self.scrollPageControl.hidden = NO;
}

- (UIImage *)placeholderImage {
    
    if (!_placeholderImage) {
        
        UIImageView* placeImgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brickChannelNoImage"]];
        UIView* placeholderview = [[UIImageView alloc] initWithFrame:self.bounds];
        [placeholderview addSubview:placeImgv];
        placeImgv.midX = placeholderview.width * 0.5;
        placeImgv.midY = placeholderview.height * 0.5;
        placeholderview.backgroundColor = [UIColor jrColorWithHex:@"#fafafa"];
        _placeholderImage = [UIImage jrImageFromView:placeholderview];
    }
    return _placeholderImage;
}

@end





