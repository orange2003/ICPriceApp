//
//  BaseMenuController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseTabBarController.h"

@implementation BaseTabBarController
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize contentContainerView;


-(void)loadView{
    [super loadView];
    //初始化切页视图
    _selectedIndex = NSNotFound;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, 415);
    contentContainerView = [[UIView alloc] initWithFrame:rect];
	contentContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:contentContainerView];
    self.dataSource = [TTListDataSource dataSourceWithObjects:[TTTableTextItem itemWithText:@""],nil];
    [contentContainerView release];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.selectedViewController) {
        [self.selectedViewController viewWillAppear:animated];
    }
}

- (void)setViewControllers:(NSArray *)newViewControllers{
    NSAssert([newViewControllers count] >= 2, @"MHTabBarController requires at least two view controllers");
    
	UIViewController *oldSelectedViewController = self.selectedViewController;
    
	// Remove the old child view controllers.
	for (UIViewController *viewController in _viewControllers)
	{
		//[viewController willMoveToParentViewController:nil];
		//[viewController removeFromParentViewController];
	}
    
	_viewControllers = [newViewControllers copy];
    
	// This follows the same rules as UITabBarController for trying to
	// re-select the previously selected view controller.
	NSUInteger newIndex = [_viewControllers indexOfObject:oldSelectedViewController];
	if (newIndex != NSNotFound)
		_selectedIndex = newIndex;
	else if (newIndex < [_viewControllers count])
		_selectedIndex = newIndex;
	else
		_selectedIndex = 0;
    
	// Add the new child view controllers.
	for (UIViewController *viewController in _viewControllers)
	{
		//[self addChildViewController:viewController];
		//[viewController didMoveToParentViewController:self];
	}
    
	NSUInteger lastIndex = 0;
	_selectedIndex = NSNotFound;
	self.selectedIndex = lastIndex;
}

- (void)reloadTabButtons
{
	// Force redraw of the previously active tab.
	NSUInteger lastIndex = _selectedIndex;
	_selectedIndex = NSNotFound;
	self.selectedIndex = lastIndex;
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex
{
	NSAssert(newSelectedIndex < [self.viewControllers count], @"View controller index out of bounds");
	if (![self isViewLoaded])
	{
		_selectedIndex = newSelectedIndex;
	}
	else if (_selectedIndex != newSelectedIndex)
	{
		UIViewController *fromViewController=nil;
		UIViewController *toViewController=nil;
        
		if (_selectedIndex != NSNotFound)
		{
			fromViewController = self.selectedViewController;
		}
        
		NSUInteger oldSelectedIndex = _selectedIndex;
		_selectedIndex = newSelectedIndex;
        
		if (_selectedIndex != NSNotFound)
		{
			toViewController = self.selectedViewController;
		}
        
		if (toViewController == nil)  // don't animate
		{
			[fromViewController.view removeFromSuperview];
		}
		else if (fromViewController == nil)  // don't animate
		{
			toViewController.view.frame = contentContainerView.bounds;
			[contentContainerView addSubview:toViewController.view];
            [toViewController viewWillAppear:YES];
            [toViewController viewDidAppear:YES];
		}
		else
		{
			CGRect rect = contentContainerView.bounds;
			if (oldSelectedIndex < newSelectedIndex)
				rect.origin.x = rect.size.width;
			else
				rect.origin.x = -rect.size.width;
            
			toViewController.view.frame = rect;
            [contentContainerView addSubview:toViewController.view];
            [toViewController viewWillAppear:YES];
            [UIView animateWithDuration:0.3 
                                  delay:0.0 
                                options:UIViewAnimationOptionLayoutSubviews 
                             animations:^{
                                 CGRect rects = fromViewController.view.frame;
                                 if (oldSelectedIndex < newSelectedIndex)
                                     rects.origin.x = -rects.size.width;
                                 else
                                     rects.origin.x = rects.size.width;
                                 
                                 fromViewController.view.frame = rects;
                                 toViewController.view.frame = contentContainerView.bounds;
                             } completion:^(BOOL finished){
                                 [fromViewController.view removeFromSuperview];
                                 [toViewController viewDidAppear:YES];
                             }];
		}
	}
}

- (UIViewController *)selectedViewController
{
	if (self.selectedIndex != NSNotFound)
		return [self.viewControllers objectAtIndex:self.selectedIndex];
	else
		return nil;
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController
{
	NSUInteger index = [self.viewControllers indexOfObject:newSelectedViewController];
	if (index != NSNotFound)
		self.selectedIndex = index;
}


@end
