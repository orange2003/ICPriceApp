//
//  PurchaseInquiryModel.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PurchaseInquiryModel.h"
#import <extThree20JSON/extThree20JSON.h>
#import "JSONKit.h"
#import "User.h"
@implementation PurchaseInquiryModel

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
                             @"rfq.bodyCu_iphone",
                             [NSString stringWithFormat:@"%d",_page],
                             @"15",
                             @"ID,型号,数量,cusPrice,批号,chipstate,芯片状态ID,供货商助记,suId,cuNote,平台,采购,日期,suPrice,suPtId,parentId",
                             @"ID desc",
                             [NSString stringWithFormat:@"型号 like '%@%%' and 公司ID=%@",
                              [kAppDelegate.temporaryValues objectForKey:@"selectType"],
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
