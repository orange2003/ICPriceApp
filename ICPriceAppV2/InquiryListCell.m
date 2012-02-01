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
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
}

@end
