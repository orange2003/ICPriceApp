//
//  Contact.h
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


@interface Contact : NSObject {
	NSString *ider;
	NSString *name;
	NSString *sex;
	NSString *title;
}
@property (nonatomic, copy) NSString *ider;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *title;

@end
