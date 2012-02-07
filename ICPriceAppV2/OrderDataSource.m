//
//  OrderDataSource.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderDataSource.h"
#import "OrderModel.h"
#import "OrderCell.h"
@implementation OrderDataSource

- (id<TTModel>)model {
	if (!_model) {
		_model = [[OrderModel alloc] initWithResultsPerPage:@"15"];
	}
	return _model;
}

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [OrderCell  class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

-(NSString *)titleForEmpty{
    return @"";
}

@end
