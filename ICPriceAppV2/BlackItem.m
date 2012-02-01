//
//  BlackItem.m
//  PocketTrain
//
//  Created by Fei Gao on 11-1-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BlackItem.h"


@implementation BlackItem

@synthesize blackColor = _blackColor;


- (void)dealloc {
	TT_RELEASE_SAFELY(_blackColor);	
    [super dealloc];
}


@end
