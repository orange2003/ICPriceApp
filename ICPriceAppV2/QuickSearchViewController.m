//
//  QuickSearchViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuickSearchViewController.h"
#import "ToolUntil.h"
#import "SVSegmentedControl.h"
#import "IIViewDeckController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "User.h"
#import "TypeSearchViewController.h"
#import "TypeSearchDataSource.h"
#import "NSStringAdditions.h"
@implementation QuickSearchViewController

-(void)dealloc{
    if (asiRequest) {
        [asiRequest cancel];
        [asiRequest clearDelegatesAndCancel];
        TT_RELEASE_SAFELY(asiRequest);
    }
    [super dealloc];
}

-(void)loadView{
    [super loadView];
    UITapGestureRecognizer* singleRecognizer; 
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                               action:@selector(handleSingleTapFrom)]; 
    singleRecognizer.numberOfTapsRequired = 2; // 双击 
    [self.view addGestureRecognizer:singleRecognizer];
    [singleRecognizer release];
    
    self.title = [kAppDelegate.temporaryValues objectForKey:@"selectType"];
    
    self.searchViewController = [[[TypeSearchViewController alloc] init] autorelease];
	self.searchViewController.dataSource = [[[TypeSearchDataSource alloc] init] autorelease];
	_searchController.searchBar.delegate = self;
    
    _searchController.searchBar.tintColor = [UIColor grayColor];
    _searchController.searchBar.placeholder = @"请输入型号";
    self.tableView.tableHeaderView = _searchController.searchBar;
    
    if (![[kAppDelegate.temporaryValues objectForKey:@"quickType"] isEqualToString:@"3"]) {
        UIBarButtonItem *_menu = [[UIBarButtonItem alloc] initWithTitle:@"报价" style:UIBarButtonItemStyleBordered target:self action:@selector(priceAction)];
        self.navigationItem.rightBarButtonItem = _menu;
    }
    
    _tabBars = [[UITabBar alloc] initWithFrame:CGRectMake(-1, 367, 321, 49)];
    [self.view addSubview:_tabBars];
    [_tabBars release];
    
    _tabBars.delegate = self;
    _tabBars.items = [NSArray arrayWithObjects:
                      [[[UITabBarItem alloc] initWithTitle:@"销售报价" 
                                                     image:TTIMAGE(@"bundle://Star.png") 
                                                       tag:1] autorelease],
                      [[[UITabBarItem alloc] initWithTitle:@"采购询价" 
                                                     image:TTIMAGE(@"bundle://Star.png") 
                                                       tag:1] autorelease],
                      [[[UITabBarItem alloc] initWithTitle:@"订单" 
                                                     image:TTIMAGE(@"bundle://Star.png") 
                                                       tag:1] autorelease],
                      [[[UITabBarItem alloc] initWithTitle:@"实时" 
                                                     image:TTIMAGE(@"bundle://Star.png") 
                                                       tag:1] autorelease],
                      [[[UITabBarItem alloc] initWithTitle:@"会员现货" 
                                                     image:TTIMAGE(@"bundle://Star.png") 
                                                       tag:1] autorelease],
                      nil];
   
    self.contentContainerView.frame = CGRectMake(0, 0, 320, 367);
    
    self.viewControllers = [NSArray arrayWithObjects:
                            [ToolUntil createController:@"SellQuoteViewController" contentController:self],
                            [ToolUntil createController:@"PurchaseInquiryViewController" contentController:self],
                            [ToolUntil createController:@"OrderViewController" contentController:self],
                            [ToolUntil createController:@"RealtimeViewController" contentController:self],
                            [ToolUntil createController:@"InventoryViewController" contentController:self],
                            nil ];
     _tabBars.selectedItem = [_tabBars.items objectAtIndex:0];
    
    [self quickCnts];
}

-(void)handleSingleTapFrom{

    [UIView beginAnimations:@"" context:nil];
    if (self.contentContainerView.frame.origin.y==44) {
        self.contentContainerView.frame = CGRectMake(0, 0, 320, 367);
    }else{
        self.contentContainerView.frame = CGRectMake(0, 44, 320, 367);
    }
    
	[UIView setAnimationDuration:0.5];
	[UIView commitAnimations];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
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
    [self quickCnts];
    
    for (TTTableViewController *controller in self.viewControllers) {
        [controller reload];
    }
    
    
}

-(void)quickCnts{
    asiRequest = [[ASIFormDataRequest requestWithURL:[NSURL URLWithString:kRESTBaseUrl]] retain];
    NSMutableDictionary *operationData = [NSMutableDictionary dictionary];
    
    [operationData setValue:@"up_iphone_quickCnts" forKey:@"ObjectName"];
    [operationData setValue:[NSArray arrayWithObjects:[kAppDelegate.temporaryValues objectForKey:@"selectType"],
                             kAppDelegate.user.companyId,
                             nil] 
                     forKey:@"Values"];
    
    [asiRequest setPostValue:@"PRC" forKey:@"OperationCode"];
    [asiRequest setPostValue:[operationData JSONString] forKey:@"OperationData"];
    
	[asiRequest setRequestMethod:@"POST"];
    [asiRequest setDelegate:self];
    asiRequest.didFinishSelector = @selector(finishPoview:);
    asiRequest.didFailSelector = @selector(finishFail:);
	[asiRequest startAsynchronous];
}

-(void)priceAction{
    if ([[kAppDelegate.temporaryValues objectForKey:@"quickType"] isEqualToString:@"0"]) {
        [self.navigationController pushViewController:[kAppDelegate loadFromVC:@"InquiryUpdataController"] 
                                                               animated:YES];
    }else if([[kAppDelegate.temporaryValues objectForKey:@"quickType"] isEqualToString:@"1"]){
        [self.navigationController pushViewController:[kAppDelegate loadFromVC:@"QuoteUpdataViewController"] 
                                                               animated:YES];
    }
}

-(void)finishFail:(ASIHTTPRequest *)request{
	NSLog(@"request Fail");

}

-(void)finishPoview:(ASIHTTPRequest *)requests{
    NSDictionary *data =[[JSONDecoder decoder] objectWithData:[requests responseData]];
   // NSLog(@"data %@",[[data objectForKey:@"OutputTable"] objectAtIndex:0]);
    for (int i=0;i<[_tabBars.items count];i++) {
        ((UITabBarItem*)[_tabBars.items objectAtIndex:i]).badgeValue = [NSString stringWithFormat:@"%@",
                                                                        [[[data objectForKey:@"OutputTable"] objectAtIndex:0] objectAtIndex:i]];
    }
    
    
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    self.selectedIndex =  [tabBar.items indexOfObject:item];
}



@end
