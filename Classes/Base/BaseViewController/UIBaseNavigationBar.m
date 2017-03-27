//
//  UIBaseNavigationBar.m
//
//
//  Created by heweihua on 15-9-13.
//  Copyright (c) 2014年 heweihua. All rights reserved.
//

#import "UIBaseNavigationBar.h"

#define k_tag_leftButton               201407211
#define k_tag_rightButton              201407212
#define k_tag_titleLabel               201407213
#define k_tag_titleSegmented           201407214
#define k_tag_SegmentedPointLabel      201407215
#define k_tag_middleButton             201411051
#define knavigationBarTitleFontSize 17
#define kLeftBtnW 65
#define kLeftBtnH 44
#define kLeftBtnTitleFont 14
#define kTitleLabelX (65)
#define kTitleLabelW (kMainScreenW - kTitleLabelX*2)

@implementation UIBaseNavigationBar


-(instancetype) initWithTitle:(NSString*)title{
    
    self = [super init];
    if (self) {
        
        // Initialization code
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            
            _naviBarOriginH = kNaviBarHeight + kStateBarHeight;
            _naviBtnOriginY = kStateBarHeight;
        }
        else{
            
            _naviBarOriginH = kNaviBarHeight;
            _naviBtnOriginY = 0;
        }
        CGRect frame = CGRectMake(0, 0, kMainScreenW, _naviBarOriginH);
        [self setFrame:frame];

        //设置NavigationBar背景颜色
        self.barStyle = UIBarStyleBlack;
        self.barTintColor = [UIColor colorWithRed:54/255.0 green:53/255.0 blue:58/255.0 alpha:0.5];
        self.tintColor = [UIColor clearColor];
        [self initNavigationIem];
        [self addBottomLine];
        [self addNavigationBarTitle:title];
    }
    return self;
}

- (void)initNavigationIem{
    
    if (_navigationItem) {
        _navigationItem = [[UINavigationItem alloc] initWithTitle:@""];
    }
}


-(instancetype) initWithTitle:(NSString*)title withColor:(UIColor*)color{
    
    self = [super init];
    if (self) {
        
        // Initialization code
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            
            _naviBarOriginH = kNaviBarHeight + kStateBarHeight;
            _naviBtnOriginY = kStateBarHeight;
        }
        else{
            
            _naviBarOriginH = kNaviBarHeight;
            _naviBtnOriginY = 0;
        }
        CGRect frame = CGRectMake(0, 0, kMainScreenW, _naviBarOriginH);
        [self setFrame:frame];
        
        //设置NavigationBar背景颜色
        self.barStyle = UIBarStyleBlack;
        self.barTintColor = [UIColor colorWithRed:54/255.0 green:53/255.0 blue:58/255.0 alpha:0.5];
        self.tintColor = color; //[UIColor whiteColor];
        [self initNavigationIem];
        [self addBottomLine];
        [self addNavigationBarTitle:title];
    }
    return self;
}


// 设置自定义背景颜色状态栏
- (instancetype)initWithTitle:(NSString*)title withNaviImageName:(NSString*)iName{
    
    self = [super init];
    if (self) {
        
        // Initialization code
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
            
            _naviBarOriginH = kNaviBarHeight + kStateBarHeight;
            _naviBtnOriginY = kStateBarHeight;
        }
        else{
            
            _naviBarOriginH = kNaviBarHeight;
            _naviBtnOriginY = 0;
        }
        CGRect frame = CGRectMake(0, 0, kMainScreenW, _naviBarOriginH);
        [self setFrame:frame];
        
        //设置NavigationBar背景颜色
        self.barStyle = UIBarStyleBlack;
        self.barTintColor = [UIColor colorWithRed:54/255.0 green:53/255.0 blue:58/255.0 alpha:0.5];
        self.tintColor = [UIColor clearColor];
        
        [self initNavigationIem];
        [self addBottomLine];
        [self addNavigationBarTitle:title withNaviImageName:iName];
    }
    return self;
}



- (void)addNavigationBarTitle:(NSString *)title withNaviImageName:(NSString*)iName{
    
    // 背景图
    UIImage* image = [UIImage imageNamed:iName];
    UIImageView* naviImgV = [[UIImageView alloc] initWithImage:image];
    [naviImgV setBackgroundColor:[UIColor clearColor]];
    [naviImgV setFrame:CGRectMake(0, 0, kMainScreenW, _naviBarOriginH)];
    
    if (nil == _titleLable){
        
        UIFont* font = [UIFont getJRDefaultChinaFont:knavigationBarTitleFontSize];
        CGRect rect = CGRectMake(kTitleLabelX, 0, kTitleLabelW, kNaviBarHeight);
        _titleLable = [[UILabel alloc] initWithFrame:rect];
        _titleLable.tag = k_tag_titleLabel;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font = font;
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.text = title;
        [naviImgV addSubview:_titleLable];
        self.navigationItem.titleView = naviImgV;
        return;
    }
    _titleLable.text = title;
    self.navigationItem.titleView = naviImgV;
}


