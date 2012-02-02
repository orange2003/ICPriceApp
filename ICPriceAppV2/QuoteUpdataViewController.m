//
//  QuoteUpViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuoteUpdataViewController.h"
#import "QuoteUpdataDataSource.h"
#import "Inquiry.h"
#import "Contact.h"
#import "IBAButtonFormField.h"
#import "IBAFormSection.h"
#import "IBAPickListFormField.h"
#import "IBAFormSection.h"
#import "User.h"
#import "IBAInputManager.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "NSStringAdditions.h"
@implementation QuoteUpdataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"报价更新";
        
        NSMutableDictionary *formModel = [[[NSMutableDictionary alloc] init] autorelease];
		QuoteUpdataDataSource *formDataSourcet = [[QuoteUpdataDataSource alloc] initWithModel:formModel] ;
		self.formDataSource = formDataSourcet;
		[formDataSourcet release];
        
        [self.formDataSource setModelValue:((Inquiry*)[kAppDelegate.temporaryValues 
                                                       objectForKey:@"inquiry"]).quantity
								forKeyPath:@"quantity"];
        
        [self.formDataSource setModelValue:[NSArray arrayWithObject:
                                            ((Inquiry*)[kAppDelegate.temporaryValues 
                                                                objectForKey:@"inquiry"]).status]
                                forKeyPath:@"status"];
        
		[self.formDataSource setModelValue:((Inquiry*)[kAppDelegate.temporaryValues 
                                                       objectForKey:@"inquiry"]).batch
								forKeyPath:@"batch"];
        
    }
    return  self;
}

- (void)loadView;
{
	[super loadView];
	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] 
                                  initWithTitle:@"保存"
                                  style:UIBarButtonItemStyleDone
                                  target:self action:@selector(quoteUpdata)];
	self.navigationItem.rightBarButtonItem = rightItem;
	
	UITableView *formTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height) 
															   style:UITableViewStylePlain] autorelease];
    formTableView.delegate = self;
    
	[formTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	
	[self setTableView:formTableView];
	[self.view addSubview:formTableView];
}

-(void)quoteUpdata{
    NSLog(@"price %@",[self.formDataSource.model objectForKey:@"price"]);
    if (![self.formDataSource.model objectForKey:@"price"]||[[self.formDataSource.model objectForKey:@"price"] isEmptyOrWhitespace]) {
        [kAppDelegate alert:@"" message:@"请输入报价"];
        return;
    }
    
	[[IBAInputManager sharedIBAInputManager] deactivateActiveInputRequestor];
    NSString *tStatus;
	NSString *temp;
	if ([[self.formDataSource.model objectForKey:@"status"] isKindOfClass:[NSArray class]]) {
		temp = [((NSArray*)[self.formDataSource.model objectForKey:@"status"]) objectAtIndex:0];
	}else {
		temp = [((NSSet*)[self.formDataSource.model objectForKey:@"status"]) anyObject];
	}
    tStatus = [((NSMutableDictionary*)[kAppDelegate.constants objectAtIndex:2]) valueForKey:temp];
    
    [kAppDelegate HUDShow:@"提交中" yOffset:@"0"];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kRESTBaseUrl]];
    NSMutableDictionary *operationData = [NSMutableDictionary dictionary];
    
    [operationData setValue:@"up_iphone_updateRfqBodyOfSales" forKey:@"ObjectName"];
//    @uID int,
//    @ID int,
//    @数量int,
//    @suPrice smallmoney,  报价
//    @批号varchar(20),
//    @芯片状态ID tinyint, 芯片状态
//    @suNote varchar(100) 备注
    [operationData setValue:[NSArray arrayWithObjects:
                             kAppDelegate.user.ider,
                             ((Inquiry*)[kAppDelegate.temporaryValues objectForKey:@"inquiry"]).ider,
                             [self.formDataSource.model objectForKey:@"quantity"]?
                             [self.formDataSource.model objectForKey:@"quantity"]:@"",
                             [self.formDataSource.model objectForKey:@"price"]?[self.formDataSource.model objectForKey:@"price"]:@"",
                             [self.formDataSource.model objectForKey:@"batch"]?[self.formDataSource.model objectForKey:@"batch"]:@"",
                             tStatus?tStatus:@"",
                             [self.formDataSource.model objectForKey:@"remarks"]?
                             [self.formDataSource.model objectForKey:@"remarks"]:@"",
                             nil] 
                     forKey:@"Values"];
    
    [request setPostValue:@"PRC" forKey:@"OperationCode"];
   // NSLog(@"OperationData %@",operationData);
    [request setPostValue:[operationData JSONString] forKey:@"OperationData"];
    
	[request setRequestMethod:@"POST"];
    [request setDelegate:self];
    request.didFinishSelector = @selector(inquiryUpdataHandler:);
    request.didFailSelector = @selector(finishFail:);
	[request startAsynchronous];
}

-(void)inquiryUpdataHandler:(ASIHTTPRequest *)request{
    //NSLog(@"request %@",[request responseString]);
    NSDictionary *data =[[JSONDecoder decoder] objectWithData:[request responseData]];
    if ([[data objectForKey:@"ISSuccess"] intValue]==0) {
        [kAppDelegate HUDHide];
        [kAppDelegate alert:@"" message:@"更新失败"];
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"QuoteListRefresh" object:nil];
    // NSLog(@"data %@",data);
    kAppDelegate.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
    
    // Set custom view mode
    kAppDelegate.HUD.mode = MBProgressHUDModeCustomView;
    kAppDelegate.HUD.animationType = MBProgressHUDAnimationZoom;
    kAppDelegate.HUD.labelText = @"保存成功!";
    
    [kAppDelegate.HUD show:YES];
    [kAppDelegate.HUD hide:YES afterDelay:1.5];
    [self performSelector:@selector(backAction) withObject:nil afterDelay:1.6];
}

-(void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
