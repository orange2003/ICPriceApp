//
//  SupplierSearchViewController.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SupplierSearchViewController.h"
#import "SupplierSearchDataSource.h"
#import "SearchViewController.h"
#import "Inquiry.h"

@implementation SupplierSearchViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init {
	if (self = [super init]) {
		self.variableHeightRows = NO;
	}
	
	return self;
}


-(void) viewDidAppear:(BOOL)animated{
	[_searchController.searchBar becomeFirstResponder];
	[super viewDidAppear:animated];
}

-(void) createModel{
	SupplierSearchDataSource *data = [[SupplierSearchDataSource alloc] init];
	self.dataSource = data;
	[data release];
	self.searchViewController.dataSource = self.dataSource;
}


- (void)loadView {
	[super loadView];
	SearchViewController* searchController = [[[SearchViewController alloc] init] autorelease];
	self.searchViewController = searchController;
	self.navigationController.navigationBarHidden = YES;
	self.tableView.tableHeaderView = _searchController.searchBar;
	_searchController.searchBar.placeholder = @"输入供货商名称";
	//_searchController.searchBar.keyboardType = UIKeyboardTypeASCIICapable;
	_searchController.searchBar.delegate = self;
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//	IcpriceDemoAppDelegate *appDelegate = (IcpriceDemoAppDelegate*)[UIApplication sharedApplication].delegate;
//	appDelegate.inquiryCopy.ider = appDelegate.inquiryCopy.ider;
	[self dismissModalViewControllerAnimated:YES];
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).supplier = [(NSArray*)((TTTableTextItem*)object).userInfo objectAtIndex:0];
    
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).platform = [(NSArray*)((TTTableTextItem*)object).userInfo objectAtIndex:4];
    
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).supplierName = ((TTTableTextItem*)object).text;
    

	[self dismissModalViewControllerAnimated:YES];
}


@end
