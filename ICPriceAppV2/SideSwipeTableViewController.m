//
//  SideSwipeTableViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SideSwipeTableViewController.h"
// By setting this to YES, you'll use gesture recognizers under 4.x and use the table's swipe to delete under 3.x
// By setting it to NO, you'll be using the table's swipe to delete under both 3.x and 4.x. This is what version 3 of the Twitter app does
// Swipe to delete on a table doesn't expose the direction of the swipe, so the animation will always be left to right
#define USE_GESTURE_RECOGNIZERS YES
// Bounce pixels define how many pixels the view is moved during the bounce animation
#define BOUNCE_PIXELS 5.0
// The first implemenation of this animated both the cell and the sideSwipeView.
// But this isn't exactly how the Twitter app does it. Instead it keeps the sideSwipeView behind the cell at x-offset of 0
// then animates in and out the cell content. The code has been updated to do it this way. If you preferred the old way
// set PUSH_STYLE_ANIMATION to YES and you'll get the older push style animation
#define PUSH_STYLE_ANIMATION NO



@interface SideSwipeTableViewController (PrivateStuff)
- (void) addSwipeViewTo:(UITableViewCell*)cell direction:(UISwipeGestureRecognizerDirection)direction;
- (void) setupGestureRecognizers;

@end

@implementation SideSwipeTableViewController

@synthesize sideSwipeCell,animatingSideSwipe,sideSwipeView,sideSwipeDirection;
@synthesize contentController = _contentController;

-(void)dealloc{
    TT_RELEASE_SAFELY(buttons);
    TT_RELEASE_SAFELY(buttonData);
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    animatingSideSwipe = NO;
}

// Called when a left swipe occurred
- (void)swipeLeft:(UISwipeGestureRecognizer *)recognizer
{
    [self swipe:recognizer direction:UISwipeGestureRecognizerDirectionLeft];
}

// Called when a right swipe ocurred
- (void)swipeRight:(UISwipeGestureRecognizer *)recognizer
{
    [self swipe:recognizer direction:UISwipeGestureRecognizerDirectionRight];
}

// Handle a left or right swipe
- (void)swipe:(UISwipeGestureRecognizer *)recognizer direction:(UISwipeGestureRecognizerDirection)direction
{
    if (recognizer && recognizer.state == UIGestureRecognizerStateEnded)
    {
        // Get the table view cell where the swipe occured
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:location];
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        // If we are already showing the swipe view, remove it
        if (cell.frame.origin.x != 0)
        {
            [self removeSideSwipeView:YES];
            return;
        }
        
        // Make sure we are starting out with the side swipe view and cell in the proper location
        [self removeSideSwipeView:NO];
        
        // If this isn't the cell that already has thew side swipe view and we aren't in the middle of animating
        // then start animating in the the side swipe view
        if (cell!= sideSwipeCell && !animatingSideSwipe)
            [self addSwipeViewTo:cell direction:direction];
    }
}


#pragma mark Adding the side swipe view
- (void) addSwipeViewTo:(UITableViewCell*)cell direction:(UISwipeGestureRecognizerDirection)direction
{
    // Change the frame of the side swipe view to match the cell
    sideSwipeView.frame = cell.frame;
    
    // Add the side swipe view to the table below the cell
    [self.tableView insertSubview:sideSwipeView belowSubview:cell];
    
    
    [kAppDelegate.temporaryValues setObject:[((TTListDataSource*)self.dataSource).items objectAtIndex:
                                             [self.tableView indexPathForCell:cell].row]
                                     forKey:@"swipRow"];
    
    
    
    
    // Remember which cell the side swipe view is displayed on and the swipe direction
    self.sideSwipeCell = cell;
    sideSwipeDirection = direction;
    
    CGRect cellFrame = cell.frame;
    if (PUSH_STYLE_ANIMATION)
    {
        // Move the side swipe view offscreen either to the left or the right depending on the swipe direction
        sideSwipeView.frame = CGRectMake(direction == UISwipeGestureRecognizerDirectionRight ? -cellFrame.size.width : cellFrame.size.width, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height);
    }
    else
    {
        // Move the side swipe view to offset 0
        sideSwipeView.frame = CGRectMake(0, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height);
    }
    
    // Animate in the side swipe view
    animatingSideSwipe = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStopAddingSwipeView:finished:context:)];
    if (PUSH_STYLE_ANIMATION)
    {
        // Move the side swipe view to offset 0
        // While simultaneously moving the cell's frame offscreen
        // The net effect is that the side swipe view is pushing the cell offscreen
        sideSwipeView.frame = CGRectMake(0, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height);
    }
    cell.frame = CGRectMake(direction == UISwipeGestureRecognizerDirectionRight ? cellFrame.size.width : -cellFrame.size.width, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height);
    [UIView commitAnimations];
}

// Note that the animation is done
- (void)animationDidStopAddingSwipeView:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    animatingSideSwipe = NO;
}

