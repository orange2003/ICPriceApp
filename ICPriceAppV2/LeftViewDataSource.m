//
//  LeftViewDataSource.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LeftViewDataSource.h"
#import "CustomCellBackgroundView.h"
#import "LeftViewCell.h"
@implementation LeftViewDataSource

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
	CustomCellBackgroundView *custview = [[CustomCellBackgroundView alloc] init];
	custview.fillColor =[UIColor colorWithPatternImage:TTIMAGE(@"bundle://backTile.png")];
	custview.borderColor = [UIColor clearColor];
    custview.position = CustomCellBackgroundViewPositionMiddle;
	cell.selectedBackgroundView =custview;
	[custview release];
	return cell;
}

-(Class) tableView:(UITableView *)tableView cellClassForObject:(id)object{
	if ([object isMemberOfClass:[TTTableTextItem class]]) {
		return [LeftViewCell class];
	}else{
		return [super tableView:tableView cellClassForObject:object];
	}
}
@end
