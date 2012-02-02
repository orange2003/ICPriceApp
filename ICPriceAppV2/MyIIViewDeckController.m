//
//  MyIIViewDeckController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyIIViewDeckController.h"
#import "PhotoUpViewController.h"
#import "UIImage+Scaled.h"
@implementation MyIIViewDeckController


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
    [self performSelector:@selector(toggleLeftView) withObject:nil afterDelay:0.0];
	UIImage *image = [[info objectForKey:UIImagePickerControllerEditedImage] scaledCopyOfSize:CGSizeMake(600, 800)];
	if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
		UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存相册
	}
	[picker dismissModalViewControllerAnimated:NO];
    
    PhotoUpViewController *upController= (PhotoUpViewController*)[kAppDelegate 
                                                                  loadFromVC:@"PhotoUpViewController"];
    
    upController.preview = image;
    [self presentModalViewController:[[[UINavigationController alloc] 
                                       initWithRootViewController:upController] 
                                      autorelease]
                            animated:NO];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
    [self performSelector:@selector(toggleLeftView) withObject:nil afterDelay:0.0];
}

@end
