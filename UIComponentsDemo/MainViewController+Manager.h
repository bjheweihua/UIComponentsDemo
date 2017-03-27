//
//  MainViewController+Manager.h
//  UIComponentsDemo
//
//  Created by heweihua on 2017/2/23.
//  Copyright © 2017年 heweihua. All rights reserved.
//



#import "MainViewController.h"

@interface MainViewController (Manager)

-(void) requestData;
-(void) reloadData:(NSDictionary*)dict;

-(UITableViewCell*) jr_TableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void) jr_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end
