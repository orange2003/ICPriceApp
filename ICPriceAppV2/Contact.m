//
//  Contact.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Contact.h"


@implementation Contact

@synthesize ider;
@synthesize name;
@synthesize sex;
@synthesize title;

//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [ider release];
    ider = nil;
    [name release];
    name = nil;
    [sex release];
    sex = nil;
	[title release];
    title = nil;
    [super dealloc];
}




@end
