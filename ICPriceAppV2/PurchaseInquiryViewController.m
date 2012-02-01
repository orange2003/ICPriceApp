//
//  PurchaseInquiryViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PurchaseInquiryViewController.h"
#import "PurchaseInquiryDataSource.h"
#import "Inquiry.h"
#import "QuickSearchDelegate.h"
@implementation PurchaseInquiryViewController

-(void)loadView{
    [super loadView];
    self.dataSource = [[[PurchaseInquiryDataSource alloc] init] autorelease];
}


-(id <UITableViewDelegate>) createDelegate{
	return [[[QuickSearchDelegate alloc] initWithController:self] autorelease];
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSLog(@"userinfo %@",((TTTableTextItem*)object).userInfo);
    //ID,型号,数量,cusPrice,批号,chipstate,供货商助记,suId,cuNote,平台,采购,日期, suPrice,suPtId,parentId
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).supplier = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)object).userInfo objectAtIndex:7]];
    
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).supplierName = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)object).userInfo objectAtIndex:6]];
    
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).platform = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)object).userInfo objectAtIndex:13]];
    
    [self.contentController.navigationController pushViewController:[kAppDelegate loadFromVC:@"InquiryUpdataController"] 
                                                           animated:YES];
    
}

@end
