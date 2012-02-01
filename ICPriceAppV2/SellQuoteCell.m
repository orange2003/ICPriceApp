//
//  SellQuoteCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SellQuoteCell.h"

@implementation SellQuoteCell

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    self.textLabel.text =[((TTTableTextItem*)_item).userInfo objectAtIndex:1];
}

@end
