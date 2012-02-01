//
//  QuoteListDataSource.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuoteListDataSource.h"
#import "QuoteListModel.h"
#import "QuoteListCell.h"
@implementation QuoteListDataSource

- (id<TTModel>)model {
	if (!_model) {
		_model = [[QuoteListModel alloc] initWithResultsPerPage:@"15"];
	}
	return _model;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* items = [[NSMutableArray alloc] init];
	for (NSArray * feed in ((BaseRequestModel*)_model).items) {
        TTTableTextItem *item = [TTTableTextItem itemWithText:[feed objectAtIndex:1]];
        item.userInfo = feed;
		[items addObject:item];
    }
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [QuoteListCell  class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

@end
