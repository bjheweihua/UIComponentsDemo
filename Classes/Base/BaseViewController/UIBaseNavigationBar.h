//
//  UIBaseNavigationBar.h
//
//
//  Created by heweihua on 15-9-13.
//  Copyright (c) 2014年 heweihua. All rights reserved.
//  没使用

#import <UIKit/UIKit.h>

@protocol UIBaseNavigationBarDelegate <NSObject>

-(void)leftButtonDown;
@end

@interface UIBaseNavigationBar : UINavigationBar{
    
    CGFloat _naviBarOriginH;
}

@property (nonatomic, weak  ) id<UIBaseNavigationBarDelegate>  barDelegate;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, assign) CGFloat naviBtnOriginY;
//@property (nonatomic, strong) UIButton *rightButton;
//@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIView *bLineView;
@property (nonatomic, strong) UINavigationItem *navigationItem;


- (instancetype)initWithTitle:(NSString*)title;
- (instancetype)initWithTitle:(NSString*)title withColor:(UIColor*)color;
// 设置自定义背景颜色状态栏
- (instancetype)initWithTitle:(NSString*)title withNaviImageName:(NSString*)iName;


//默认的左边返回按钮
- (void)addLeftBarButtonItem;
//定制左侧按钮
- (void)addLeftButtonItemWithTitle:(NSString*)title;
- (void)addLeftButtonItemWithImageName:(NSString*)iNameU pressedImgName:(NSString*)iNameD;

//定制右侧按钮
- (void)addRightButtonItemWithImageName:(NSString *)iNameU pressedImgName:(NSString*)iNameD target:(id)target selector:(SEL)selector;
- (void)addRightButtonItemWithTitle:(NSString *)String target:(id)target selector:(SEL)selector;

- (void)removeNavigationItemLeft;
- (void)removeNavigationItemRight;

//定制titleView
- (void)addNavigationTitleView:(UIView *)titleView;

@end







