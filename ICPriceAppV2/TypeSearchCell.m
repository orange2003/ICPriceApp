//
//  TypeSearchCell.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TypeSearchCell.h"


@implementation TypeSearchCell

- (void)setObject:(id)object {
	[super setObject:object];
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	self.selectionStyle = UITableViewCellSelectionStyleBlue;
}


@end
