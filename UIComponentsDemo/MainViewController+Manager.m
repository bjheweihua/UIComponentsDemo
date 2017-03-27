//
//  MainViewController+Manager.m
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//


#import "MainViewController+Manager.h"
#import "UICellEntity.h"
#import "UITableHeaderCell.h"
#import "UITableFooterCell.h"
#import "UIGridTableCell.h"
#import "UIBannerTableCell.h"
#import "UINoticeTableCell.h"
#import "UIHorizontalTableCell.h"
#import "UIHorizontalImgTableCell.h"
#import "UIBigGridTableCell.h"




@implementation MainViewController (Manager)


#pragma mark - 请求主页数据+用户信息
-(void) requestData{
    
     NSString *path = [[NSBundle mainBundle]  pathForResource:@"iouschannels" ofType:@"json"];
     NSLog(@"path:%@",path);
     NSData *rdata = [[NSData alloc] initWithContentsOfFile:path];
     
     NSString *result = [[NSString alloc] initWithData:rdata encoding:NSUTF8StringEncoding];
     result = [result stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
     result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
     result = [result stringByReplacingOccurrencesOfString:@"\t" withString:@""];
     result = [result stringByReplacingOccurrencesOfString:@" " withString:@""];
     NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
     NSError *err;
     NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
     options:NSJSONReadingMutableContainers
     error:&err];
     [self reloadData:dict];
     return;
}





-(void) reloadData:(NSDictionary*)dict {
    
    [_tableDataArr removeAllObjects];
    NSMutableArray* sectionList = dict[@"sectionList"];
    StringIsNull(sectionList);
    
    NSString* myOrderNum = dict[@"myOrderNum"]; // 订单数量
    NSString* shoppingCartNum = dict[@"shoppingCartNum"]; // 购物车数量
    NullToBank(myOrderNum);
    NullToBank(shoppingCartNum);
    NSString* orderNumber = [NSString stringWithFormat:@"%@",myOrderNum];
    NSString* shoppingNumber = [NSString stringWithFormat:@"%@",shoppingCartNum];
    [_floatlayer reloadRedPointWithOrder:orderNumber];
    [_floatlayer reloadRedPointWithShopping:shoppingNumber];
    
    
    for (NSInteger i = 0; i < [sectionList count]; ++i) {
        
        NSDictionary* subdict = sectionList[i];
        UISectionEntity* section = [[UISectionEntity alloc] initWithDict:subdict];
        if ([section.list count] == 0) {
            continue;
        }
        [_tableDataArr addObject:section];
    }
    [_tableView reloadData];
    
    if([_tableDataArr count] >0){
        _floatlayer.hidden = NO; // 有数据才显示浮层
    }
}




-(UITableViewCell*) jr_TableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UISectionEntity* section = _tableDataArr[indexPath.section];
    UICellEntity* entity = section.list[indexPath.row];
    switch (entity.type) {
        case EElement100:{
            
            static NSString *cellId = @"UITableHeaderCell";
            UITableHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell){
                
                cell = [[UITableHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [cell reloadData:entity];
            return cell;
        }
            break;
        case EElement101:{
            static NSString *cellId = @"UITableFooterCell";
            UITableFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell){
                
                cell = [[UITableFooterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [cell reloadData:entity];
            return cell;
        }
            break;

        case EElement102:{
            static NSString *cellId = @"UIBannerTableCell";
            UIBannerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell){
                
                cell = [[UIBannerTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [cell reloadData:entity];
            return cell;
        }
            break;

        case EElement103:{ 
            
            static NSString *cellId = @"UIGridTableCell";
            UIGridTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell){
                
                cell = [[UIGridTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [cell reloadData:entity];
            return cell;
            
        }
            break;

        case EElement104:{
            
            static NSString *cellId = @"UIBigGridTableCell";
            UIBigGridTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell){
                
                cell = [[UIBigGridTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [cell reloadData:entity];
            return cell;
            
        }
            break;
        case EElement105:{

            static NSString *cellId = @"UIHorizontalTableCell";
            UIHorizontalTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell){
                
                cell = [[UIHorizontalTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [cell reloadData:entity];
            return cell;
            
        }
            break;
        case EElement106:{
            
            static NSString *cellId = @"UIHorizontalImgTableCell";
            UIHorizontalImgTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell){
                
                cell = [[UIHorizontalImgTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [cell reloadData:entity];
            return cell;
        }
            break;
        case EElement107:{
            
            static NSString *cellId = @"UINoticeTableCell";
            UINoticeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell){
                
                cell = [[UINoticeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [cell reloadData:entity];
            return cell;
        }
            break;
            
            
        default:
            break;
    }
    return [[UITableViewCell alloc] init];
}


#pragma mark - 点击cell
-(void) jr_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end












