//
//  ViewController.h
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TimeScroller.h"

@interface ViewController :  TTTableViewController<TimeScrollerDelegate>{
    TimeScroller *_timeScroller;
}
@property (nonatomic, readonly) TimeScroller *timeScroller;

@end
