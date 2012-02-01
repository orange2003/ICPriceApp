//
//  SideSwipeTableViewController.h
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


@interface SideSwipeTableViewController : TTTableViewController{
    UITableViewCell* sideSwipeCell;
    IBOutlet UIView* sideSwipeView;
    BOOL animatingSideSwipe;
    UISwipeGestureRecognizerDirection sideSwipeDirection;
    NSArray* buttonData;
    NSMutableArray* buttons;
}
- (void)swipeLeft:(UISwipeGestureRecognizer *)recognizer;
@property (nonatomic, assign) UIViewController *contentController;
@property (nonatomic) BOOL animatingSideSwipe;
@property (nonatomic, retain) UITableViewCell* sideSwipeCell;
@property (nonatomic, retain) IBOutlet UIView* sideSwipeView;
@property (nonatomic) UISwipeGestureRecognizerDirection sideSwipeDirection;

-(UIImage*) imageFilledWith:(UIColor*)color using:(UIImage*)startImage;
- (void) removeSideSwipeView:(BOOL)animated;
- (void) swipe:(UISwipeGestureRecognizer *)recognizer direction:(UISwipeGestureRecognizerDirection)direction;
@end
