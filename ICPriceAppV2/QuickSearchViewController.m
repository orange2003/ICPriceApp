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
    self.title = [kAppDelegate.temporaryValues objectForKey:@"selectType"];
    
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
