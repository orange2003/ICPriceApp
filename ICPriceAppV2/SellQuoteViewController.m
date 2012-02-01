//
//  SellQuoteViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SellQuoteViewController.h"
#import "SellQuoteDataSource.h"
#import "QuickSearchDelegate.h"
@implementation SellQuoteViewController

-(void)loadView{
    [super loadView];
    self.dataSource = [[[SellQuoteDataSource alloc] init] autorelease];
}


-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(id <UITableViewDelegate>) createDelegate{
	return [[[QuickSearchDelegate alloc] initWithController:self] autorelease];
}

@end
