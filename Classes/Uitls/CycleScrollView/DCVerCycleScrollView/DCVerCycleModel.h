//
//  DCVerCycleModel.h
//  JDMobile
//
//  Created by shenghuihan on 2017/1/5.
//  Copyright © 2017年 jr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCVerCycleModel : NSObject
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) UIImage *image;

//上报相关
@property (nonatomic, copy) NSString *articleBussinessType;
@property (nonatomic, copy) NSString *articleType;
@property (nonatomic, copy) NSString *rule;
@end
