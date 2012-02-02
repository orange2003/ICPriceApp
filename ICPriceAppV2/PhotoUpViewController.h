//
//  PhotoUpViewController.h
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IBAFormViewController.h"
@class  SWSnapshotStackView;
@interface PhotoUpViewController : IBAFormViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImage *_preview;
    NSString *_type;
    SWSnapshotStackView * _sw;
}
@property (nonatomic, retain) IBOutlet UIImage *preview;
@property (nonatomic, copy) IBOutlet NSString *type;
@end
