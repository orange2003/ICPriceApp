//
//  TypeSearchDataSource.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TypeSearchDataSource.h"
#import "TypeSearchModel.h"
#import "BlackCell.h"
#import "BlackItem.h"
#import "TypeSearchCell.h"

@implementation TypeSearchDataSource
@synthesize type = _type;

-(void)dealloc{
    TT_RELEASE_SAFELY(_type);
    [super dealloc];
}

- (id<TTModel>)model {
	if (!_model) {
		_model = [[TypeSearchModel alloc] init];
	}
	return _model;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	self.items = [NSMutableArray array];
    [_items addObject:[TTTableTextItem itemWithText:self.type]];
	for (NSArray * cells in ((TypeSearchModel*)_model).items) {
		TTTableTextItem* item = [TTTableTextItem itemWithText:[cells objectAtIndex:1]];
		item.userInfo = cells;
		[_items addObject:item];
	}
}


- (void)search:(NSString*)text {
    self.type = text;
	[((TypeSearchModel*)_model) search:text];
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
