//
//  ToolUntil.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ToolUntil.h"
#import "SideSwipeTableViewController.h"
@implementation ToolUntil

+(SideSwipeTableViewController*)createController:(NSString*)name 
                               contentController:(UIViewController*)contentController{
    SideSwipeTableViewController *_controller = (SideSwipeTableViewController*)[kAppDelegate loadFromVC:name];
    _controller.contentController = contentController;
    return _controller;
}

@end
