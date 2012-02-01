//
//  SellQuoteModel.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SellQuoteModel.h"
#import <extThree20JSON/extThree20JSON.h>
#import "JSONKit.h"
#import "User.h"
@implementation SellQuoteModel


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
                             @"rfq.bodySu_vw",
                             [NSString stringWithFormat:@"%d",_page],
                             @"15",
                             @"ID,型号,数量,suPrice,批号,厂牌,suNote,客户助记,平台,日期,销售",
                             @"ID desc",
                             [NSString stringWithFormat:@"型号 like '%@%%' and 公司ID=%@",
                              [kAppDelegate.temporaryValues objectForKey:@"selectType"],
                              kAppDelegate.user.companyId],@"ID",@"1",nil] forKey:@"Values"];
    
   // NSLog(@"value %@",operationData);
    
    [request.parameters  setValue:@"PRC" forKey:@"OperationCode"];
    [request.parameters  setValue:[operationData JSONString] forKey:@"OperationData"];
    
    TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
	request.response = response;
	TT_RELEASE_SAFELY(response);
	
	[request send];
}

@end
