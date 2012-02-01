//
//  TypePhotoSearchViewController.h
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@interface TypePhotoSearchViewController : TTTableViewController<UISearchBarDelegate> {
	id	controller;
}
@property (nonatomic, assign) id controller;

-(id)initWithParams:(NSDictionary*)query;
@end
