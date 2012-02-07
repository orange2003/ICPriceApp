//
//  BaseMenuController.h
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


@interface BaseTabBarController : TTTableViewController{
    UIView *contentContainerView;
}
@property (nonatomic, readonly) UIView *contentContainerView;
@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;

@end
