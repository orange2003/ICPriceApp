//
//  SalesListCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SalesListCell.h"
#import "NSStringAdditions.h"
@implementation SalesListCell

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    return 64;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.thirdLabel.frame = CGRectMake(23, 45, 275, 15);
}

-(void)setObject:(id)object{
    [super setObject:object];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    //ID,图,状态ID,型号,数量,货币符号,售价,批号,封装 ,客户,采购员,销售员,日期,平台,备注,进度,进度作者,进度日期,型号ID
    //NSLog(@"userInfo %@",((TTTableTextItem*)_item).userInfo);

    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    self.textLabel.font = [UIFont systemFontOfSize:15];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@%@",
                           [((TTTableTextItem*)_item).userInfo objectAtIndex:5],
                           [((TTTableTextItem*)_item).userInfo objectAtIndex:6]];
    
    
    self.badge.radius = 9;
    self.badgeString = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)_item).userInfo objectAtIndex:4]];
    
    NSString *_temp = @"";
    if ([((TTTableTextItem*)_item).userInfo objectAtIndex:17]&&
        ![[((TTTableTextItem*)_item).userInfo objectAtIndex:17] isEmptyOrWhitespace]) {
        _temp = [NSString stringWithFormat:@"%@",
                 [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:([[[((TTTableTextItem*)_item).userInfo 
                                                                                         objectAtIndex:17] 
                                                                                        substringWithRange:NSMakeRange(6, 10)] intValue]+60*60*8)]]];
    }
    //第二行：平台,批号, 封装，客户,采购员(右对齐) 第三行：备注,进度,进度作者,进度日期
    self.secondLable.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:13],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:7],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:8],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:9],
                             [((TTTableTextItem*)_item).userInfo objectAtIndex:10]];
    self.thirdLabel.text = [[NSString stringWithFormat:@"%@ %@ %@ %@",
                            [((TTTableTextItem*)_item).userInfo objectAtIndex:14],
                            [((TTTableTextItem*)_item).userInfo objectAtIndex:15],
                            [((TTTableTextItem*)_item).userInfo objectAtIndex:16],
                             _temp] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if ([[((TTTableTextItem*)_item).userInfo objectAtIndex:11] intValue]>0) {
        self.icon.image = TTIMAGE(@"bundle://picture_yes.png");
    }else{
        self.icon.image = TTIMAGE(@"");
    }
    
}

-(UILabel *)thirdLabel{
    if (!_thirdLabel) {
        _thirdLabel = [[UILabel alloc] init];
        _thirdLabel.font = [UIFont systemFontOfSize:13];
        _thirdLabel.textColor = RGBCOLOR(106, 106, 106);    
        _thirdLabel.highlightedTextColor = [UIColor whiteColor];
        [self addSubview:_thirdLabel];
    }
    return _thirdLabel;
}

@end
