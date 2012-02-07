//
//  InventoryDataSource.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InventoryDataSource.h"
#import "InventoryModel.h"
#import "InventoryCell.h"
@implementation InventoryDataSource

- (id<TTModel>)model {
	if (!_model) {
		_model = [[InventoryModel alloc] initWithResultsPerPage:@"15"];
	}
	return _model;
}

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [InventoryCell  class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

-(NSString *)titleForEmpty{
    return @"";
}

@end
