//
//  InventoryCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-2-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InventoryCell.h"

@implementation InventoryCell

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    //ID,型号,图,公司ID,数量,售价,批号,芯片状态,厂牌,pckpins,助记名,日期,平台ID
    self.textLabel.text =[((TTTableTextItem*)_item).userInfo objectAtIndex:1];
    self.icon.hidden = YES;
    
    self.textLabel.font = [UIFont systemFontOfSize:15];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@",
                           [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:([[[((TTTableTextItem*)_item).userInfo 
                                                                                                   objectAtIndex:11] 
                                                                                                  substringWithRange:NSMakeRange(6, 10)] intValue]+60*60*8)]]];
    [dateFormatter release];;
    self.badge.radius = 9;
    self.badgeString = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)_item).userInfo objectAtIndex:4]];
    //第二行：批号,芯片状态,厂牌,pckpins,助记名
    self.secondLable.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:6],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:7],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:8],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:9],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:10]];
    
}

@end
