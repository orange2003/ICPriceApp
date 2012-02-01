//
//  InquiryUpdataController.h
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "IBAFormViewController.h"
@class Contact;
@interface InquiryUpdataController : IBAFormViewController<UIActionSheetDelegate,UIAlertViewDelegate,UITableViewDelegate> {
	NSString* _type;
	Contact *contact;
	NSString* phone;
}
@property (nonatomic, copy) NSString *type;
@property (nonatomic, retain) Contact *contact;
@end
