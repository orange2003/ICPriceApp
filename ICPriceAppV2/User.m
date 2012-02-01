//
//  User.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "User.h"


@implementation User
@synthesize ider;
@synthesize roleId;
@synthesize companyId;
@synthesize companyName;
@synthesize platform;
@synthesize currency;
@synthesize companyPlantform;
@synthesize inquiryTips;
@synthesize platformNum;
@synthesize platName;
@synthesize name;
//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
	[ider release];
	ider = nil;
    [roleId release];
    roleId = nil;
    [companyId release];
    companyId = nil;
    [companyName release];
    companyName = nil;
    [platform release];
    platform = nil;
    [currency release];
    currency = nil;
    [companyPlantform release];
    companyPlantform = nil;
    [inquiryTips release];
    inquiryTips = nil;
    [platformNum release];
    platformNum = nil;
	[platName release];
	platName = nil;
	[name release];
	name = nil;
    [super dealloc];
}

@end
