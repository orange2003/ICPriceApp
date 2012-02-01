//
//  BaseModel.h
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


@interface BaseModel : TTModel {
	NSMutableArray*  _items;
}
@property (nonatomic, copy) NSMutableArray *items;

@end
