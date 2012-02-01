//
//  BlackCell.m
//  PocketTrain
//
//  Created by Fei Gao on 11-1-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BlackCell.h"
#import "BlackItem.h"

@implementation BlackCell

+(CGFloat) tableView:(UITableView *)tableView rowHeightForObject:(id)object{
	return 40;
}

- (void)setObject:(id)object {
	if (_item != object) {
		[_item release];
		_item = [object retain];
		self.accessoryType = UITableViewCellAccessoryNone;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		[self _commonInit];
	}
}

- (void)_commonInit
{
	TTView* view =[[[TTView alloc] init] autorelease];
	self.textLabel.backgroundColor = [UIColor clearColor];
	view.style = [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(246,246,246)
													 color2:RGBCOLOR(255, 255, 255) next:
				  nil];
	
	self.backgroundView = view;
	self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.backgroundView.frame = self.bounds;
}

- (void)dealloc {
    [super dealloc];
}


@end
