//
//  QuoteInquiryListController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuoteInquiryListController.h"
#import "SVSegmentedControl.h"
#import "IIViewDeckController.h"
#import "QuoteListController.h"
#import "InquiryListController.h"
#import "ToolUntil.h"
@implementation QuoteInquiryListController

-(void)dealloc{
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

    }
    return  self;
}




-(void)loadView{
    [super loadView];
    UIBarButtonItem *_menu = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    self.navigationItem.leftBarButtonItem = _menu;
    
    SVSegmentedControl *segmentedControl = [[SVSegmentedControl alloc]
                                            initWithSectionTitles:[NSArray arrayWithObjects:@"采购询价",@"业务报价", nil]];
    
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl release];
    
    self.viewControllers = [NSArray arrayWithObjects:
                            [ToolUntil createController:@"InquiryListController" contentController:self],
                            [ToolUntil createController:@"QuoteListController" contentController:self],
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
