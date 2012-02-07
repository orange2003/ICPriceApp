//
//  TypeSearchViewController.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TypeSearchViewController.h"
#import <Three20UICommon/UIViewControllerAdditions.h>
#import "QuickSearchViewController.h"
#import "TypeSearchModel.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TypeSearchViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init {
  if (self = [super init]) {
    self.variableHeightRows = NO;
  }
  return self;
}

-(void)viewWillAppear:(BOOL)animated{
    //NSLog(@"sss");
    [super viewWillAppear:animated];
}

-(void) didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    
	NSString *text =  ((TTTableTextItem*)object).text;
	[self.superController typeSelect:text];
}



@end

