//
//  Inquiry.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Inquiry.h"


@implementation Inquiry
@synthesize status;
@synthesize price;
@synthesize source;
@synthesize platform;
@synthesize inquiry;
@synthesize package;
@synthesize priority;
@synthesize quote;
@synthesize customerID;
@synthesize customerName;
@synthesize customerAlias;
@synthesize remarks;
@synthesize supplierName;
@synthesize cusInqID;
@synthesize batch;
- (void)dealloc
{
    [status release];
    status = nil;
	[price release];
    price = nil;
	[source release];
    source = nil;
	[platform release];
    platform = nil;
	[inquiry release];
    inquiry = nil;
	
	[package release];
    package = nil;
	
	[priority release];
    priority = nil;
	
	[quote release];
    quote = nil;
	
	[customerID release];
    customerID = nil;
    [customerName release];
    customerName = nil;
	
    [customerAlias release];
    customerAlias = nil;
	
	[remarks release];
	remarks = nil;
	
	[supplierName release];
	supplierName = nil;
	
	[cusInqID release];
	cusInqID = nil;
	
	[batch release];
    batch = nil;
	
    [super dealloc];
}

-(id) copyWithZone:(NSZone *)zone{
	Inquiry *copy = [[ [self  class]  allocWithZone: zone] init];
	copy.ider = ider;
	copy.type = type;
	copy.quantity = quantity;
	copy.brand = brand;
	copy.batch = batch;
	copy.description = description;
	copy.date = date;
	copy.alias = alias;
	copy.truth = truth;
	copy.address = address;
	copy.supplier = supplier;
	copy.status = status;
	copy.price = price;
	copy.source = source;
	copy.platform = platform;
	copy.inquiry = inquiry;
	copy.package = package;
	copy.priority = priority;
	copy.quote = quote;
	copy.customerID = customerID;
	copy.customerName = customerName;
	copy.customerAlias = customerAlias;
	copy.remarks = remarks;
	copy.supplierName = supplierName;
	copy.cusInqID = cusInqID;
	return copy;
}


@end
