//
//  StorageDetailsViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StorageDetailsViewController.h"
#import "QuoteInquiryListDelegate.h"
#import "StorageDetailsDataSource.h"
#import "NSStringAdditions.h"
#import "ASIFormDataRequest.h"
#import "User.h"
#import "JSONKit.h"
#define BUTTON_LEFT_MARGIN 10.0
#define BUTTON_SPACING 25.0

@interface StorageDetailsViewController (PrivateStuff)
-(void) setupSideSwipeView;
@end

@implementation StorageDetailsViewController

-(void)loadView{
    [super loadView];
    
    self.sideSwipeView = [[[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.rowHeight)] autorelease];
    
    [self setupSideSwipeView];
    
    self.dataSource = [[[StorageDetailsDataSource alloc] init] autorelease];
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    _ider = [((TTTableTextItem*)object).userInfo objectAtIndex:0];
    TSAlertView* av = [[[TSAlertView alloc] init] autorelease];
    //ID,箱号,数量,boxid
    
	av.title =[NSString stringWithFormat:@"%@ 数量改为",
               [((TTTableTextItem*)object).userInfo objectAtIndex:1]];
    av.delegate = self;
    av.style =  TSAlertViewStyleInput;
	av.message = @"";
    av.inputTextField.text =[NSString stringWithFormat:@"%@",
                              [((TTTableTextItem*)object).userInfo objectAtIndex:2]];
    av.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    [av addButtonWithTitle: [NSString stringWithFormat: @"确定"]];
    [av addButtonWithTitle: [NSString stringWithFormat: @"取消"]];
    [av show];
}

-(void)alertView:(TSAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        if (![alertView.inputTextField.text isEmptyOrWhitespace]) {
            [self performSelector:@selector(showHUD) withObject:nil afterDelay:0.0];
            ASIFormDataRequest *asiRequest = [[ASIFormDataRequest requestWithURL:[NSURL URLWithString:kRESTBaseUrl]] retain];
            NSMutableDictionary *operationData = [NSMutableDictionary dictionary];
            
            [operationData setValue:@"up_iphone_pandian" forKey:@"ObjectName"];
            [operationData setValue:[NSArray arrayWithObjects:
                                     _ider,
                                     [kAppDelegate.temporaryValues objectForKey:@"stockID"],
                                     alertView.inputTextField.text,
                                     kAppDelegate.user.ider,
                                     nil] 
                             forKey:@"Values"];
            
            //NSLog(@"OperationData %@",operationData);
            
            [asiRequest setPostValue:@"PRC" forKey:@"OperationCode"];
            [asiRequest setPostValue:[operationData JSONString] forKey:@"OperationData"];
            
            [asiRequest setRequestMethod:@"POST"];
            [asiRequest setDelegate:self];
            asiRequest.didFinishSelector = @selector(finishUp:);
            asiRequest.didFailSelector = @selector(finishFail:);
            [asiRequest startAsynchronous];
        }
    }
}

-(void)showHUD{
    [kAppDelegate HUDShow:@"提交中" yOffset:@"0"];
}

-(void)finishFail:(ASIHTTPRequest *)request{
    [kAppDelegate HUDHide];
    [kAppDelegate alert:@"" message:@"提交失败"];
	NSLog(@"request Fail");
    
}

-(void)finishUp:(ASIHTTPRequest *)requests{
   //NSLog(@"requests %@",[requests responseString]);
    NSDictionary *data =[[JSONDecoder decoder] objectWithData:[requests responseData]];
    if ([[data objectForKey:@"ISSuccess"] intValue]==1) {
        kAppDelegate.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
        // Set custom view mode
        kAppDelegate.HUD.mode = MBProgressHUDModeCustomView;
        kAppDelegate.HUD.animationType = MBProgressHUDAnimationZoom;
        kAppDelegate.HUD.labelText = @"修改成功!";
        
        [kAppDelegate.HUD show:YES];
        [kAppDelegate.HUD hide:YES afterDelay:1.5];
        [self reload];
    }else{
        [kAppDelegate alert:@"" message:@"更新失败"];
    }
}

// Called when a left swipe occurred
- (void)swipeLeft:(UISwipeGestureRecognizer *)recognizer
{
    //[self swipe:recognizer direction:UISwipeGestureRecognizerDirectionLeft];
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
