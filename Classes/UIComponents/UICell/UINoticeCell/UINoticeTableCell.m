//
//  UINoticeTableCell.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/27.
//  Copyright © 2017年 heweihua. All rights reserved.
//

#import "UINoticeTableCell.h"
#import "NSTimer+Blocks.h"
#import "UICellEntity.h"
#import "UINoticeView.h"

#define kIousTimerViewW (kMainScreenW - kOffsetX*2.f)
#define kIousTimerViewH (30)

@interface UINoticeTableCell (){
    
    NSInteger _currentModelIndex;
}
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UINoticeView *noticeView;
@property (nonatomic,assign) NSInteger currentModelIndex;
@property (nonatomic,weak  ) UICellEntity* entity;
@end



@implementation UINoticeTableCell


-(void)dealloc{
    
    [self removeTimer];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        // 隐藏系统的小箭头
        [self setAccessoryType:UITableViewCellAccessoryNone];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        self.frame = CGRectMake(0, 0, kMainScreenW, kUINoticeTableCellH);

        [self.contentView addSubview:self.noticeView];
        [self.contentView addSubview:self.imgView];
    }
    return self;
}


- (UINoticeView *)noticeView {
    
    if (!_noticeView) {
        _noticeView = [[UINoticeView alloc] initWithFrame:CGRectMake(0, 0, 0, kNoticeView_H)];
    }
    return _noticeView;
}


- (UIImageView *)imgView {
    
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 12.5, 0, 15.5)];
        _imgView.userInteractionEnabled = NO;
    }
    return _imgView;
}



-(void)reloadData:(UICellEntity *)entity {
    
    if (self.entity == entity)
        return;
    self.entity = entity;
    [self refreshView];
}


- (void)refreshView {
    
    if (self.entity.list.count == 0) {
        kTimerCanacl(_timer);
        return;
    }
    
    _currentModelIndex++;
    if (_currentModelIndex >= self.entity.list.count) {
        _currentModelIndex = 0;
    }
    UIElementEntity *currentModel = [self.entity.list objectAtIndexCheck:_currentModelIndex];
    
    
    // bgColor
    self.contentView.backgroundColor = [UIColor jrColorWithHex:currentModel.bgColor];
    
    CGSize imageSize = [currentModel.imgUrl catchImageSize];
    CGFloat noticeViewX = 16.f;
    if(imageSize.height>0){
        CGFloat width = imageSize.width*15.5/imageSize.height;
        _imgView.width = width;
        noticeViewX = CGRectGetMaxX(_imgView.frame) +12.f;
    }else{
        _imgView.width = 0.f;
    }
    
    //更改数组中元素
    _imgView.hidden = YES;
    _imgView.contentMode = UIViewContentModeCenter;
    _imgView.backgroundColor = [UIColor jrColorWithHex:@"#FAFAFA"];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:currentModel.imgUrl] placeholderImage:[UIImage imageNamed:@"brickChannelNoImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            self->_imgView.hidden = NO;
            self->_imgView.backgroundColor = [UIColor clearColor];
            self->_imgView.contentMode = UIViewContentModeScaleToFill;
        }else{
            self->_imgView.hidden = YES;
        }
    }];
    
    
    CGRect frame = _noticeView.frame;
    frame.origin.x = noticeViewX;
    frame.size.width = kMainScreenW - noticeViewX - 21.5;
    _noticeView.frame = frame;
    [_noticeView reloadData:currentModel];
    
    if (!_timer && self.entity.list.count > 1) {
        
        [self removeTimer];
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(refreshView) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}


-(void) removeTimer{
    
    if (_timer) {
        [_timer invalidate];
    }
    _timer = nil;
}


- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    if (!newSuperview) {
        [self removeTimer];
    }
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(CGRectMake(0, 0, kMainScreenW, 40), point)) {
        return _noticeView.clickBtn;
    }
    return [super hitTest:point withEvent:event];
}


@end







