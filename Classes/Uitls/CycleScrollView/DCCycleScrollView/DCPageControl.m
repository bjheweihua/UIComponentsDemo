//
//  DCPageControl.m
//  JDMobile
//
//  Created by shenghuihan on 2017/3/28.
//  Copyright © 2017年 jr. All rights reserved.
//

#import "DCPageControl.h"

@implementation DCPageControl
- (void)setCurrentPage:(NSInteger)page {
    
    [super setCurrentPage:page];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
        if (subviewIndex == page)
            
        {
            UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
            
            CGSize size;
            
            size.height = 5;
            
            size.width = 5;
            
            [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                         
                                         size.width,size.height)];
        }
    }
    
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    [super setNumberOfPages:numberOfPages];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
            
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        
        CGSize size;
        
        size.height = 5;
        
        size.width = 5;
        
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     
                                     size.width,size.height)];
    }
}

@end
