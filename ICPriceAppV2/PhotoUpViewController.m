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
#import "UIImage+Scaled.h"
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
		
        NSString *_typeName = @"选择型号";
        if ([[kAppDelegate.temporaryValues objectForKey:@"picType"] isEqualToString:@"0"]) {
            self.title = @"图片上传";
        }else if([[kAppDelegate.temporaryValues objectForKey:@"picType"] isEqualToString:@"1"]) {
            self.title = @"图片上传(订单)";
            self.type = [kAppDelegate.temporaryValues objectForKey:@"selectType"];
            _typeName = [kAppDelegate.temporaryValues objectForKey:@"selectType"];
        }else if([[kAppDelegate.temporaryValues objectForKey:@"picType"] isEqualToString:@"2"]) {
            self.title = @"图片上传(库存)";
            self.type = [kAppDelegate.temporaryValues objectForKey:@"selectType"];
            _typeName = [kAppDelegate.temporaryValues objectForKey:@"selectType"];
        }
        
        
		IBAButtonFormField * supplier = [[IBAButtonFormField alloc] initWithTitle:_typeName
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
    
    _sw = [[SWSnapshotStackView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    _sw.contentMode = UIViewContentModeRedraw;
    _sw.image = self.preview;
    _sw.displayAsStack = YES;
    [_head addSubview:_sw];
    [_sw release];
    
    UIButton *_upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upButton setImage:TTIMAGE(@"bundle://icon-camera.png") forState:UIControlStateNormal];
    [_upButton addTarget:self action:@selector(photoUp) forControlEvents:UIControlEventTouchUpInside];
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
    [operationData setObject:[kAppDelegate.temporaryValues objectForKey:@"picType"] forKey:@"rtype"];
    [operationData setObject:[self.formDataSource.model objectForKey:@"remarks"]?
     [self.formDataSource.model objectForKey:@"remarks"]:@""
                      forKey:@"desc"];
    [operationData setObject:[kAppDelegate.temporaryValues objectForKey:@"picRid"] forKey:@"rid"];
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

-(void)photoUp{
    UIActionSheet *actionSheet = nil;
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self 
                                     cancelButtonTitle:@"取消"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@"拍照上传",@"相册选取",nil];
    
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex==0) {//相机
		if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
			UIImagePickerController *camera = [[UIImagePickerController alloc] init];
			camera.sourceType = UIImagePickerControllerSourceTypeCamera;
			camera.allowsEditing = YES;
			camera.delegate = self;
			
			[self presentModalViewController:camera animated:YES];
			//[self presentModalViewController:camera animated:YES];
			[camera release];
		}
	}else if (buttonIndex ==1) {//相册
		UIImagePickerController *picker = [[UIImagePickerController alloc] init];
		picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		picker.allowsEditing = YES;
		picker.delegate = self;
        
		[self presentModalViewController:picker animated:YES];
		[picker release];
	}
}

- (void) imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
	UIImage *image = [[info objectForKey:UIImagePickerControllerEditedImage] scaledCopyOfSize:CGSizeMake(600, 800)];
	if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
		UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存相册
	}
	[picker dismissModalViewControllerAnimated:NO];
    
    self.preview = image;
    _sw.image = self.preview;
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
    [self performSelector:@selector(toggleLeftView) withObject:nil afterDelay:0.0];
}

@end
