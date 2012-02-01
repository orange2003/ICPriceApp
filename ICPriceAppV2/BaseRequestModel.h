//
//  BaseRequestModel.h
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//



@interface BaseRequestModel : TTURLRequestModel {
	NSUInteger _page;             // page of search request
	NSString *_resultsPerPage;   // results per page, once the initial query is made
	// this value shouldn't be changed
	BOOL _finished;
	NSMutableArray*  _items;
}
@property (nonatomic, retain)   NSString        *resultsPerPage;
@property (nonatomic, readonly) BOOL            finished;
@property (nonatomic, readonly) NSMutableArray  *items;
- (id)initWithResultsPerPage:(NSString*)resultsPerPage;
-(void)generateRequest:(TTURLRequestCachePolicy)cachePolicy;
@end
