//
//  UIScrollView+headerRefresh.m
//  Pods
//
//  Created by caiwenqiang on 16/9/8.
//
//

#import "UIScrollView+headerRefresh.h"
#import "UIColor+Additions.h"
#import <objc/runtime.h>

static NSString *const kScrollViewContentOffsetIdentifier = @"contentOffset";

@implementation UIScrollView (headerRefresh)

@dynamic slimeView;
@dynamic block;

- (void)setSlimeView:(SRRefreshView *)slimeView{
  
    objc_setAssociatedObject(self, @selector(slimeView), slimeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
   
}

- (SRRefreshView *)slimeView{
   
    return objc_getAssociatedObject(self, _cmd);

}

- (void)setBlock:(JRResfreshBlock)block{
   
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY);

}

- (JRResfreshBlock)block{
   
    return objc_getAssociatedObject(self, _cmd);

}

- (void)setHeadRefreshWithActionCallBack:(JRResfreshBlock)block{
    
    self.block = block;
    
    self.slimeView = [[SRRefreshView alloc] initWithHeight:32.0f];
    self.slimeView.backgroundColor = [UIColor clearColor];
    self.slimeView.delegate = self;
    self.slimeView.upInset = 0;
    self.slimeView.slimeMissWhenGoingBack = YES;
    self.slimeView.slime.bodyColor = [UIColor jrColorWithHex:@"#cccccc"];//外边可以设置
    self.slimeView.slime.skinColor = [UIColor clearColor];
    self.slimeView.slime.lineWith = 1;
    self.slimeView.slime.shadowBlur = 4;
    self.slimeView.slime.shadowColor = [UIColor clearColor];
    [self addSubview:self.slimeView];
    
    [self addObserver:self forKeyPath:kScrollViewContentOffsetIdentifier options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}


#pragma mark---KVO Observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if([keyPath isEqualToString:kScrollViewContentOffsetIdentifier]){
        [self.slimeView scrollViewDidScroll];
    }
    
    if(!self.isDragging){
        [self.slimeView scrollViewDidEndDraging];
    }
    
}

- (void)startHeadRefresh{
  
    [self.slimeView setLoadingWithexpansion];
    
}

- (void)endHeadRefresh{
    
    if([self.slimeView respondsToSelector:@selector(endRefresh)]){
       [self.slimeView performSelector:@selector(endRefresh) withObject:nil];
    }
    
}

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView{
  
    if(self.block) self.block();

}

- (void)removeHeadRefresh{
    if(self){
        [self removeObserver:self forKeyPath:kScrollViewContentOffsetIdentifier];
    }
    [self.slimeView popView];
    [self.slimeView removeFromSuperview];
    self.slimeView = nil;
}

@end
