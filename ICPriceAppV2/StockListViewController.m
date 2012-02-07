//
//  StockListViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StockListViewController.h"
#import "IIViewDeckController.h"
#import "TypeSearchViewController.h"
#import "TypeSearchDataSource.h"
#import "QuoteInquiryListDelegate.h"
#import "StockListDataSource.h"
#import "NSStringAdditions.h"
#define BUTTON_LEFT_MARGIN 10.0
#define BUTTON_SPACING 10
@implementation StockListViewController

-(void)loadView{
    [super loadView];
     UIBarButtonItem *_menu = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    self.navigationItem.leftBarButtonItem = _menu;
    [_menu release];
   
    self.title = @"现货库存";
    self.dataSource = [[[StockListDataSource alloc] init] autorelease];
    
    self.searchViewController = [[[TypeSearchViewController alloc] init] autorelease];
	self.searchViewController.dataSource = [[[TypeSearchDataSource alloc] init] autorelease];
	_searchController.searchBar.delegate = self;
    
    _searchController.searchBar.tintColor = [UIColor grayColor];
    _searchController.searchBar.placeholder = @"请输入型号";
    self.tableView.tableHeaderView = _searchController.searchBar;

    
    [self.tableView setContentOffset:CGPointMake(0,44)];
    // Setup the title and image for each button within the side swipe view
    buttonData = [[NSArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"图片上传", @"title", @"reply.png", @"image", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"图片浏览", @"title", @"reply.png", @"image", nil],
                   nil] retain];
    buttons = [[NSMutableArray alloc] initWithCapacity:buttonData.count];
    
    self.sideSwipeView = [[[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.rowHeight)] autorelease];
    
    [self setupSideSwipeView];
}


-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [_searchController.searchBar performSelector:@selector(setText:) 
                                      withObject:[kAppDelegate.temporaryValues objectForKey:@"searchText"]
                                      afterDelay:0.0];
    return YES;
}


-(void) searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
	if (_searchController.active) {
        if ([kAppDelegate.temporaryValues objectForKey:@"searchText"]&&
            ![[kAppDelegate.temporaryValues objectForKey:@"searchText"] isEmptyOrWhitespace]) {
            _searchController.searchBar.text = [kAppDelegate.temporaryValues objectForKey:@"searchText"];
        }
		
	}
}


-(void)typeSelect:(NSString*)text{
    [kAppDelegate.temporaryValues setObject:text forKey:@"searchText"];
    [kAppDelegate.temporaryValues setObject:text forKey:@"stockType"];
    [_searchController setActive:NO animated:NO ];
    
    [self reload];
    
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    if (![[kAppDelegate.temporaryValues objectForKey:@"stockType"] isEqualToString:@"%"]) {
        [kAppDelegate.temporaryValues setObject:@"%"
                                         forKey:@"stockType"];
        [self reload];
    }
}




-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.viewDeckController leftControllerIsClosed]) {
        [kAppDelegate.temporaryValues setObject:[((TTTableTextItem*)object).userInfo objectAtIndex:0]
                                         forKey:@"stockID"];
        
        
        [self.navigationController pushViewController:[kAppDelegate loadFromVC:@"StockDetailsViewController"] 
                                                               animated:YES];
    }

    
}


-(id <UITableViewDelegate>) createDelegate{
	return [[[QuoteInquiryListDelegate alloc] initWithController:self] autorelease];
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
        button.frame = CGRectMake(leftEdge, sideSwipeView.center.y - 40/2.0, 65, 40);
        
        
        // Add the image as the button's background image
        // [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        //UIImage* grayImage = [self imageFilledWith:[UIColor colorWithWhite:0.9 alpha:1.0] using:buttonImage];
        //[button setImage:grayImage forState:UIControlStateNormal];
        [button setTitle:[buttonInfo objectForKey:@"title"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        // Add a touch up inside action
        [button addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        
        // Keep track of the buttons so we know the proper text to display in the touch up inside action
        [buttons addObject:button];
        
        // Add the button to the side swipe view
        [self.sideSwipeView addSubview:button];
        
        // Move the left edge in prepartion for the next button
        leftEdge = leftEdge + 65 + BUTTON_SPACING;
    }
}


#pragma mark Button touch up inside action
- (IBAction) touchUpInsideAction:(UIButton*)button
{
    NSUInteger index = [buttons indexOfObject:button];
    [kAppDelegate.temporaryValues setObject:
     [((TTTableTextItem*)[kAppDelegate.temporaryValues objectForKey:@"swipRow"]).userInfo objectAtIndex:1] 
                                     forKey:@"selectType"];
    switch (index) {
        case 0://图片上传
        {
            [kAppDelegate.temporaryValues setObject:@"2" forKey:@"picType"];
            [kAppDelegate.temporaryValues setObject:[((TTTableTextItem*)[kAppDelegate.temporaryValues objectForKey:@"swipRow"]).userInfo objectAtIndex:0] forKey:@"picRid"];
            [self.viewDeckController photoUp];
            break;
        }
        case 1://图片浏览
        {

            
            [self.navigationController pushViewController:[kAppDelegate loadFromVC:@"QuickPicListViewController"] 
                                                                   animated:YES];
            break;
        }
        default:
            break;
    }
    
    [self removeSideSwipeView:YES];
}
@end
