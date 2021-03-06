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
#import "Inquiry.h"
#define BUTTON_LEFT_MARGIN 10.0
#define BUTTON_SPACING 10.0

@interface QuoteListController (PrivateStuff)
-(void) setupSideSwipeView;
@end

@implementation QuoteListController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(QuoteListRefresh) 
                                                     name:@"QuoteListRefresh" object:nil];
    }
    return self;
}

-(void)QuoteListRefresh{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"DragRefreshTableReload" object:nil];
    [self.model load:TTURLRequestCachePolicyNetwork more:NO];
}

-(void)loadView{
    [super loadView];
    self.variableHeightRows = NO;
    self.tableView.rowHeight = 44;
    buttonData = [[NSArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"快查查询", @"title", @"reply.png", @"image", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"图片浏览", @"title", @"reply.png", @"image", nil],
                   nil] retain];
    buttons = [[NSMutableArray alloc] initWithCapacity:buttonData.count];
    
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

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.contentController.viewDeckController leftControllerIsClosed]) {
        
        [kAppDelegate.temporaryValues setObject:@"1"
                                         forKey:@"quickType"];
        
        
        [kAppDelegate.temporaryValues setObject:((TTTableTextItem*)object).text
                                         forKey:@"selectType"];
        
        
        NSArray * cells  = ((TTTableTextItem*)object).userInfo;
       // NSLog(@"cells %@",cells);
        //ID,型号,数量,批号,厂牌, 目标价,备注,分钟,客户,采购员,芯片状态id
        Inquiry * inquiry = [[Inquiry alloc] init];
        inquiry.ider = [cells objectAtIndex:0];
        //inquiry.cusInqID = [cells objectAtIndex:1];
        inquiry.type= [(NSString*)[cells objectAtIndex:1] uppercaseString];
        inquiry.quantity= [cells objectAtIndex:2];
        inquiry.price = [cells objectAtIndex:5];
        inquiry.batch = [cells objectAtIndex:3];
        inquiry.status = [cells objectAtIndex:10];
        inquiry.brand = [cells objectAtIndex:4];
        [kAppDelegate.temporaryValues setObject:inquiry forKey:@"inquiry"];
        [inquiry release];
        
        [self.contentController.navigationController 
         pushViewController:[kAppDelegate loadFromVC:@"QuoteUpdataViewController"] 
                                                               animated:YES];
    }
}


#pragma mark Button touch up inside action
- (IBAction) touchUpInsideAction:(UIButton*)button
{
    NSUInteger index = [buttons indexOfObject:button];
    
    switch (index) {
        case 0://快查查询
        {
            [kAppDelegate.temporaryValues setObject:@"1"
                                             forKey:@"quickType"];
            
            [kAppDelegate.temporaryValues setObject:
             ((TTTableTextItem*)[kAppDelegate.temporaryValues objectForKey:@"swipRow"]).text 
                                             forKey:@"selectType"];
            
            [kAppDelegate.temporaryValues setObject:
             ((TTTableTextItem*)[kAppDelegate.temporaryValues objectForKey:@"swipRow"]).text 
                                             forKey:@"searchText"];
            
            
            NSArray * cells  =((TTTableTextItem*)[kAppDelegate.temporaryValues objectForKey:@"swipRow"]).userInfo;
            // NSLog(@"cells %@",cells);
            //ID,型号,数量,批号,厂牌, 目标价,备注,分钟,客户,采购员,芯片状态id
            Inquiry * inquiry = [[Inquiry alloc] init];
            inquiry.ider = [cells objectAtIndex:0];
            //inquiry.cusInqID = [cells objectAtIndex:1];
            inquiry.type= [(NSString*)[cells objectAtIndex:1] uppercaseString];
            inquiry.quantity= [cells objectAtIndex:2];
            inquiry.price = [cells objectAtIndex:5];
            inquiry.batch = [cells objectAtIndex:3];
            inquiry.status = [cells objectAtIndex:10];
            inquiry.brand = [cells objectAtIndex:4];
            [kAppDelegate.temporaryValues setObject:inquiry forKey:@"inquiry"];
            [inquiry release];
            
            [self.contentController.navigationController
             pushViewController:[kAppDelegate loadFromVC:@"QuickSearchViewController"]
             animated:YES];
            break;
        }
        case 1://图片浏览
        {
            [kAppDelegate.temporaryValues setObject:
             ((TTTableTextItem*)[kAppDelegate.temporaryValues objectForKey:@"swipRow"]).text 
                                             forKey:@"selectType"];
            
            [self.contentController.navigationController pushViewController:[kAppDelegate loadFromVC:@"QuickPicListViewController"] 
                                                                   animated:YES];
            break;
        }
        default:
            break;
    }
    
    [self removeSideSwipeView:YES];
}

-(id <UITableViewDelegate>) createDelegate{
	return [[[QuoteInquiryListDelegate alloc] initWithController:self] autorelease];
}



@end
