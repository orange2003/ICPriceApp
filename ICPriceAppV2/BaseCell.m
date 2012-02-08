//
//  BaseCell.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

-(void)dealloc{
    TT_RELEASE_SAFELY(_icon);
    TT_RELEASE_SAFELY(_dateLabel);
    TT_RELEASE_SAFELY(_secondLable);
    [super dealloc];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    return 44;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.icon.frame = CGRectMake(5, 8, 16, 16);
    
    CGSize textSize = [self.textLabel.text sizeWithFont:[UIFont boldSystemFontOfSize: 15]];
    CGSize dateSize =[self.dateLabel.text sizeWithFont:[UIFont boldSystemFontOfSize: 13]];
    CGSize badgeSize = [self.badgeString sizeWithFont:[UIFont boldSystemFontOfSize: 11]];
    if (self.icon.hidden) {
        self.textLabel.frame = CGRectMake(10, 3, 173, 22);
        self.secondLable.frame = CGRectMake(10, 27, 275, 15);
        self.badge.frame = CGRectMake((textSize.width+12), 5, badgeSize.width+13, 18);
    }else{
        self.textLabel.frame = CGRectMake(23, 3, 173, 22);
        self.secondLable.frame = CGRectMake(23, 27, 275, 15);
        self.badge.frame = CGRectMake((textSize.width+22), 5, badgeSize.width+13, 18);
    }
    
    self.dateLabel.frame = CGRectMake((320-dateSize.width-5), 8, dateSize.width, 15);
}

-(void)setObject:(id)object{
    [super setObject:object];
    self.badgeColor = [UIColor grayColor];
}

-(UILabel *)secondLable{
    if (!_secondLable) {
        _secondLable = [[UILabel alloc] init];
        _secondLable.font = [UIFont systemFontOfSize:13];
        _secondLable.textColor = RGBCOLOR(106, 106, 106);    
        _secondLable.highlightedTextColor = [UIColor whiteColor];
        [self addSubview:_secondLable];
    }
    return _secondLable;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:13];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textAlignment = UITextAlignmentRight;
        _dateLabel.highlightedTextColor = [UIColor whiteColor];
        _dateLabel.textColor = RGBCOLOR(0, 118, 228);    
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        [self addSubview:_icon];
    }
    return _icon;
}

- (NSString*)formatRelativeTime:(NSString*)time {
	NSTimeInterval elapsed = abs([time intValue]*60);
	if (elapsed <= 1) {
		return @"刚刚";
		
	} else if (elapsed < TT_MINUTE) {
		int seconds = (int)(elapsed);
		return [NSString stringWithFormat:@"%d秒", seconds];
		
	} else if (elapsed < 2*TT_MINUTE) {
		return @"一分钟";
		
	} else if (elapsed < TT_HOUR) {
		int mins = (int)(elapsed/TT_MINUTE);
		return [NSString stringWithFormat:@"%d分钟", mins];
		
	} else if (elapsed < TT_HOUR*1.5) {
		return @"一个小时";
		
	} else if (elapsed < TT_DAY) {
		int hours = (int)((elapsed+TT_HOUR/2)/TT_HOUR);
		return [NSString stringWithFormat:@"%d小时", hours];
		
	}  else  {
		int day = (int)(elapsed/TT_DAY);
		return [NSString stringWithFormat:@"%d天", day];
		
	}
}


@end
