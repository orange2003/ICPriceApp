//
//  ViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "IIViewDeckController.h"
#import "QuoteInquiryListDelegate.h"

@implementation ViewController

-(void)dealloc{
    TT_RELEASE_SAFELY(_timeScroller);
    [super dealloc];
}

-(void)viewDidUnload{
    TT_RELEASE_SAFELY(_timeScroller);
}

-(void)loadView{
    [super loadView];
    
    UIBarButtonItem *_menu = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    self.navigationItem.leftBarButtonItem = _menu;
    
    self.title = @"测试";
    //[self timeScroller];
    
    
    NSMutableArray *_items = [NSMutableArray new];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSDate *today = [NSDate date];
    NSDateComponents *todayComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    
    for (int i = todayComponents.day; i >= -15; i--) {
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        components.year = todayComponents.year;
        components.month = todayComponents.month;
        components.day = i;
        components.hour = arc4random() % 23;
        components.minute = arc4random() % 59;
        
        NSDate *date = [calendar dateFromComponents:components];
        [dictionary setObject:date forKey:@"date"];
        
        TTTableTextItem * _item = [TTTableTextItem itemWithText:@"测试记录"];
        _item.userInfo = dictionary;
        [_items addObject:_item];
    }
    
    [components release];
    
    self.dataSource = [TTListDataSource dataSourceWithItems:_items];
}

- (UITableView *)tableViewForTimeScroller:(TimeScroller *)timeScroller {
    
    return _tableView;
    
}


//You should return an NSDate related to the UITableViewCell given. This will be
//the date displayed when the TimeScroller is above that cell.
- (NSDate *)dateForCell:(UITableViewCell *)cell {
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    
    NSDate *date = [((TTTableTextItem*)[((TTListDataSource*)self.dataSource).items 
                                        objectAtIndex:indexPath.row]).userInfo 
                    objectForKey:@"date"];
    
    return date;
    
}

-(TimeScroller *)timeScroller{
    if (!_timeScroller) {
        _timeScroller = [[TimeScroller alloc] initWithDelegate:self];
    }
    return _timeScroller;
}


//-(id <UITableViewDelegate>) createDelegate{
//	return [[[QuoteInquiryListDelegate alloc] initWithController:self] autorelease];
//}
	
    
@end
