//
//  LeftViewCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LeftViewCell.h"

@implementation LeftViewCell

-(void)setObject:(id)object{
    [super setObject:object];
    self.textLabel.highlightedTextColor = [UIColor blackColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
}

@end
