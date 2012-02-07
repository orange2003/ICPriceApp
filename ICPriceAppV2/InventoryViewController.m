//
//  InventoryViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InventoryViewController.h"
#import "InventoryDataSource.h"
#import "Inquiry.h"
#import "QuickSearchDelegate.h"
@implementation InventoryViewController

-(void)loadView{
    [super loadView];
    self.dataSource = [[[InventoryDataSource alloc] init] autorelease];
}

-(id <UITableViewDelegate>) createDelegate{
	return [[[QuickSearchDelegate alloc] initWithController:self] autorelease];
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[kAppDelegate.temporaryValues objectForKey:@"quickType"] isEqualToString:@"3"])
        return;
    //ID,图,公司ID,型号,数量,售价,批号,芯片状态,厂牌,pckpins,助记名,日期,平台ID
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).supplier = [((TTTableTextItem*)object).userInfo objectAtIndex:2];
    
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).supplierName = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)object).userInfo objectAtIndex:10]];
    
    
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).platform = [((TTTableTextItem*)object).userInfo objectAtIndex:12];
    
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).batch = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)object).userInfo objectAtIndex:6]];
    
    
    if ([[kAppDelegate.temporaryValues objectForKey:@"quickType"] isEqualToString:@"0"]) {
        [self.contentController.navigationController pushViewController:[kAppDelegate loadFromVC:@"InquiryUpdataController"] 
                                                               animated:YES];
    }else if([[kAppDelegate.temporaryValues objectForKey:@"quickType"] isEqualToString:@"1"]){
        [self.contentController.navigationController pushViewController:[kAppDelegate loadFromVC:@"QuoteUpdataViewController"] 
                                                               animated:YES];
    }
    
}

@end
