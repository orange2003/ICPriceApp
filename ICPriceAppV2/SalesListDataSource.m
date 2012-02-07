//
//  OrderListDataSource.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SalesListDataSource.h"
#import "SalesListModel.h"
#import "SalesListCell.h"
@implementation SalesListDataSource

- (id<TTModel>)model {
	if (!_model) {
		_model = [[SalesListModel alloc] initWithResultsPerPage:@"15"];
	}
	return _model;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* items = [[NSMutableArray alloc] init];
	for (NSArray* feed in ((BaseRequestModel*)_model).items) {
		TTTableTextItem *item = [[TTTableTextItem alloc] init];
        item.text = [feed objectAtIndex:3];
		item.userInfo = feed;
		[items addObject:item];
		[item release];
	}
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [SalesListCell  class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

-(NSString *)titleForEmpty{
    return @"";
}

@end
