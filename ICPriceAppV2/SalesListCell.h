//
//  SalesListCell.h
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseCell.h"

@interface SalesListCell : BaseCell{
    UILabel *_thirdLabel;
}
@property (nonatomic, readonly)UILabel *thirdLabel;
@end