- (void)addNavigationBarTitle:(NSString *)title{
    
    if (nil == _titleLable){
        
        UIFont* font = [UIFont getJRDefaultChinaFont:knavigationBarTitleFontSize];
        CGRect rect = CGRectMake(kTitleLabelX, 0, kTitleLabelW, kNaviBarHeight);
        _titleLable = [[UILabel alloc] initWithFrame:rect];
        _titleLable.tag = k_tag_titleLabel;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font = font;
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.text = title;
        self.navigationItem.titleView = _titleLable;
        return;
    }
    _titleLable.text = title;
    self.navigationItem.titleView = _titleLable;
}



-(void) addBottomLine{
    
    if (self.bLineView == nil){
        
        self.bLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _naviBarOriginH-0.5f, kMainScreenW, 0.5f)];
        self.bLineView.backgroundColor = [UIColor jrColorWithHex:kLineColor];
        [self addSubview:self.bLineView];
    }
}





//默认的左边返回按钮
- (void)addLeftBarButtonItem {
    
    UIButton *button = (UIButton *)[self viewWithTag:k_tag_leftButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    UIImage *imagePressed = [UIImage imageNamed:@"navibar_back_icon"];
    UIImage *image = [UIImage imageNamed:@"navibar_back_icon"];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = k_tag_leftButton;
    button.tintColor = [UIColor whiteColor];
    button.autoresizesSubviews = YES;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imagePressed forState:UIControlStateHighlighted];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [button addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}


- (void)clickLeftButton:(id)sender {
    
    if (self.barDelegate && [self.barDelegate respondsToSelector:@selector(leftButtonDown)]) {
        [self.barDelegate leftButtonDown];
    }
}



-(void)addLeftButtonItemWithTitle:(NSString*)title{
    
    UIButton *button = (UIButton *)[self viewWithTag:k_tag_leftButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, _naviBtnOriginY, kLeftBtnW, kLeftBtnH)];
    [button setTitleColor:[UIColor jrColorWithHex:@"#666666"]  forState:UIControlStateNormal];
    [button setTitleColor:[UIColor jrColorWithHex:@"#999999"]  forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont getJRDefaultChinaFont:kLeftBtnTitleFont];
    button.tag = k_tag_leftButton;
    [button setTitle:title forState:UIControlStateNormal];
    [button setExclusiveTouch:YES];
    CGSize size = [title sizeWithFont:button.titleLabel.font];
    if (size.width > kLeftBtnW)
    {
        [button setFrame:CGRectMake(0, _naviBtnOriginY, size.width, kLeftBtnH)];
    }
    [button addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}



- (void)addLeftButtonItemWithImageName:(NSString*)iNameU pressedImgName:(NSString*)iNameD{
    
    UIButton *button = (UIButton *)[self viewWithTag:k_tag_leftButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    UIImage *imagePressed = [UIImage imageNamed:iNameD];
    UIImage *image = [UIImage imageNamed:iNameU];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = k_tag_leftButton;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:imagePressed forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(0, _naviBtnOriginY, image.size.width, image.size.height)];
    [button addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
     [button setExclusiveTouch:YES];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//定制右侧按钮
- (void)addRightButtonItemWithImageName:(NSString *)iNameU pressedImgName:(NSString*)iNameD target:(id)target selector:(SEL)selector{
    
    UIButton *button = (UIButton *)[self viewWithTag:k_tag_rightButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = k_tag_rightButton;
    UIImage *image = [UIImage imageNamed:iNameU];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:iNameD] forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(kMainScreenW - image.size.width - 15.f, _naviBtnOriginY , image.size.width, image.size.height)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setExclusiveTouch:YES];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)addRightButtonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector{
    
    UIButton *button = (UIButton *)[self viewWithTag:k_tag_rightButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    
    UIFont * font = [UIFont getJRDefaultChinaFont:kLeftBtnTitleFont];
    CGSize size = [title sizeWithFont:font];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = k_tag_rightButton;
    [button setTitle:title  forState:UIControlStateNormal];
    [button setTitle:title  forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor jrColorWithHex:@"#666666"]  forState:UIControlStateNormal];
    [button setTitleColor:[UIColor jrColorWithHex:@"#999999"]  forState:UIControlStateHighlighted];
    CGFloat pointW = size.width + 20*2; // 20 距离右边间隔
    [button setFrame:CGRectMake(kMainScreenW - pointW, _naviBtnOriginY, pointW, kNaviBarHeight)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = font;
    button.backgroundColor = [UIColor clearColor];
     [button setExclusiveTouch:YES];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)removeNavigationItemLeft{
    
    UIButton *button = (UIButton *)[self viewWithTag:k_tag_leftButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    self.navigationItem.leftBarButtonItem = nil;
}


-(void)removeNavigationItemRight{
    
    UIButton *button = (UIButton *)[self viewWithTag:k_tag_rightButton];
    if (button){
        
        [button removeFromSuperview];
        button = nil;
    }
    self.navigationItem.rightBarButtonItem = nil;
}


//定制titleView
- (void)addNavigationTitleView:(UIView *)titleView{
    
    [titleView setFrame:CGRectMake((kMainScreenW-titleView.frame.size.width)/2, _naviBtnOriginY, titleView.frame.size.width, kNaviBarHeight)];
    self.navigationItem.titleView = titleView;
}


@end




