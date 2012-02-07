//
//  OrderCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-2-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    //ID,型号,type,数量,货币符号,售价,批号,厂牌,pckpins,芯片状态,cusName,cuOrderNote,suOrderNote,commonNote,日期,作者,平台,客户平台,cuPtId,平台ID,客户ID,suId,销售ID,采购ID,状态ID
    self.textLabel.text =[((TTTableTextItem*)_item).userInfo objectAtIndex:1];
    self.icon.hidden = YES;
    
    self.textLabel.font = [UIFont systemFontOfSize:15];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@%@",
                           [((TTTableTextItem*)_item).userInfo objectAtIndex:4],
                           [((TTTableTextItem*)_item).userInfo objectAtIndex:5]];
    self.badge.radius = 9;
    self.badgeString = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)_item).userInfo objectAtIndex:3]];
    //第二行：cusName,批号,厂牌,pckpins,芯片状态, suOrderNote+commonNote,日期,作者,平台
    self.secondLable.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@%@ %@ %@ %@",
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:10],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:6],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:7],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:8],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:9],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:12],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:13],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:14],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:15],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:16]];

}

@end
