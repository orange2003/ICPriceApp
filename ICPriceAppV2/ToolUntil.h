//
//  ToolUntil.h
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SideSwipeTableViewController;

@interface ToolUntil : NSObject
+(SideSwipeTableViewController*)createController:(NSString*)name 
                               contentController:(UIViewController*)contentController;
@end
