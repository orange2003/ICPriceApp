//
//  PicListConController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-2-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PicListConController.h"
#import "TypeSearchViewController.h"
#import "TypeSearchDataSource.h"
@implementation PicListConController

-(void)loadView{
    [super loadView];
    self.contentContainerView.frame = CGRectMake(0, 45, 320, 367);
    
    self.navigationBarStyle = UIBarStyleBlackTranslucent;
    
    self.searchViewController = [[[TypeSearchViewController alloc] init] autorelease];
	self.searchViewController.dataSource = [[[TypeSearchDataSource alloc] init] autorelease];
	_searchController.searchBar.delegate = self;
    
    _searchController.searchBar.tintColor = [UIColor grayColor];
    _searchController.searchBar.placeholder = @"请输入型号";
    self.tableView.tableHeaderView = _searchController.searchBar;
    _searchController.searchBar.showsBookmarkButton  = YES;
    
}

@end
