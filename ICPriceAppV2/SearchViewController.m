//
//  SearchViewController.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import <Three20UICommon/UIViewControllerAdditions.h>

@implementation SearchViewController

-(void) didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
	[((TTTableViewController*)self.superController) 
	 didSelectObject:object atIndexPath:indexPath];
}

@end
