//
//  StockListModel.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "StockListModel.h"
#import <extThree20JSON/extThree20JSON.h>
#import "JSONKit.h"
#import "User.h"
@implementation StockListModel

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
                             @"instock.vwStock",
                             [NSString stringWithFormat:@"%d",_page],
                             @"15",
                             @"ID,型号,数量,进价,售价,批号,芯片状态,厂牌,pckpins,备注,日期,图",
                             @"ID desc",
                             [NSString stringWithFormat:@"型号 like '%@%%' and 公司ID=%@",
                              [kAppDelegate.temporaryValues objectForKey:@"stockType"],
                              kAppDelegate.user.companyId],@"ID",@"1",nil] forKey:@"Values"];
    
    NSLog(@"value %@",operationData);
    
    [request.parameters  setValue:@"PRC" forKey:@"OperationCode"];
    [request.parameters  setValue:[operationData JSONString] forKey:@"OperationData"];
    
    TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
	request.response = response;
	TT_RELEASE_SAFELY(response);
	
	[request send];
}

@end
