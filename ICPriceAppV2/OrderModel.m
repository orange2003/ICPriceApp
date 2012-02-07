//
//  OrderModel.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderModel.h"
#import <extThree20JSON/extThree20JSON.h>
#import "JSONKit.h"
#import "User.h"
@implementation OrderModel

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
                             @"po.BodyHead_iphone",
                             [NSString stringWithFormat:@"%d",_page],
                             @"15",
                             @"ID,型号,type,数量,货币符号,售价,批号,厂牌,pckpins,芯片状态,cusName,cuOrderNote,suOrderNote,commonNote,日期,作者,平台,客户平台,cuPtId,平台ID,客户ID,suId,销售ID,采购ID,状态ID",
                             @"ID desc",
                             [NSString stringWithFormat:@"型号 like '%@%%' and (客户ID=%@ or suid=%@)",
                              [kAppDelegate.temporaryValues objectForKey:@"selectType"],
                              kAppDelegate.user.companyId,kAppDelegate.user.companyId],@"ID",@"1",nil] forKey:@"Values"];
    
    // NSLog(@"value %@",operationData);
    
    [request.parameters  setValue:@"PRC" forKey:@"OperationCode"];
    [request.parameters  setValue:[operationData JSONString] forKey:@"OperationData"];
    
    TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
	request.response = response;
	TT_RELEASE_SAFELY(response);
	
	[request send];
}

@end
