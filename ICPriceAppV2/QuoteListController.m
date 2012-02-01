//
//  QuoteListController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuoteListController.h"
#import "QuoteInquiryListDelegate.h"
#import "QuoteListDataSource.h"
#import "IIViewDeckController.h"

#define BUTTON_LEFT_MARGIN 10.0
#define BUTTON_SPACING 25.0

@interface QuoteListController (PrivateStuff)
-(void) setupSideSwipeView;
@end

@implementation QuoteListController

-(void)loadView{
    [super loadView];
    
    self.sideSwipeView = [[[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.rowHeight)] autorelease];
    
    [self setupSideSwipeView];
    
    self.dataSource = [[[QuoteListDataSource alloc] init] autorelease];
}

// Called when a left swipe occurred
- (void)swipeLeft:(UISwipeGestureRecognizer *)recognizer
{
    [self swipe:recognizer direction:UISwipeGestureRecognizerDirectionLeft];
}

- (void) setupSideSwipeView
{
    // Add the background pattern
    self.sideSwipeView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"dotted-pattern.png"]];
    
    // Overlay a shadow image that adds a subtle darker drop shadow around the edges
    UIImage* shadow = [[UIImage imageNamed:@"inner-shadow.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    UIImageView* shadowImageView = [[[UIImageView alloc] initWithFrame:sideSwipeView.frame] autorelease];
    shadowImageView.alpha = 0.6;
    shadowImageView.image = shadow;
    shadowImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.sideSwipeView addSubview:shadowImageView];
    
    // Iterate through the button data and create a button for each entry
    CGFloat leftEdge = BUTTON_LEFT_MARGIN;
    for (NSDictionary* buttonInfo in buttonData)
    {
        // Create the button
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // Make sure the button ends up in the right place when the cell is resized
        button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        
        // Get the button image
        UIImage* buttonImage = [UIImage imageNamed:[buttonInfo objectForKey:@"image"]];
        
        // Set the button's frame
        button.frame = CGRectMake(leftEdge, sideSwipeView.center.y - buttonImage.size.height/2.0, buttonImage.size.width, buttonImage.size.height);
        
        // Add the image as the button's background image
        // [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        UIImage* grayImage = [self imageFilledWith:[UIColor colorWithWhite:0.9 alpha:1.0] using:buttonImage];
        [button setImage:grayImage forState:UIControlStateNormal];
        
        // Add a touch up inside action
        [button addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        
        // Keep track of the buttons so we know the proper text to display in the touch up inside action
        [buttons addObject:button];
        
        // Add the button to the side swipe view
        [self.sideSwipeView addSubview:button];
        
        // Move the left edge in prepartion for the next button
        leftEdge = leftEdge + buttonImage.size.width + BUTTON_SPACING;
    }
}


#pragma mark Button touch up inside action
- (IBAction) touchUpInsideAction:(UIButton*)button
{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:sideSwipeCell];
    
    NSUInteger index = [buttons indexOfObject:button];
    NSDictionary* buttonInfo = [buttonData objectAtIndex:index];
    [[[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat: @"%@ on cell %d", [buttonInfo objectForKey:@"title"], indexPath.row]
                                 message:nil
                                delegate:nil
                       cancelButtonTitle:nil
                       otherButtonTitles:@"OK", nil] autorelease] show];
    
    [self removeSideSwipeView:YES];
}

-(id <UITableViewDelegate>) createDelegate{
	return [[[QuoteInquiryListDelegate alloc] initWithController:self] autorelease];
}



@end
