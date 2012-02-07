//
//  RealtimeViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RealtimeViewController.h"
#import "RealtimeDataSource.h"
#import "Inquiry.h"
#import "QuickSearchDelegate.h"
@implementation RealtimeViewController

-(void)loadView{
    [super loadView];
    self.dataSource = [[[RealtimeDataSource alloc] init] autorelease];
}

-(id <UITableViewDelegate>) createDelegate{
	return [[[QuickSearchDelegate alloc] initWithController:self] autorelease];
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[kAppDelegate.temporaryValues objectForKey:@"quickType"] isEqualToString:@"3"])
        return;
   // NSLog(@"userinfo %@",((TTTableTextItem*)object).userInfo);
    //ID,型号,数量,厂牌,批号,封装,说明,供货商ID,日期,供货商,助记名,简址,星级,库存真实性,标志,来自ID,平台ID
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).supplier = [((TTTableTextItem*)object).userInfo objectAtIndex:7];
    
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).supplierName = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)object).userInfo objectAtIndex:10]];
    
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).platform = [((TTTableTextItem*)object).userInfo objectAtIndex:16];
    
    ((Inquiry*)[kAppDelegate.temporaryValues 
                objectForKey:@"inquiry"]).batch = [NSString stringWithFormat:@"%@",[((TTTableTextItem*)object).userInfo objectAtIndex:4]];
    
    if ([[kAppDelegate.temporaryValues objectForKey:@"quickType"] isEqualToString:@"0"]) {
        [self.contentController.navigationController pushViewController:[kAppDelegate loadFromVC:@"InquiryUpdataController"] 
                                                               animated:YES];
    }else if([[kAppDelegate.temporaryValues objectForKey:@"quickType"] isEqualToString:@"1"]){
        [self.contentController.navigationController pushViewController:[kAppDelegate loadFromVC:@"QuoteUpdataViewController"] 
                                                               animated:YES];
    }
    
}


@end
