//
//  QuoteInquiryListDelegate.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuoteInquiryListDelegate.h"
#import "QuoteInquiryListController.h"
@implementation QuoteInquiryListDelegate

#pragma mark UIScrollViewDelegateMethods


// UITableViewDelegate
// When a row is selected, animate the removal of the side swipe view
- (NSIndexPath *)tableView:(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.controller removeSideSwipeView:YES];
    return indexPath;
}

#pragma mark Removing the side swipe view


// UIScrollViewDelegate
// When the table is scrolled, animate the removal of the side swipe view
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   // [kAppDelegate.temporaryValues setObject:@"1" forKey:@"beginDragging"];
    [self.controller  removeSideSwipeView:YES];
}


//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
//    [kAppDelegate.temporaryValues setObject:@"0" forKey:@"beginDragging"];
//}



// When the table is scrolled to the top, remove the side swipe view
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    [self.controller  removeSideSwipeView:NO];
    return YES;
}


@end
