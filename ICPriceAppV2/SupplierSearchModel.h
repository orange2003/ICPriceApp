//
//  SupplierSearchModel.h
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseModel.h"
@class ASIFormDataRequest;


@interface SupplierSearchModel : BaseModel {
	ASIFormDataRequest *asiRequest;
}
@property (nonatomic, retain) ASIFormDataRequest *asiRequest;
- (void)search:(NSString*)text;


@end
