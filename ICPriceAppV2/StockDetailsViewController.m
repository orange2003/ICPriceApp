//
//  StockDetailsViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StockDetailsViewController.h"
#import "SVSegmentedControl.h"
#import "IIViewDeckController.h"
#import "ToolUntil.h"
@implementation StockDetailsViewController

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadView{
    [super loadView];
    
    SVSegmentedControl *segmentedControl = [[SVSegmentedControl alloc]
                                            initWithSectionTitles:[NSArray arrayWithObjects:
                                                                   @"存放明细",
                                                                   @"出入库明细", nil]];
    
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl release];
    
    self.viewControllers = [NSArray arrayWithObjects:
                            [ToolUntil createController:@"StorageDetailsViewController" contentController:self],
                            [ToolUntil createController:@"InOutDetailsViewController" contentController:self],
                            nil ];
    
    [segmentedControl addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
}


-(void)segmentChange:(id)sender{
    self.selectedIndex  = ((SVSegmentedControl*)sender).selectedIndex;
}

// Called when a left swipe occurred
- (void)swipeLeft:(UISwipeGestureRecognizer *)recognizer{
    if ([[self.viewControllers objectAtIndex:self.selectedIndex] 
         respondsToSelector:@selector(swipeLeft:)]) {
        [[self.viewControllers objectAtIndex:self.selectedIndex] swipeLeft:recognizer];
    }
}

@end
