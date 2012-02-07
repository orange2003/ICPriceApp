//
//  StorageDetailsCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-2-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StorageDetailsCell.h"

@implementation StorageDetailsCell


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    return 44;
}

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    self.badgeString = [NSString stringWithFormat:@"%@",
                        [((TTTableTextItem*)_item).userInfo objectAtIndex:2]];
    self.badgeColor = [UIColor colorWithRed:0.197 green:0.592 blue:0.219 alpha:1.000];
    self.badge.radius = 9;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    //self.textLabel.text =[((TTTableTextItem*)_item).userInfo objectAtIndex:1];
}

@end
