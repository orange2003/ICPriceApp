//
//  BaseModel.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
@synthesize items = _items;

//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    TT_RELEASE_SAFELY(_items);
    [super dealloc];
}

@end
