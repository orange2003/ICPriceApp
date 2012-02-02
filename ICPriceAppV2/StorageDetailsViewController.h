//
//  StorageDetailsViewController.h
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  存放明细
#import "SideSwipeTableViewController.h"
#import "TSAlertView.h"
@interface StorageDetailsViewController : SideSwipeTableViewController<TSAlertViewDelegate>{
    NSString *_ider;
}

@end
