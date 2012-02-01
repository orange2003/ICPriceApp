//
//  AppDelegate.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MyIIViewDeckController.h"
@interface AppDelegate()
-(UIViewController*)loadViewDeck:(NSString*)centerViewController;
@end

@interface MyStyleSheet : TTDefaultStyleSheet
@end

@implementation MyStyleSheet

- (TTStyle*)loginButton:(UIControlState)state {
	TTShape* shape = [TTRoundedRectangleShape shapeWithRadius:5];
	UIColor* tintColor = RGBCOLOR(0, 129, 255);
	return [TTSTYLESHEET toolbarButtonForState:state shape:shape 
									 tintColor:tintColor font:[UIFont boldSystemFontOfSize:17]];
}

- (TTStyle*)blackForwardButton:(UIControlState)state {
    TTShape* shape = [TTRoundedRightArrowShape shapeWithRadius:4.5];
    UIColor* tintColor = RGBCOLOR(0, 0, 0);
    return [TTSTYLESHEET toolbarButtonForState:state shape:shape tintColor:tintColor font:nil];
}


@end

@implementation AppDelegate

static UIAlertView *sAlert = nil;
@synthesize temporaryValues = _temporaryValues;
@synthesize window = _window;
@synthesize user = _user;
@synthesize constants;
@synthesize baths;

-(void) dealloc{
	[TTStyleSheet setGlobalStyleSheet:nil];
	TT_RELEASE_SAFELY(_temporaryValues);
    TT_RELEASE_SAFELY(_contollers);
    TT_RELEASE_SAFELY(_user);
    TT_RELEASE_SAFELY(constants);
    TT_RELEASE_SAFELY(baths);
	[super dealloc];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
   NSMutableDictionary *tDic = [[NSMutableDictionary alloc] init];
	self.temporaryValues = tDic;
	[tDic release]; 
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"searchHistory"]) {
        [defaults setObject:[NSMutableArray array] forKey:@"searchHistory"];
        [defaults synchronize];
    }
    
    [self.temporaryValues setObject:@"%" forKey:@"stockType"];
    [self.temporaryValues setObject:@"" forKey:@"salesType"];
    
	[TTStyleSheet setGlobalStyleSheet:[[[MyStyleSheet alloc] init] autorelease]];
	TTURLMap* map = self.navigator.URLMap;
  	[map from:@"tt://nib/(loadFromNib:)" toSharedViewController:self];
	[map from:@"tt://nib/(loadFromNib:)/(withClass:)" toSharedViewController:self];
	[map from:@"tt://viewController/(loadFromVC:)" toSharedViewController:self];
	[map from:@"tt://modal/viewController/(loadFromVC:)" toModalViewController:self];
	[map from:@"tt://modal/(loadFromNib:)" toModalViewController:self];
    [map from:@"tt://viewDeck/(loadViewDeck:)" toSharedViewController:self];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [self loadFromVC:@"UserLoginViewController"];
    [self.window makeKeyAndVisible];

}

-(UIViewController*)loadViewDeck:(NSString*)centerViewController{
    MyIIViewDeckController * viewDeck =  [[[MyIIViewDeckController alloc] 
                                         initWithCenterViewController:[self.contollers objectAtIndex:0]
                                         leftViewController:[[ NSClassFromString(@"LeftViewController") alloc] init]               rightViewController:nil] autorelease];
    viewDeck.panningMode = IIViewDeckNavigationBarPanning;
	return viewDeck;
}

-(NSMutableArray *)contollers{
    if (!_contollers) {
        _contollers = [[NSMutableArray alloc] initWithObjects:[[[UINavigationController alloc] 
                                                                initWithRootViewController:[self loadFromVC:@"QuoteInquiryListController"]] 
                                                               autorelease],
                       [[[UINavigationController alloc] 
                         initWithRootViewController:[self loadFromVC:@"StockListViewController"]] 
                        autorelease],
                       [[[UINavigationController alloc] 
                         initWithRootViewController:[self loadFromVC:@"SalesListViewController"]] 
                        autorelease],
                       nil];
    }
    return _contollers;
}


