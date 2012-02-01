//
//  TypePhotoSearchDataSource.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TypePhotoSearchDataSource.h"
#import "TypeSearchModel.h"
@implementation TypePhotoSearchDataSource

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	self.items = [NSMutableArray array];
	for (NSArray * cells in ((TypeSearchModel*)_model).items) {
		TTTableTextItem* item = [TTTableTextItem itemWithText:[cells objectAtIndex:1]];
		item.userInfo = cells;
		[_items addObject:item];
	}
}

@end
