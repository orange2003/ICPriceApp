//
//  QuoteListCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuoteListCell.h"

@implementation QuoteListCell

-(void)setObject:(id)object{
    [super setObject:object];
    //ID,型号,数量,批号,厂牌,cusPrice,cuNote,分钟,客户,采购员,芯片状态ID
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.icon.hidden = YES;
    self.dateLabel.text = [self formatRelativeTime:[((TTTableTextItem*)_item).userInfo objectAtIndex:7]];
    self.badge.radius = 9;
    self.badgeString = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)_item).userInfo objectAtIndex:2]];
    //靠左：批号,厂牌,cusPrice，备注(灰色小字体) 靠右：客户、采购员靠右
    self.secondLable.text = [[NSString stringWithFormat:@"%@ %@ %@ %@ %@",
                             [[((TTTableTextItem*)_item).userInfo objectAtIndex:3] intValue]>0?
                              [((TTTableTextItem*)_item).userInfo objectAtIndex:3]:
                              @"",
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:4],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:5],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:6],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:8],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:9]] 
                             stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //    if ([[((TTTableTextItem*)_item).userInfo objectAtIndex:1] intValue]>0) {
    //        self.icon.image = TTIMAGE(@"bundle://picture_yes.png");
    //    }else{
    //        self.icon.image = TTIMAGE(@"bundle://picture_no.png");
    //    }
    
}


@end
