//
//  Stock.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-1-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Stock.h"


@implementation Stock
@synthesize ider;
@synthesize type;
@synthesize quantity;
@synthesize brand;
@synthesize description;
@synthesize date;
@synthesize alias;
@synthesize truth;
@synthesize address;
@synthesize supplier;

//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [ider release];
    ider = nil;
    [type release];
    type = nil;
    [quantity release];
    quantity = nil;
    [brand release];
    brand = nil;

    [description release];
    description = nil;
    [date release];
    date = nil;
    [alias release];
    alias = nil;
    [truth release];
    truth = nil;
    [address release];
    address = nil;
    [supplier release];
    supplier = nil;
	
    [super dealloc];
}




@end
