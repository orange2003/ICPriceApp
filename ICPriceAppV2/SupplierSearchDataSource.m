//
//  SupplierSearchDataSource.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SupplierSearchDataSource.h"
#import "SupplierSearchModel.h"

#import "TypeSearchCell.h"
#import "BlackCell.h"
#import "BlackItem.h"

@implementation SupplierSearchDataSource


- (id<TTModel>)model {
	if (!_model) {
		_model = [[SupplierSearchModel alloc] init];
	}
	return _model;
}


- (void)search:(NSString*)text {
	[((SupplierSearchModel*)_model) search:text];
}


- (void)tableViewDidLoadModel:(UITableView*)tableView {
	self.items = [NSMutableArray array];
	
	for (NSArray * cells in ((SupplierSearchModel*)_model).items) {
		TTTableTextItem* item = [TTTableTextItem itemWithText:[cells objectAtIndex:2]];
		item.userInfo = cells;
		[_items addObject:item];
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isKindOfClass:[TTTableTextItem class]]) {
		return [TypeSearchCell  class];
	}else if ([object isKindOfClass:[BlackItem class]]) {
		return [BlackCell class];
	}else {
		return [super tableView:tableView cellClassForObject:object];
	}
}

@end
