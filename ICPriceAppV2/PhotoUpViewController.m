//
//  PhotoUpViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  图片上传

#import "PhotoUpViewController.h"
#import "PhotoUpDataSource.h"
#import "User.h"
#import "IBAButtonFormField.h"
#import "TypePhotoSearchViewController.h"
#import "InquiryUpdataDataSource.h"
#import "SWSnapshotStackView.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
@implementation PhotoUpViewController
@synthesize preview = _preview;
@synthesize type = _type; 

- (void) dealloc {
    TT_RELEASE_SAFELY(_type);
    TT_RELEASE_SAFELY(_preview);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		 
		//self.navigationController.navigationItem.
		NSMutableDictionary *formModel = [[[NSMutableDictionary alloc] init] autorelease];
		PhotoUpDataSource *formDataSourcet = [[PhotoUpDataSource alloc] initWithModel:formModel] ;
		self.formDataSource = formDataSourcet;
		[formDataSourcet release];
		
		IBAButtonFormField * supplier = [[IBAButtonFormField alloc] initWithTitle:@"选择型号"
																			 icon:nil
																   executionBlock:^{
                                                                     TypePhotoSearchViewController *search=  (TypePhotoSearchViewController*)[kAppDelegate loadFromVC:@"TypePhotoSearchViewController"];
                                                                       search.controller= self;
                                                                       [self presentModalViewController:search
                                                                                               animated:YES];
																   }];
		[(IBAFormSection*)[self.formDataSource.sections objectAtIndex:0] 
		 addFormField:[supplier autorelease]];
		
        
		
		[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
					  withRowAnimation:UITableViewRowAnimationNone];

        
	}
	return self;
}

-(void)loadView{
    [super loadView];
    self.title = @"图片上传";
    
    UIBarButtonItem *_menu = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = _menu;
    
    UIBarButtonItem *_upPic = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:UIBarButtonItemStyleBordered target:self action:@selector(upAction)];
    self.navigationItem.rightBarButtonItem = _upPic;
    
    UITableView *formTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0,0,320,460)
															   style:UITableViewStylePlain] autorelease];
	formTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth
	| UIViewAutoresizingFlexibleHeight;
	
	self.tableView = formTableView;	
    
    UIView *_head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    self.tableView.tableHeaderView = _head;
    [_head release];
    
    SWSnapshotStackView * sw = [[SWSnapshotStackView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    sw.contentMode = UIViewContentModeRedraw;
    sw.image = self.preview;
    sw.displayAsStack = YES;
    [_head addSubview:sw];
    [sw release];
    
    UIButton *_upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upButton setImage:TTIMAGE(@"bundle://icon-camera.png") forState:UIControlStateNormal];
    _upButton.frame = CGRectMake(0, 0, 320, 160);
    _upButton.contentEdgeInsets = UIEdgeInsetsMake(130, 150, 0, 0);
    [_head addSubview:_upButton];
    
    
	[self.view addSubview:formTableView];
}


//图片上传
-(void)upAction{
    if (!_type||[_type stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
		[kAppDelegate alert:@"" message:@"请选择型号"];
		return;
	}
    
    NSString *temp;
	if ([[self.formDataSource.model objectForKey:@"status"] isKindOfClass:[NSArray class]]) {
		temp = [((NSArray*)[self.formDataSource.model objectForKey:@"status"]) objectAtIndex:0];
	}else {
		temp = [((NSSet*)[self.formDataSource.model objectForKey:@"status"]) anyObject];
	}
	temp = [((NSMutableDictionary*)[kAppDelegate.constants objectAtIndex:1]) valueForKey:temp];
	
	NSString *batch;
	if ([[self.formDataSource.model objectForKey:@"bath"] isKindOfClass:[NSArray class]]) {
		batch = [((NSArray*)[self.formDataSource.model objectForKey:@"batch"]) objectAtIndex:0];
	}else {
		batch = [((NSSet*)[self.formDataSource.model objectForKey:@"batch"]) anyObject];
	}
    
    batch = [((NSMutableDictionary*)[kAppDelegate.constants objectAtIndex:0]) valueForKey:batch];
    
    //参数说明：
    //pn:型号,
    //rtype:图片上传的类型，无关联的，订单，现货 这样可以把多个图片上传界面统一起来
    //desc:图片描述，文本,
    //dcid:批号ID,
    //rid: 关联ID，如现货库存ID或者订单ID
    //clssid:分类ID,
    //uid:
    NSMutableDictionary *operationData = [NSMutableDictionary dictionary];
    [operationData setObject:self.type forKey:@"pn"];
    [operationData setObject:@"" forKey:@"rtype"];
    [operationData setObject:[self.formDataSource.model objectForKey:@"remarks"]?
     [self.formDataSource.model objectForKey:@"remarks"]:@""
                      forKey:@"desc"];
    [operationData setObject:@"" forKey:@"rid"];
    [operationData setObject:batch?batch:@"" forKey:@"dcid"];
    [operationData setObject:temp?temp:@"" forKey:@"clssid"];
    [operationData setObject:kAppDelegate.user.ider forKey:@"uid"];
    
    NSURL *url = [NSURL URLWithString:@"http://www.icprice.cn/handlers/upload.ashx"];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[operationData JSONString] forKey:@"para"];
    [request setPostValue:@"pic" forKey:@"type"];
    
    [request setData:UIImageJPEGRepresentation(self.preview, 1.0)
		withFileName:@"myphoto.jpg" 
	  andContentType:@"image/jpeg" forKey:@"file"];
	[request setDelegate:self];
    [kAppDelegate showWithLabelDeterminate:@"上传中"];
	request.uploadProgressDelegate = kAppDelegate.HUD;
	//request.uploadProgressDelegate = progressView;
	request.didFinishSelector = @selector(finishUpdata:);
	request.didFailSelector = @selector(failUpdata:);
	[request setShouldContinueWhenAppEntersBackground:YES];
	[request startAsynchronous];
}

-(void)finishUpdata:(ASIHTTPRequest *)request{
    //NSLog(@"finishUpdata %@",[request responseString]);
    
    kAppDelegate.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
    // Set custom view mode
    kAppDelegate.HUD.mode = MBProgressHUDModeCustomView;
    kAppDelegate.HUD.animationType = MBProgressHUDAnimationZoom;
    kAppDelegate.HUD.labelText = @"图片上传成功!";
    
    [kAppDelegate.HUD show:YES];
    [kAppDelegate.HUD hide:YES afterDelay:1.5];
    
    [self performSelector:@selector(dismissModalViewControllerAnimated:)
               withObject:(id) kCFBooleanTrue 
               afterDelay:1.5];
}


-(void)failUpdata:(ASIHTTPRequest *)request{

    
    //[self dismissModalViewControllerAnimated:YES];
	NSLog(@"error %@",[request error]);
}

-(void)backAction{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)typeSelect:(NSString*)text{
	self.type = text;
	IBAFormSection *section = (IBAFormSection*)[self.formDataSource.sections objectAtIndex:0];
	((IBAButtonFormField*)[section.formFields objectAtIndex:0]).title = text;
	[((IBAButtonFormField*)[section.formFields objectAtIndex:0]) updateCellContents];
	[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
				  withRowAnimation:UITableViewRowAnimationNone];
}

@end