// Remove the side swipe view.
// If animated is YES, then the removal is animated using a bounce effect
- (void) removeSideSwipeView:(BOOL)animated
{
    // Make sure we have a cell where the side swipe view appears and that we aren't in the middle of animating
    if (!sideSwipeCell || animatingSideSwipe) return;
    
    if (animated)
    {
        // The first step in a bounce animation is to move the side swipe view a bit offscreen
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        if (sideSwipeDirection == UISwipeGestureRecognizerDirectionRight)
        {
            if (PUSH_STYLE_ANIMATION)
                sideSwipeView.frame = CGRectMake(-sideSwipeView.frame.size.width + BOUNCE_PIXELS,sideSwipeView.frame.origin.y,sideSwipeView.frame.size.width, sideSwipeView.frame.size.height);
            sideSwipeCell.frame = CGRectMake(BOUNCE_PIXELS, sideSwipeCell.frame.origin.y, sideSwipeCell.frame.size.width, sideSwipeCell.frame.size.height);
        }
        else
        {
            if (PUSH_STYLE_ANIMATION)
                sideSwipeView.frame = CGRectMake(sideSwipeView.frame.size.width - BOUNCE_PIXELS,sideSwipeView.frame.origin.y,sideSwipeView.frame.size.width, sideSwipeView.frame.size.height);
            sideSwipeCell.frame = CGRectMake(-BOUNCE_PIXELS, sideSwipeCell.frame.origin.y, sideSwipeCell.frame.size.width, sideSwipeCell.frame.size.height);
        }
        animatingSideSwipe = YES;
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStopOne:finished:context:)];
        [UIView commitAnimations];
    }
    else
    {
        [sideSwipeView removeFromSuperview];
        sideSwipeCell.frame = CGRectMake(0,sideSwipeCell.frame.origin.y,sideSwipeCell.frame.size.width, sideSwipeCell.frame.size.height);
        self.sideSwipeCell = nil;
    }
}

#pragma mark Bounce animation when removing the side swipe view
// The next step in a bounce animation is to move the side swipe view a bit on screen
- (void)animationDidStopOne:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    if (sideSwipeDirection == UISwipeGestureRecognizerDirectionRight)
    {
        if (PUSH_STYLE_ANIMATION)
            sideSwipeView.frame = CGRectMake(-sideSwipeView.frame.size.width + BOUNCE_PIXELS*2,sideSwipeView.frame.origin.y,sideSwipeView.frame.size.width, sideSwipeView.frame.size.height);
        sideSwipeCell.frame = CGRectMake(BOUNCE_PIXELS*2, sideSwipeCell.frame.origin.y, sideSwipeCell.frame.size.width, sideSwipeCell.frame.size.height);
    }
    else
    {
        if (PUSH_STYLE_ANIMATION)
            sideSwipeView.frame = CGRectMake(sideSwipeView.frame.size.width - BOUNCE_PIXELS*2,sideSwipeView.frame.origin.y,sideSwipeView.frame.size.width, sideSwipeView.frame.size.height);
        sideSwipeCell.frame = CGRectMake(-BOUNCE_PIXELS*2, sideSwipeCell.frame.origin.y, sideSwipeCell.frame.size.width, sideSwipeCell.frame.size.height);
    }
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStopTwo:finished:context:)];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView commitAnimations];
}

// The final step in a bounce animation is to move the side swipe completely offscreen
- (void)animationDidStopTwo:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [UIView commitAnimations];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    if (sideSwipeDirection == UISwipeGestureRecognizerDirectionRight)
    {
        if (PUSH_STYLE_ANIMATION)
            sideSwipeView.frame = CGRectMake(-sideSwipeView.frame.size.width ,sideSwipeView.frame.origin.y,sideSwipeView.frame.size.width, sideSwipeView.frame.size.height);
        sideSwipeCell.frame = CGRectMake(0, sideSwipeCell.frame.origin.y, sideSwipeCell.frame.size.width, sideSwipeCell.frame.size.height);
    }
    else
    {
        if (PUSH_STYLE_ANIMATION)
            sideSwipeView.frame = CGRectMake(sideSwipeView.frame.size.width ,sideSwipeView.frame.origin.y,sideSwipeView.frame.size.width, sideSwipeView.frame.size.height);
        sideSwipeCell.frame = CGRectMake(0, sideSwipeCell.frame.origin.y, sideSwipeCell.frame.size.width, sideSwipeCell.frame.size.height);
    }
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStopThree:finished:context:)];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView commitAnimations];
}

// When the bounce animation is completed, remove the side swipe view and reset some state
- (void)animationDidStopThree:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    animatingSideSwipe = NO;
    self.sideSwipeCell = nil;
    [sideSwipeView removeFromSuperview];
}

#pragma mark Generate images with given fill color
// Convert the image's fill color to the passed in color
-(UIImage*) imageFilledWith:(UIColor*)color using:(UIImage*)startImage
{
    // Create the proper sized rect
    CGRect imageRect = CGRectMake(0, 0, CGImageGetWidth(startImage.CGImage), CGImageGetHeight(startImage.CGImage));
    
    // Create a new bitmap context
    CGContextRef context = CGBitmapContextCreate(NULL, imageRect.size.width, imageRect.size.height, 8, 0, CGImageGetColorSpace(startImage.CGImage), kCGImageAlphaPremultipliedLast);
    
    // Use the passed in image as a clipping mask
    CGContextClipToMask(context, imageRect, startImage.CGImage);
    // Set the fill color
    CGContextSetFillColorWithColor(context, color.CGColor);
    // Fill with color
    CGContextFillRect(context, imageRect);
    
    // Generate a new image
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage* newImage = [UIImage imageWithCGImage:newCGImage scale:startImage.scale orientation:startImage.imageOrientation];
    
    // Cleanup
    CGContextRelease(context);
    CGImageRelease(newCGImage);
    
    return newImage;
}

@end
