//
//  StockListCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StockListCell.h"

@implementation StockListCell

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    //ID,型号,数量,进价,售价,批号,芯片状态,厂牌,pckpins,备注,日期,图
    //NSLog(@"userInfo %@",((TTTableTextItem*)_item).userInfo);
    self.textLabel.text =[((TTTableTextItem*)_item).userInfo objectAtIndex:1];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.dateLabel.hidden = YES;
    self.dateLabel.text = @"";
    self.badge.radius = 9;
    self.badgeString = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)_item).userInfo objectAtIndex:2]];

    //进价、批号、厂牌、封装、芯片状态、备注
    self.secondLable.text = [[NSString stringWithFormat:@"%@ %@ %@ %@ %@",
                             [[((TTTableTextItem*)_item).userInfo objectAtIndex:3] intValue]>0?
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:3]:
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:3],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:5],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:7],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:6],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:9]] 
                             stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([[((TTTableTextItem*)_item).userInfo objectAtIndex:11] intValue]>0) {
        self.icon.image = TTIMAGE(@"bundle://picture_yes.png");
    }else{
        self.icon.image = TTIMAGE(@"");
    }

}

@end
