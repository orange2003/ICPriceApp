//
//  PurchaseInquiryCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-2-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PurchaseInquiryCell.h"

@implementation PurchaseInquiryCell

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    //ID,型号,数量,cusPrice,批号,chipstate,芯片状态ID,供货商助记,suId,cuNote,平台,采购,日期,suPrice,suPtId,parentId
    self.textLabel.text =[((TTTableTextItem*)_item).userInfo objectAtIndex:1];
    
    self.icon.hidden = YES;

    self.textLabel.font = [UIFont systemFontOfSize:15];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@",
                           [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:([[[((TTTableTextItem*)_item).userInfo 
                                                                                                   objectAtIndex:12] 
                                                                                                  substringWithRange:NSMakeRange(6, 10)] intValue]+60*60*8)]]];
    self.badge.radius = 9;
    self.badgeString = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)_item).userInfo objectAtIndex:2]];
    //批号,chipstate,供货商助记cuNote,平台,采购
    self.secondLable.text = [NSString stringWithFormat:@"%@ %@ %@%@ %@ %@",
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:4],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:5],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:7],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:9],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:10],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:11]];
}


@end
