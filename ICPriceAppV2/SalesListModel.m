//
//  OrderListModel.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SalesListModel.h"
#import <extThree20JSON/extThree20JSON.h>
#import "JSONKit.h"
#import "User.h"
@implementation SalesListModel

-(void)generateRequest:(TTURLRequestCachePolicy)cachePolicy{
    TTURLRequest* request = [TTURLRequest
							 requestWithURL:kRESTBaseUrl
							 delegate: self];
    
    request.httpMethod =@"POST";
    request.cachePolicy = TTURLRequestCachePolicyNone;
	request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
    
    NSMutableDictionary *operationData = [NSMutableDictionary dictionary];
    
    [operationData setValue:@"up_iphone_getSoPn" forKey:@"ObjectName"];
    [operationData setValue:[NSArray arrayWithObjects:
                             [kAppDelegate.temporaryValues objectForKey:@"salesType"],
                             kAppDelegate.user.ider,nil] forKey:@"Values"];
    
   // NSLog(@"value %@",operationData);
    
    [request.parameters  setValue:@"PRC" forKey:@"OperationCode"];
    [request.parameters  setValue:[operationData JSONString] forKey:@"OperationData"];
    
    TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
	request.response = response;
	TT_RELEASE_SAFELY(response);
	
	[request send];
}

@end