-(void)removeControllers{
    TT_RELEASE_SAFELY(_contollers);
}

-(TTNavigator*)navigator{
	if (!_navigator) {
		_navigator = [TTNavigator navigator];
		_navigator.persistenceMode = TTNavigatorPersistenceModeNone;
		_navigator.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
	}
	return _navigator;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Loads the given viewcontroller from the nib
 */
- (UIViewController*)loadFromNib:(NSString *)nibName withClass:className {
	UIViewController* newController = [[NSClassFromString(className) alloc]
									   initWithNibName:nibName bundle:nil];
	[newController autorelease];
	
	return newController;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Loads the given viewcontroller from the the nib with the same name as the
 * class
 */
- (UIViewController*)loadFromNib:(NSString*)className {
	return [self loadFromNib:className withClass:className];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Loads the given viewcontroller by name
 */
- (UIViewController *)loadFromVC:(NSString *)className {
	UIViewController * newController = [[ NSClassFromString(className) alloc] init];
	[newController autorelease];
	return newController;
}

- (void)alert:(NSString*)title message:(NSString*)message
{
    if (sAlert) return;
    
    sAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(title,@"")
                                        message:NSLocalizedString(message,@"")
									   delegate:self
							  cancelButtonTitle:@"关闭"
							  otherButtonTitles:nil];
    [sAlert show];
    [sAlert release];
	sAlert = nil;
}

-(MBProgressHUD *) HUD{
	if (!_HUD) {
		_HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
		_HUD.animationType = MBProgressHUDAnimationZoom;
		_HUD.delegate = self;
		[[[UIApplication sharedApplication] keyWindow] addSubview:_HUD];
	}
	return _HUD;
}

-(void)HUDShow:(NSString*)labelText yOffset:(NSString*)yOffset{
	TT_RELEASE_SAFELY(_HUD);
	self.HUD.labelText = labelText;
	self.HUD.yOffset = [yOffset floatValue];
	[self.HUD show:YES];
}

-(void)HUDHide{
	[self.HUD hide:YES];
}

-(void)showWithLabelDeterminate:(NSString *)labelText{
    TT_RELEASE_SAFELY(_HUD);
    self.HUD.mode = MBProgressHUDModeDeterminate;
	self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.labelText = labelText;
    self.HUD.yOffset = -90;
    [self.HUD show:YES];
}

- (void)showWithTextView:(NSString *)labelText {
    TT_RELEASE_SAFELY(_HUD);
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	self.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkMarkLogo.png"]] autorelease];
	
    // Set custom view mode
    self.HUD.mode = MBProgressHUDModeCustomView;
	self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.labelText = labelText;
    self.HUD.detailsLabelText = @"或者邮箱地址,方便联系,谢谢!";
    self.HUD.labelFont = [UIFont systemFontOfSize:13];
	self.HUD.yOffset = -90;
    
    [self.HUD show:YES];
	[self.HUD hide:YES afterDelay:2.5];
	[self.HUD performSelector:@selector(setMode:)
				   withObject:MBProgressHUDModeIndeterminate
				   afterDelay:2.6];
}

- (void)showWithCustomView:(NSString*)labelText {
	TT_RELEASE_SAFELY(_HUD);
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	self.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	
    // Set custom view mode
    self.HUD.mode = MBProgressHUDModeCustomView;
	self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.labelText = labelText;
	
    [self.HUD show:YES];
	[self.HUD hide:YES afterDelay:1.5];
	[self.HUD performSelector:@selector(setMode:)
				   withObject:MBProgressHUDModeIndeterminate
				   afterDelay:1.6];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [_HUD removeFromSuperview];
    TT_RELEASE_SAFELY(_HUD);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)navigator:(TTNavigator*)navigator shouldOpenURL:(NSURL*)URL {
    return YES;
}


@end
