//
//  UIScrollView+headerRefresh.h
//  Pods
//
//  Created by caiwenqiang on 16/9/8.
//
//

#import <UIKit/UIKit.h>
#import "SRRefreshView.h"

typedef void(^JRResfreshBlock)(void);

@interface UIScrollView (headerRefresh)<SRRefreshDelegate>

@property (nonatomic,strong) SRRefreshView * slimeView;

@property (nonatomic,copy) JRResfreshBlock block;

- (void)setHeadRefreshWithActionCallBack:(JRResfreshBlock)block;

- (void)startHeadRefresh;

- (void)endHeadRefresh;

- (void)removeHeadRefresh;
@end
