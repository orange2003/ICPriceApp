//
//  BaseRequestModel.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseRequestModel.h"
#import <extThree20JSON/extThree20JSON.h>

@implementation BaseRequestModel

@synthesize resultsPerPage  = _resultsPerPage;
@synthesize finished        = _finished;
@synthesize items           = _items;
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
	TT_RELEASE_SAFELY(_resultsPerPage);
	TT_RELEASE_SAFELY(_items);
	[super dealloc];
}

- (id)initWithResultsPerPage:(NSString*)resultsPerPage{
	if (self = [super init]) {
		_resultsPerPage = resultsPerPage;
		_page = 1;
		_items = [[NSMutableArray array] retain];
	}
	return self;
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading) {
		if (more) {
			_page++;
		}
		else {
			[_items removeAllObjects];
			_page = 1;
			_finished = NO;
		}
		[self generateRequest:cachePolicy];
	}
}

-(void)generateRequest:(TTURLRequestCachePolicy)cachePolicy{
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLJSONResponse* response = request.response;
	//TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
	
	NSDictionary* feed = response.rootObject;
    //NSLog(@"response.rootObject %@",response.rootObject);
    if ([[feed objectForKey:@"ISSuccess"] intValue]==0) {
        return;
    }
	//NSLog(@"response.rootObject %@",[[feed objectForKey:@"result"] objectForKey:@"errormsg"]);
	//TTDASSERT([feed objectForKey:@"status"] ==200);//返回成功状态值为200
	//TTDASSERT([[[feed objectForKey:@"result"] objectForKey:@"lists"] isKindOfClass:[NSArray class]]);
	
	NSArray* entries = [feed objectForKey:@"OutputTable"] ;
	//NSLog(@"OutputTable %@",[entries objectAtIndex:0] );
	[self.items addObjectsFromArray:entries];
	_finished = entries.count < [_resultsPerPage intValue];
	//NSLog(@"items %d",[self.items count]);
	[super requestDidFinishLoad:request];
}


@end
