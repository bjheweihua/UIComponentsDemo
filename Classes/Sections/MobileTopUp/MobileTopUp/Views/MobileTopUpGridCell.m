//
//  MobileTopUpGridCell.m
//  JDMobile
//
//  Created by heweihua on 16/4/19.
//  Copyright © 2016年 jr. All rights reserved.
//

#import "MobileTopUpGridCell.h"
#import "BillEntity.h"


@interface MobileTopUpGridCell() <MobileGridViewDelegate>

@end

@implementation MobileTopUpGridCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        
        self.contentView.backgroundColor = [UIColor jrColorWithHex:@"#f5f5f5"];
        self.frame = CGRectMake(0, 0, kMainScreenW, kMobileTopUpGridCellH);
        
        CGRect rect = CGRectMake(kOffsetX, 10, kGridCellW, kGridCellH);
        _cell1 = [[MobileGridView alloc] initWithFrame:rect];
        [_cell1 setDelegate:self];
        [self.contentView addSubview:_cell1];
        _cell1.tag = 1;
        
        rect = _cell1.frame;
        rect.origin.x = CGRectGetMaxX(_cell1.frame) + kOffsetInnerW;
        _cell2 = [[MobileGridView alloc] initWithFrame:rect];
        [_cell2 setDelegate:self];
        [self.contentView addSubview:_cell2];
        _cell2.tag = 2;
        
        rect = _cell2.frame;
        rect.origin.x = CGRectGetMaxX(_cell2.frame) + kOffsetInnerW;
        _cell3 = [[MobileGridView alloc] initWithFrame:rect];
        [_cell3 setDelegate:self];
        [self.contentView addSubview:_cell3];
        _cell3.tag = 3;
        
        _cell1.hidden = YES;
        _cell2.hidden = YES;
        _cell3.hidden = YES;
        
        _cell1.hidden = NO;
        _cell2.hidden = NO;
        _cell3.hidden = NO;
    }
    return self;
}


-(void) reloadData:(BillEntity *)entity{

    _cell1.hidden = YES;
    _cell2.hidden = YES;
    _cell3.hidden = YES;
    for (NSInteger i = 0; i < [entity.billList count]; ++i) {
        
        BillEntity *cEntity = entity.billList[i];
        if (0 == i) {
            
            _cell1.hidden = NO;
            [_cell1 reloadData:cEntity];
        }
        else if (1 == i) {
            
            _cell2.hidden = NO;
            [_cell2 reloadData:cEntity];
        }
        else if (2 == i) {
            
            _cell3.hidden = NO;
            [_cell3 reloadData:cEntity];
        }
        else{
            break;
        }
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
}


#pragma mark - MobileTopUpGridDelegate

-(void) didTouchMobileGrid:(BillEntity*) entity {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTouchMobileGrid:)]) {
        [self.delegate didTouchMobileGrid:entity];
    }
}

@end





