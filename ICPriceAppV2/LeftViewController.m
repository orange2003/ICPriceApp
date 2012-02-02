//
//  LeftViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LeftViewController.h"
#import "IIViewDeckController.h"
#import "TypeSearchViewController.h"
#import "TypeSearchDataSource.h"
#import "CMPopTipView.h"
#import "LeftViewDataSource.h"
#import "TypeSearchModel.h"
#import "User.h"
#import "PhotoUpViewController.h"
#import "UIImage+Scaled.h"
@interface LeftViewController()
- (void)setSearchIconToFavicon ;
@end
@implementation LeftViewController

-(void)dealloc{
    TT_RELEASE_SAFELY(_popTipView);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _typeFlag = 0;
	}
	return self;
}

-(void) viewDidUnload{
	[kAppDelegate removeControllers];
	[super viewDidUnload];
}


-(void)loadView{
    [super loadView];
    UIView * _custView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 140)];
    UIButton *_typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_typeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [_typeButton setTitle:@"快查" forState:UIControlStateNormal];
    _typeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_typeButton addTarget:self action:@selector(typeAction:) forControlEvents:UIControlEventTouchUpInside];
    _typeButton.frame = CGRectMake(0, 0, 100, 25);
    [_custView addSubview:_typeButton];
    
    UIButton *_picButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_picButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [_picButton setTitle:@"图片" forState:UIControlStateNormal];
     _picButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_picButton addTarget:self action:@selector(typeAction:) forControlEvents:UIControlEventTouchUpInside];
    _picButton.frame = CGRectMake(0, 40, 100, 25);
    [_custView addSubview:_picButton];
    
    
    UIButton *_stockButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_stockButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [_stockButton setTitle:@"现货库存" forState:UIControlStateNormal];
    _stockButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_stockButton addTarget:self action:@selector(typeAction:) forControlEvents:UIControlEventTouchUpInside];
    _stockButton.frame = CGRectMake(0, 80, 100, 25);
    [_custView addSubview:_stockButton];
    
    UIButton *_saleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_saleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [_saleButton setTitle:@"订单" forState:UIControlStateNormal];
    _saleButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_saleButton addTarget:self action:@selector(typeAction:) forControlEvents:UIControlEventTouchUpInside];
    _saleButton.frame = CGRectMake(0, 120, 100, 25);
    [_custView addSubview:_saleButton];
    
    
    _popTipView = [[CMPopTipView alloc] initWithCustomView:_custView];
    _popTipView.alpha = 0.0;
    [_custView release];
    _popTipView.backgroundColor = RGBACOLOR(0, 0, 0, 0.1);
    
    self.dataSource = [LeftViewDataSource dataSourceWithObjects:
                       [TTTableTextItem itemWithText:@"询价报价"],
                       [TTTableTextItem itemWithText:@"现货库存"],
                       [TTTableTextItem itemWithText:@"销售订单"],
                       [TTTableTextItem itemWithText:@"照片上传"],
                       [TTTableTextItem itemWithText:@"条码扫描"],
                       [TTTableTextItem itemWithText:[NSString stringWithFormat:@"%@ 登出",kAppDelegate.user.name]],nil];
    
    self.searchViewController = [[[TypeSearchViewController alloc] init] autorelease];

	self.searchViewController.dataSource = [[[TypeSearchDataSource alloc] init] autorelease];
	_searchController.searchBar.delegate = self;
    
    _searchController.searchBar.tintColor = [UIColor grayColor];
    self.tableView.tableHeaderView = _searchController.searchBar;
    if (_typeFlag==0) {
        _searchController.searchBar.placeholder = @"请输入型号 快查";
    }else if (_typeFlag==1){
        _searchController.searchBar.placeholder = @"请输入型号 图片";
    }else if (_typeFlag==2){
        _searchController.searchBar.placeholder = @"请输入型号 现货库存";
    }else if (_typeFlag==3){
        _searchController.searchBar.placeholder = @"请输入型号 订单";
    }
	
    
    [self setSearchIconToFavicon];
}

-(void)typeAction:(id)sender{
    if ([[((UIButton*)sender) titleForState:UIControlStateNormal] isEqualToString:@"快查"]) {
        _searchController.searchBar.placeholder = @"请输入型号 快查";
        _typeFlag = 0;
    }else if ([[((UIButton*)sender) titleForState:UIControlStateNormal] isEqualToString:@"图片"]) {
        _searchController.searchBar.placeholder = @"请输入型号 图片";
        _typeFlag = 1;
    }else if ([[((UIButton*)sender) titleForState:UIControlStateNormal] isEqualToString:@"现货库存"]) {
        _searchController.searchBar.placeholder = @"请输入型号 现货库存";
        _typeFlag = 2;
    }else if ([[((UIButton*)sender) titleForState:UIControlStateNormal] isEqualToString:@"订单"]) {
        _searchController.searchBar.placeholder = @"请输入型号 订单";
        _typeFlag = 3;
    }
    [_popTipView dismissAnimated:YES];
}

-(void)picAction{
    _searchController.searchBar.placeholder = @"请输入型号 图片";
    _typeFlag = 1;
    [_popTipView dismissAnimated:YES];
    
}

