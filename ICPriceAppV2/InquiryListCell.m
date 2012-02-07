//
//  InquiryListCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InquiryListCell.h"

@implementation InquiryListCell


-(void)setObject:(id)object{
    [super setObject:object];
    //ID,cusInqId,型号,数量,批号,厂牌,备注,分钟,平台,作者 , 芯片状态ID
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.icon.hidden = YES;
    self.dateLabel.text = [self formatRelativeTime:[((TTTableTextItem*)_item).userInfo objectAtIndex:7]];
    self.badge.radius = 9;
    self.badgeString = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)_item).userInfo objectAtIndex:3]];
    //批号、厂牌、备注，平台，作者
    self.secondLable.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:4],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:5],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:6],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:8],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:9]];
    
    
}


@end
