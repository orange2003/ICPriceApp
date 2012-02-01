//
//  SupplierSearchModel.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SupplierSearchModel.h"
#import "ASIFormDataRequest.h"
#import "User.h"
#import "JSONKit.h"
@implementation SupplierSearchModel
@synthesize asiRequest;


- (void)search:(NSString*)text {
	[self cancel];
	
	if (text.length) {
		if (asiRequest) {
			[self.asiRequest cancel];
			[self.asiRequest clearDelegatesAndCancel];
			TT_RELEASE_SAFELY(asiRequest);
		} 
		//[_delegates perform:@selector(modelDidStartLoad:) withObject:self];
		[self typeSearch:text];
		
	} else {
		TT_RELEASE_SAFELY(_items);
		//[_delegates perform:@selector(modelDidChange:) withObject:self];
	}
	
}

-(void)typeSearch:(NSString*)text{

    self.asiRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kRESTBaseUrl]];
    NSMutableDictionary *operationData = [NSMutableDictionary dictionary];

    [operationData setValue:@"up_autoComplete2" forKey:@"ObjectName"];
    [operationData setValue:[NSArray arrayWithObjects:text,@"10",kAppDelegate.user.companyId,
                             kAppDelegate.user.ider,@"1",@"0",nil] 
                     forKey:@"Values"];
    
    [self.asiRequest setPostValue:@"PRC" forKey:@"OperationCode"];
    [self.asiRequest setPostValue:[operationData JSONString] forKey:@"OperationData"];
    
	[self.asiRequest setRequestMethod:@"POST"];
    [self.asiRequest setDelegate:self];
    self.asiRequest.didFinishSelector = @selector(finishPoview:);
    self.asiRequest.didFailSelector = @selector(finishFail:);
	[self.asiRequest startAsynchronous];

}

-(void)finishFail:(ASIHTTPRequest *)request{
	//NSLog(@"request Fail");
	TT_RELEASE_SAFELY(asiRequest);
	[_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
}

-(void)finishPoview:(ASIHTTPRequest *)requests{
    NSDictionary *data =[[JSONDecoder decoder] objectWithData:[requests responseData]];
   // NSLog(@"data %@",data);
    
    self.items = [data objectForKey:@"OutputTable"];
    [_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
    
}




-(NSString *)urlString:(NSString *)value{
	return (NSString *)CFURLCreateStringByAddingPercentEscapes(
															   NULL,
															   (CFStringRef)value,
															   NULL,
															   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
															   kCFStringEncodingUTF8 );
}

@end
