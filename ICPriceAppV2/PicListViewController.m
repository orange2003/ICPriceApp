//
//  PicListViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PicListViewController.h"
#import "MyTTPhotoViewController.h"
#import "MockPhotoSource.h"
#import "IIViewDeckController.h"
#import "TypeSearchViewController.h"
#import "TypeSearchDataSource.h"
#import "MyTTThumbsDataSource.h"
@implementation PicListViewController

-(TTPhotoViewController *) createPhotoViewController{
    
	return [[[TTPhotoViewController alloc] init] autorelease];
}

-(void)loadView{
    [super loadView];
    UIBarButtonItem *_menu = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    self.navigationItem.leftBarButtonItem = _menu;
    [_menu release];
    
    self.searchViewController = [[[TypeSearchViewController alloc] init] autorelease];
	self.searchViewController.dataSource = [[[TypeSearchDataSource alloc] init] autorelease];
	_searchController.searchBar.delegate = self;
    
    _searchController.searchBar.barStyle =UIBarStyleBlackTranslucent;
    _searchController.searchBar.placeholder = @"请输入型号";
    self.tableView.tableHeaderView = _searchController.searchBar;

    
    self.tableView.frame = CGRectMake(0, -23, 320, 370);
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    self.tableView.frame = CGRectMake(0, 0, 320, 480);
    [_searchController.searchBar performSelector:@selector(setText:) 
                                      withObject:[kAppDelegate.temporaryValues objectForKey:@"searchText"]
                                      afterDelay:0.0];
    return YES;
}




-(void) searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
	if (_searchController.active) {
        if ([kAppDelegate.temporaryValues objectForKey:@"searchText"]&&
            ![[kAppDelegate.temporaryValues objectForKey:@"searchText"] isEmptyOrWhitespace]) {
            _searchController.searchBar.text = [kAppDelegate.temporaryValues objectForKey:@"searchText"];
        }
	}
}


-(void)typeSelect:(NSString*)text{
    [kAppDelegate.temporaryValues setObject:text forKey:@"searchText"];
    [kAppDelegate.temporaryValues setObject:text
                                     forKey:@"selectType"];
    self.title = text;
    [_searchController setActive:NO animated:NO ];
    [self.photoSource getPic];
}


-(void) createModel{
	self.photoSource = [[[MockPhotoSource alloc]
                         initWithType:MockPhotoSourceNormal
                         title:[kAppDelegate.temporaryValues objectForKey:@"selectType"]
                         photos:nil
                         photos2:nil
                         ] autorelease];
	
	[self.photoSource getPic];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTTableViewDataSource>)createDataSource {
    return [[[MyTTThumbsDataSource alloc] initWithPhotoSource:_photoSource delegate:self] autorelease];
}


@end
