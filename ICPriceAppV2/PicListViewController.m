//
//  PicListViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PicListViewController.h"
#import "MyTTPhotoViewController.h"
#import "MockPhotoSource.h"
#import "IIViewDeckController.h"
@implementation PicListViewController

-(TTPhotoViewController *) createPhotoViewController{
    
	return [[[TTPhotoViewController alloc] init] autorelease];
}

-(void)loadView{
    [super loadView];
    UIBarButtonItem *_menu = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    self.navigationItem.leftBarButtonItem = _menu;
    [_menu release];
}


-(void) createModel{
	self.photoSource = [[[MockPhotoSource alloc]
                         initWithType:MockPhotoSourceNormal
                         title:[kAppDelegate.temporaryValues objectForKey:@"selectType"]
                         photos:nil
                         photos2:nil
                         ] autorelease];
	
	[self.photoSource getPic];
}


@end
