//
//  OrderViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderDataSource.h"
#import "QuickSearchDelegate.h"
@implementation OrderViewController

-(void)loadView{
    [super loadView];
    self.dataSource = [[[OrderDataSource alloc] init] autorelease];
}


-(id <UITableViewDelegate>) createDelegate{
	return [[[QuickSearchDelegate alloc] initWithController:self] autorelease];
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
