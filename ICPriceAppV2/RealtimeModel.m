//
//  RealtimeModel.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RealtimeModel.h"
#import <extThree20JSON/extThree20JSON.h>
#import "JSONKit.h"
@implementation RealtimeModel

-(void)generateRequest:(TTURLRequestCachePolicy)cachePolicy{
    TTURLRequest* request = [TTURLRequest
							 requestWithURL:kRESTBaseUrl
							 delegate: self];
    
    request.httpMethod =@"POST";
    request.cachePolicy = TTURLRequestCachePolicyNone;
	request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
    
    NSMutableDictionary *operationData = [NSMutableDictionary dictionary];
    
    [operationData setValue:@"up_PageView" forKey:@"ObjectName"];
    [operationData setValue:[NSArray arrayWithObjects:
                             @"live.vwStock",
                             [NSString stringWithFormat:@"%d",_page],
                             @"15",
                             @"ID,型号,数量,厂牌,批号,封装,说明,供货商ID,日期,供货商,助记名,简址,星级,库存真实性,标志,来自ID,平台ID",
                             @"ID desc",
                             [NSString stringWithFormat:@"型号 like '%@%%' ",
                              [kAppDelegate.temporaryValues objectForKey:@"selectType"]],@"ID",@"1",nil] forKey:@"Values"];
    
    [operationData setValue:@"2" forKey:@"ConType"];
    //NSLog(@"value %@",operationData);
    
    [request.parameters  setValue:@"PRC" forKey:@"OperationCode"];
    [request.parameters  setValue:[operationData JSONString] forKey:@"OperationData"];
    
    TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
	request.response = response;
	TT_RELEASE_SAFELY(response);
	
	[request send];
}

@end
