//
//  TypePhotoSearchViewController.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TypePhotoSearchViewController.h"
#import "TypeSearchViewController.h"
#import "TypePhotoSearchDataSource.h"

@implementation TypePhotoSearchViewController
@synthesize controller;

-(id)initWithParams:(NSDictionary*)query{
	if ((self = [super init])) {
		self.controller = [query objectForKey:@"controller"];
	}
	return self;
}


-(void) createModel{
	TypeSearchDataSource *data = [[TypePhotoSearchDataSource alloc] init] ;
	self.dataSource = data;
	[data release];
	self.searchViewController.dataSource = self.dataSource;
}

- (void)loadView {
	[super loadView];
    self.navigationController.navigationBarHidden = YES;
    self.searchViewController = [[[TypeSearchViewController alloc] init] autorelease];
	self.searchViewController.dataSource = [[[TypePhotoSearchDataSource alloc] init] autorelease];
	_searchController.searchBar.delegate = self;
	self.tableView.tableHeaderView = _searchController.searchBar;
	_searchController.searchBar.placeholder = @"请输入型号查询";
	_searchController.searchBar.keyboardType = UIKeyboardTypeASCIICapable;
	_searchController.searchBar.delegate = self;
}

-(void)typeSelect:(NSString*)text{
    [self.controller typeSelect:text];
    [self dismissModalViewControllerAnimated:YES];
}

-(void) viewDidAppear:(BOOL)animated{
	[_searchController.searchBar becomeFirstResponder];
	[super viewDidAppear:animated];
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	[self dismissModalViewControllerAnimated:YES];
}

@end
