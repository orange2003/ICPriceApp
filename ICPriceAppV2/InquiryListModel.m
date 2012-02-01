//
//  InquiryListModel.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InquiryListModel.h"
#import <extThree20JSON/extThree20JSON.h>
#import "User.h"
#import "JSONKit.h"
@implementation InquiryListModel

-(void)generateRequest:(TTURLRequestCachePolicy)cachePolicy{
    TTURLRequest* request = [TTURLRequest
							 requestWithURL:kRESTBaseUrl
							 delegate: self];
    
    request.httpMethod =@"POST";
    request.cachePolicy = TTURLRequestCachePolicyNone;
	request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
    
    NSMutableDictionary *operationData = [NSMutableDictionary dictionary];
    
    [operationData setValue:@"up_iphone_getMyRfqForCaigou" forKey:@"ObjectName"];
    [operationData setValue:[NSArray arrayWithObject:kAppDelegate.user.ider] forKey:@"Values"];
    
    [request.parameters  setValue:@"PRC" forKey:@"OperationCode"];
    [request.parameters  setValue:[operationData JSONString] forKey:@"OperationData"];
    
    TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
	request.response = response;
	TT_RELEASE_SAFELY(response);
	
	[request send];
}

@end
