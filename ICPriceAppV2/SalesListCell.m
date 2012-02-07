//
//  SalesListCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SalesListCell.h"

@implementation SalesListCell

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    //ID,图,状态ID,型号,数量,货币符号,售价,批号,封装 ,客户,采购员,销售员,日期,平台,备注,进度,进度作者,进度日期,型号ID
    //NSLog(@"userInfo %@",((TTTableTextItem*)_item).userInfo);

    self.textLabel.font = [UIFont systemFontOfSize:15];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@%@",
                           [((TTTableTextItem*)_item).userInfo objectAtIndex:5],
                           [((TTTableTextItem*)_item).userInfo objectAtIndex:6]];
    self.badge.radius = 9;
    self.badgeString = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)_item).userInfo objectAtIndex:4]];
    //第二行：平台,批号, 封装，客户,采购员(右对齐) 第三行：备注,进度,进度作者,进度日期
    self.secondLable.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:13],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:7],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:7],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:6],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:9]];
    
    if ([[((TTTableTextItem*)_item).userInfo objectAtIndex:11] intValue]>0) {
        self.icon.image = TTIMAGE(@"bundle://picture_yes.png");
    }else{
        self.icon.image = TTIMAGE(@"");
    }
    
}

@end
