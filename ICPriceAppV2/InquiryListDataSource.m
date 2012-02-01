//
//  InquiryListDataSource.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InquiryListDataSource.h"
#import "InquiryListModel.h"
#import "InquiryListCell.h"
@implementation InquiryListDataSource

- (id<TTModel>)model {
	if (!_model) {
		_model = [[InquiryListModel alloc] initWithResultsPerPage:@"15"];
	}
	return _model;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* items = [[NSMutableArray alloc] init];
	for (NSArray * feed in ((BaseRequestModel*)_model).items) {
       // NSLog(@"feed %@",feed);
        TTTableTextItem *item = [TTTableTextItem itemWithText:[feed objectAtIndex:2]];
        item.userInfo = feed;
		[items addObject:item];
    }
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [InquiryListCell  class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

@end
