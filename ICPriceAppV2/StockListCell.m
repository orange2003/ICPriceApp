//
//  StockListCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StockListCell.h"

@implementation StockListCell

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    return 44;
}

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    self.textLabel.text =[((TTTableTextItem*)_item).userInfo objectAtIndex:1];
}

@end
