//
//  InquiryListController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InquiryListController.h"
#import "InquiryListDataSource.h"
#import "QuoteInquiryListDelegate.h"
#import "NSStringAdditions.h"
#import "Inquiry.h"
#import "IIViewDeckController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "User.h"
#define BUTTON_LEFT_MARGIN 10.0
#define BUTTON_SPACING 10.0

@interface InquiryListController (PrivateStuff)
-(void) setupSideSwipeView;
@end

@implementation InquiryListController


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InquiryListRefresh) 
                                                     name:@"InquiryListRefresh" object:nil];
    }
    return self;
}

-(void)InquiryListRefresh{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"DragRefreshTableReload" object:nil];
    [self.model load:TTURLRequestCachePolicyNetwork more:NO];
}

-(void)loadView{
    [super loadView];
    self.variableHeightRows = NO;
    self.tableView.rowHeight = 44;
    // Setup the title and image for each button within the side swipe view
    buttonData = [[NSArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"无货操作", @"title", @"reply.png", @"image", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"直接报价", @"title", @"reply.png", @"image", nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"图片浏览", @"title", @"reply.png", @"image", nil],
                   nil] retain];
    buttons = [[NSMutableArray alloc] initWithCapacity:buttonData.count];
    
    self.sideSwipeView = [[[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.rowHeight)] autorelease];
    
    [self setupSideSwipeView];
    
    self.dataSource = [[[InquiryListDataSource alloc] init] autorelease];
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
       // UIImage* buttonImage = [UIImage imageNamed:[buttonInfo objectForKey:@"image"]];
        
        // Set the button's frame
//        button.frame = CGRectMake(leftEdge, sideSwipeView.center.y - buttonImage.size.height/2.0, buttonImage.size.width, buttonImage.size.height);
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
    
    switch (index) {
        case 0://无货操作
            [self soldout];
            break;
        case 1://直接报价
            [self InquiryUp];
            break;
//        case 2://图片上传
//        {
//            [kAppDelegate.temporaryValues setObject:@"0" forKey:@"picType"];
//            [kAppDelegate.temporaryValues setObject:@"" forKey:@"picRid"];
//            [self.contentController.viewDeckController photoUp];
//            break;
//        }
        case 2://图片浏览
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

-(void)InquiryUp{
    if (![((TTTableTextItem*)[kAppDelegate.temporaryValues objectForKey:@"swipRow"]).text isEmptyOrWhitespace]) {
        NSArray * cells  = ((TTTableTextItem*)[kAppDelegate.temporaryValues objectForKey:@"swipRow"]).userInfo;
        //ID,cusInqId,型号,数量,批号,厂牌,suNote,分钟,平台
        Inquiry * inquiry = [[Inquiry alloc] init];
        inquiry.ider = [cells objectAtIndex:0];
        inquiry.cusInqID = [cells objectAtIndex:1];
        inquiry.type= [(NSString*)[cells objectAtIndex:2] uppercaseString];
        inquiry.quantity= [cells objectAtIndex:3];
        //inquiry.price = [cells objectAtIndex:3];
        inquiry.batch = [cells objectAtIndex:4];
        //inquiry.status = [cells objectAtIndex:5];
        inquiry.brand = [cells objectAtIndex:5];
        [kAppDelegate.temporaryValues setObject:inquiry forKey:@"inquiry"];
        [inquiry release];
        
        [self.contentController.navigationController pushViewController:[kAppDelegate loadFromVC:@"InquiryUpdataController"] 
                                                               animated:YES];
    }else{
        [kAppDelegate alert:@"" message:@"缺少芯片型号请补全"];
    }
}

-(void)soldout{
    [kAppDelegate HUDShow:@"提交中" yOffset:@"0"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kRESTBaseUrl]];
    NSMutableDictionary *operationData = [NSMutableDictionary dictionary];
    [operationData setValue:@"up_iphone_update_caigouSoldout" forKey:@"ObjectName"];
    NSArray * _info =   ((TTTableTextItem*)[kAppDelegate.temporaryValues objectForKey:@"swipRow"]).userInfo;
//    @uID int,
//    @cusInqId int,
//    @ID int
    [operationData setValue:[NSArray arrayWithObjects:
                             kAppDelegate.user.ider,
                             [_info objectAtIndex:1],
                             [_info objectAtIndex:0],
                             nil] 
                     forKey:@"Values"];
    
    [request setPostValue:@"PRC" forKey:@"OperationCode"];
    [request setPostValue:[operationData JSONString] forKey:@"OperationData"];
    
	[request setRequestMethod:@"POST"];
    [request setDelegate:self];
    request.didFinishSelector = @selector(soldoutHandler:);
    request.didFailSelector = @selector(finishFail:);
	[request startAsynchronous];
}

-(void)finishFail:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	[kAppDelegate alert:@"" message:[[request error] localizedDescription]];
}

-(void)soldoutHandler:(ASIHTTPRequest *)request{
    NSDictionary *data =[[JSONDecoder decoder] objectWithData:[request responseData]];
    if ([[data objectForKey:@"ISSuccess"] intValue]==0) {
        [kAppDelegate HUDHide];
        [kAppDelegate alert:@"" message:@"操作失败"];
        return;
    }
    kAppDelegate.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
    
    // Set custom view mode
    kAppDelegate.HUD.mode = MBProgressHUDModeCustomView;
    kAppDelegate.HUD.animationType = MBProgressHUDAnimationZoom;
    kAppDelegate.HUD.labelText = @"操作成功!";
    
    [kAppDelegate.HUD show:YES];
    [kAppDelegate.HUD hide:YES afterDelay:1.5];
    [self reload];
}


-(id <UITableViewDelegate>) createDelegate{
	return [[[QuoteInquiryListDelegate alloc] initWithController:self] autorelease];
}


-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.contentController.viewDeckController leftControllerIsClosed]) {
        if (![((TTTableTextItem*)object).text isEmptyOrWhitespace]) {
            [kAppDelegate.temporaryValues setObject:((TTTableTextItem*)object).text
                                             forKey:@"selectType"];
            [kAppDelegate.temporaryValues setObject:((TTTableTextItem*)object).text
                                             forKey:@"searchText"];
            
            [kAppDelegate.temporaryValues setObject:@"0"
                                             forKey:@"quickType"];
            
            NSArray * cells  = ((TTTableTextItem*)object).userInfo;
            //ID,cusInqId,型号,数量,批号,厂牌,suNote,分钟,平台
            Inquiry * inquiry = [[Inquiry alloc] init];
            inquiry.ider = [cells objectAtIndex:0];
            inquiry.cusInqID = [cells objectAtIndex:1];
            inquiry.type= [(NSString*)[cells objectAtIndex:2] uppercaseString];
            inquiry.quantity= [cells objectAtIndex:3];
            //inquiry.price = [cells objectAtIndex:3];
            inquiry.batch = [cells objectAtIndex:4];
            //inquiry.status = [cells objectAtIndex:5];
            inquiry.brand = [cells objectAtIndex:5];
            [kAppDelegate.temporaryValues setObject:inquiry forKey:@"inquiry"];
            [inquiry release];
            
            [self.contentController.navigationController pushViewController:[kAppDelegate loadFromVC:@"QuickSearchViewController"] 
                                                                   animated:YES];
        }else{
            [kAppDelegate alert:@"" message:@"缺少芯片型号请补全"];
        }
    }
    
}

@end