- (void)setSearchIconToFavicon {
    // Really a UISearchBarTextField, but the header is private.
    UITextField *searchField = nil;
    for (UIView *subview in _searchController.searchBar.subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            searchField = (UITextField *)subview;
            break;
        }
    }
    
    if (searchField) {  
        
        UIButton * _leftView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftView setImage:TTIMAGE(@"bundle://SearchMenuIcon.png") forState:UIControlStateNormal];
        _leftView.frame = CGRectMake(0, 0, 46, 26);
        [_leftView addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
        searchField.leftView = _leftView;
        //[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://SearchMenuIcon.png") ];
    }  
}

-(void)changeType:(id)sender{
    if (_popTipView.alpha==0) {
        [_popTipView presentPointingAtView:sender inView:self.view animated:YES];
    }else{
        [_popTipView dismissAnimated:YES];
    }
    
    
}


-(BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [_popTipView dismissAnimated:YES];
    self.viewDeckController.leftLedge = -10;
    //[self performSelector:@selector(setTexts) withObject:nil afterDelay:0.0];
    return  YES;
}

-(void)setTexts{
    _searchController.searchBar.text = @" ";
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [_popTipView dismissAnimated:YES];
	 self.viewDeckController.leftLedge = 44;
}

-(BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [_popTipView dismissAnimated:YES];
    if (searchBar.text.length<=0) {
        self.viewDeckController.leftLedge = 44;
    }
	return YES;
}

-(void)typeSelect:(NSString*)text{
    [kAppDelegate.temporaryValues setObject:text
                                     forKey:@"selectType"];
    
    [_searchController setActive:NO animated:NO ];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *_temps = [NSMutableArray arrayWithArray:[defaults objectForKey:@"searchHistory"]];
    if ([_temps count]==10) {
        [_temps removeLastObject];
        [_temps insertObject:text atIndex:0];
    }else{
        [_temps insertObject:text atIndex:0];
    }
   // NSLog(@"count %d",[_temps count]);
    [defaults setObject:_temps forKey:@"searchHistory"];
    [defaults synchronize];
    
    if (_typeFlag==0) {//快查
        [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
            [kAppDelegate.temporaryValues setObject:@"0" forKey:@"beginDragging"];
            controller.centerController = 
            [[[UINavigationController alloc] 
              initWithRootViewController:[kAppDelegate loadFromVC:@"TopQuickSearchViewController"]] 
             autorelease];
            [NSThread sleepForTimeInterval:(300+arc4random()%700)/1000000.0];
        }];
    }else if(_typeFlag==1){//图片
        [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
            [kAppDelegate.temporaryValues setObject:@"0" forKey:@"beginDragging"];
            controller.centerController = 
            [[[UINavigationController alloc] 
              initWithRootViewController:[kAppDelegate loadFromVC:@"PicListViewController"]] 
             autorelease];
            [NSThread sleepForTimeInterval:(300+arc4random()%700)/1000000.0];
        }];
    }else if(_typeFlag==2){//现货库存
        [kAppDelegate.temporaryValues setObject:text forKey:@"stockType"];
        
        [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
            [kAppDelegate.temporaryValues setObject:@"0" forKey:@"beginDragging"];
            controller.centerController = 
            [[[UINavigationController alloc] 
              initWithRootViewController:[kAppDelegate loadFromVC:@"StockListViewController"]] 
             autorelease];
            [NSThread sleepForTimeInterval:(300+arc4random()%700)/1000000.0];
        }];
    }else if(_typeFlag==3){//订单
        [kAppDelegate.temporaryValues setObject:text forKey:@"salesType"];
        [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
            [kAppDelegate.temporaryValues setObject:@"0" forKey:@"beginDragging"];
            controller.centerController = 
            [[[UINavigationController alloc] 
              initWithRootViewController:[kAppDelegate loadFromVC:@"SalesListViewController"]] 
             autorelease];
            [NSThread sleepForTimeInterval:(300+arc4random()%700)/1000000.0];
        }];
    }

}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_popTipView dismissAnimated:YES];
    [kAppDelegate.temporaryValues setObject:@"%"forKey:@"stockType"];
    [kAppDelegate.temporaryValues setObject:@"" forKey:@"salesType"];
    if ([[((TTTableTextItem*)object).text componentsSeparatedByString:@" "] count]>1) {
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"name"];
        [defaults removeObjectForKey:@"pass"];
        [defaults synchronize];
        [self.viewDeckController dismissModalViewControllerAnimated:YES];
        [kAppDelegate removeControllers];
        return;
    }else if([((TTTableTextItem*)object).text isEqualToString:@"照片上传"]){
        [kAppDelegate.temporaryValues setObject:@"0" forKey:@"picType"];
        [kAppDelegate.temporaryValues setObject:@"" forKey:@"picRid"];
        [self.viewDeckController photoUp];
    }else if([((TTTableTextItem*)object).text isEqualToString:@"条码扫描"]){
        [self.viewDeckController 
         presentModalViewController:[[[UINavigationController alloc] 
                                      initWithRootViewController:[kAppDelegate loadFromNib:@"EmbedReaderViewController"] ] 
                                     autorelease]
         animated:YES];
        
    }else{
        [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
            [kAppDelegate.temporaryValues setObject:@"0" forKey:@"beginDragging"];
            controller.centerController =[kAppDelegate.contollers objectAtIndex:indexPath.row];
            [NSThread sleepForTimeInterval:(300+arc4random()%700)/1000000.0];
        }];
        return;
    }
}


@end
