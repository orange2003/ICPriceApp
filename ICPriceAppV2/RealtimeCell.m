//
//  RealtimeCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-2-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RealtimeCell.h"

@implementation RealtimeCell

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    //ID,型号,数量,厂牌,批号,封装,说明,供货商ID,日期,供货商,助记名,简址,星级,库存真实性,标志,来自ID,平台ID
    self.textLabel.text =[((TTTableTextItem*)_item).userInfo objectAtIndex:1];
    self.icon.hidden = YES;
    
    self.textLabel.font = [UIFont systemFontOfSize:15];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@",
                           [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:([[[((TTTableTextItem*)_item).userInfo 
                                                                                                   objectAtIndex:8] 
                                                                                                  substringWithRange:NSMakeRange(6, 10)] intValue]+60*60*8)]]];
    [dateFormatter release];
    self.badge.radius = 9;
    self.badgeString = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)_item).userInfo objectAtIndex:2]];
    //第二行：助记名,星级,库存真实性 厂牌,批号,封装,说明
    self.secondLable.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@",
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:10],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:12],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:13],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:3],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:4],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:5],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:6]];
    
}

@end
