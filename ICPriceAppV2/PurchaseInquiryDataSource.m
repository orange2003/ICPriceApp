//
//  PurchaseInquiryDataSource.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PurchaseInquiryDataSource.h"
#import "SellQuoteCell.h"
#import "PurchaseInquiryModel.h"
@implementation PurchaseInquiryDataSource

- (id<TTModel>)model {
	if (!_model) {
		_model = [[PurchaseInquiryModel alloc] initWithResultsPerPage:@"15"];
	}
	return _model;
}

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [SellQuoteCell  class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}

-(NSString *)titleForEmpty{
    return @"无记录返回";
}

@end
