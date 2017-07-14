//
//  JRIousInputTextField.h
//  JDMobile
//
//  Created by heweihua on 16/7/4.
//  Copyright © 2016年 jr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRIousInputTextField : UITextField
@property (nonatomic, strong) UIFont * floatingLabelFont ;  //!<做动画的label
@property (nonatomic, strong) UIColor * floatingLabelActiveTextColor;  //!滑动label text颜色
@property (nonatomic, strong) NSString * floatingLabelText;  //!<滑动label 文本 设置textfeild的placeholder 时 会将这个属性默认设置为placeholder文本。
@property (nonatomic, assign) BOOL disableCopyActions;  //!<是否禁用复制粘贴等action, 默认为NO
@property (nonatomic, assign) BOOL isFloatLabelActive;//!<label是否默认高亮
@end

