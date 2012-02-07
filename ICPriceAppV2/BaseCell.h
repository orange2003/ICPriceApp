//
//  BaseCell.h
//  ICPriceAppV2
//
//  Created by 高飞 on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TDBadgedCell.h"

@interface BaseCell : TDBadgedCell{
    UIImageView *_icon;
    UILabel *_dateLabel;
    UILabel *_secondLable;
}
@property (nonatomic, readonly)UIImageView *icon;
@property (nonatomic, readonly)UILabel *dateLabel;
@property (nonatomic, readonly)UILabel *secondLable;
- (NSString*)formatRelativeTime:(NSString*)time;
@end
