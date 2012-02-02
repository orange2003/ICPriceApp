//
//  SalesListCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SalesListCell.h"

@implementation SalesListCell

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    return 44;
}

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    //ID,图,状态ID,型号,数量,货币符号,售价,批号,封装 ,客户,采购员,销售员,日期,平台,备注,进度,进度作者,进度日期,型号ID
    //self.textLabel.text =[((TTTableTextItem*)_item).userInfo objectAtIndex:3];
}

@end
