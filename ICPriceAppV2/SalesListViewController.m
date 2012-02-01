//
//  OrderListViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SalesListViewController.h"
#import "IIViewDeckController.h"
#import "SalesListDataSource.h"
#import "TypeSearchViewController.h"
#import "TypeSearchDataSource.h"
#import "QuoteInquiryListDelegate.h"
#import "NSStringAdditions.h"

#define BUTTON_LEFT_MARGIN 10.0
#define BUTTON_SPACING 25.0
@implementation SalesListViewController

-(void)loadView{
    [super loadView];
    UIBarButtonItem *_menu = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    self.navigationItem.leftBarButtonItem = _menu;
    [_menu release];
    self.title = @"销售订单";
    
    self.dataSource = [[[SalesListDataSource alloc] init] autorelease];
    
    self.searchViewController = [[[TypeSearchViewController alloc] init] autorelease];
	self.searchViewController.dataSource = [[[TypeSearchDataSource alloc] init] autorelease];
	_searchController.searchBar.delegate = self;
    
    _searchController.searchBar.tintColor = [UIColor grayColor];
    _searchController.searchBar.placeholder = @"请输入型号";
    //self.tableView.tableHeaderView = _searchController.searchBar;
    // Setup the title and image for each button within the side swipe view
    buttonData = [[NSArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"Reply", @"title", @"reply.png", @"image", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"Retweet", @"title", @"retweet-outline-button-item.png", @"image", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"Favorite", @"title", @"star-hollow.png", @"image", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"Profile", @"title", @"person.png", @"image", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"Links", @"title", @"paperclip.png", @"image", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"Action", @"title", @"action.png", @"image", nil],
                   nil] retain];
    buttons = [[NSMutableArray alloc] initWithCapacity:buttonData.count];
    
    self.sideSwipeView = [[[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.rowHeight)] autorelease];
    
    [self setupSideSwipeView];
}


-(id <UITableViewDelegate>) createDelegate{
	return [[[QuoteInquiryListDelegate alloc] initWithController:self] autorelease];
}

-(void)typeSelect:(NSString*)text{
    [kAppDelegate.temporaryValues setObject:text
                                     forKey:@"salesType"];
    [_searchController setActive:NO animated:YES ];
    [self reload];
    [self performSelector:@selector(setText:) withObject:text afterDelay:0.0];
    
}

-(void)setText:(NSString*)text{
    _searchController.searchBar.text = text;
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    if (![[kAppDelegate.temporaryValues objectForKey:@"salesType"] isEqualToString:@""]
        && [searchBar.text isEmptyOrWhitespace]) {
        [kAppDelegate.temporaryValues setObject:@""
                                         forKey:@"salesType"];
        [self reload];
    }
}

-(BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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

@end
