//
//  TopQuickSearchViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TopQuickSearchViewController.h"
#import "IIViewDeckController.h"
@implementation TopQuickSearchViewController

-(void)loadView{
    [super loadView];
    UIBarButtonItem *_menu = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    self.navigationItem.leftBarButtonItem = _menu;
}


@end
