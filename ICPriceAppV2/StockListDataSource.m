//
//  StockListDataSource.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StockListDataSource.h"
#import "StockListCell.h"
#import "StockListModel.h"
@implementation StockListDataSource

- (id<TTModel>)model {
	if (!_model) {
		_model = [[StockListModel alloc] initWithResultsPerPage:@"15"];
	}
	return _model;
}

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [StockListCell  class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

-(NSString *)titleForEmpty{
    return @"";
}


@end
