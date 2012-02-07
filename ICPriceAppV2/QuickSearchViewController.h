//
//  QuickSearchViewController.h
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  快查
#import "BaseTabBarController.h"
@class ASIFormDataRequest;
@interface QuickSearchViewController : BaseTabBarController<UITabBarDelegate,UISearchBarDelegate>{
    UITabBar *_tabBars;
    ASIFormDataRequest *asiRequest;
}

@end
