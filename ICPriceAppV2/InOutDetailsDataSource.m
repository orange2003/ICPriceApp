//
//  InOutDetailsDataSource.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InOutDetailsDataSource.h"
#import "InOutDetailsModel.h"
#import "InOutDetailsCell.h"
@implementation InOutDetailsDataSource

- (id<TTModel>)model {
	if (!_model) {
		_model = [[InOutDetailsModel alloc] initWithResultsPerPage:@"15"];
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
		return [InOutDetailsCell  class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}


-(NSString *)titleForEmpty{
    return @"暂无明细";
}

@end
