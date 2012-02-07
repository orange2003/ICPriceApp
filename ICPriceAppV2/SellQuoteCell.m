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
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    self.textLabel.text =[((TTTableTextItem*)_item).userInfo objectAtIndex:1];
    self.icon.hidden = YES;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    //ID,型号,数量,suPrice,批号,厂牌,suNote,客户助记,平台,日期,销售
    self.dateLabel.text = [self formatRelativeTime:[((TTTableTextItem*)_item).userInfo objectAtIndex:3]];
    self.badge.radius = 9;
    self.badgeString = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)_item).userInfo objectAtIndex:2]];
    //批号,厂牌,客户助记,平台,销售,suNote
    self.secondLable.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:4],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:5],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:7],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:8],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:10],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:6]];
}

@end
