//
//  AppDelegate.h
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class User;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    TTNavigator* _navigator;
	NSMutableDictionary *_temporaryValues;
	MBProgressHUD *_HUD;
    NSMutableArray *_contollers;
    User *_user;
    NSMutableArray *constants;
    NSArray *baths;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readonly) TTNavigator* navigator;
@property (nonatomic, readonly) NSMutableArray *contollers;
@property (nonatomic, retain) NSMutableDictionary *temporaryValues;
@property (nonatomic, readonly) MBProgressHUD *HUD;
@property (nonatomic, retain) User *user;
@property (nonatomic, copy) NSArray *baths;
@property (nonatomic, copy) NSMutableArray *constants;

-(UIViewController*)loadViewDeck:(NSString*)centerViewController;
-(void)alert:(NSString*)title message:(NSString*)message;
-(void)HUDShow:(NSString*)labelText yOffset:(NSString*)yOffset;
-(void)HUDHide;
-(void)showWithLabelDeterminate:(NSString *)labelText;
- (void)showWithCustomView:(NSString*)labelText;
- (UIViewController*)loadFromNib:(NSString*)className;
- (UIViewController *)loadFromVC:(NSString *)className;
- (void)alert:(NSString*)title message:(NSString*)message;
-(void)removeControllers;
@end
