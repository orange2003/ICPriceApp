//
//  TypeSearchModel.h
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "BaseModel.h"
@class ASIFormDataRequest;

@interface TypeSearchModel : BaseModel {
	ASIFormDataRequest *asiRequest;
}
@property (nonatomic, retain) ASIFormDataRequest *asiRequest;
- (void)search:(NSString*)text;
@end
