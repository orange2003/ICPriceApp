//
//  UIViewControllerAdditions.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-24.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIViewControllerAdditions.h"

static NSMutableDictionary* gParControllers = nil;

@implementation UIViewController(Additions)

- (UIViewController*)parController {
    NSString* key = [NSString stringWithFormat:@"%d", self.hash];
    return [gParControllers objectForKey:key];
}

- (void)setParController:(UIViewController*)viewController {
    NSString* key = [NSString stringWithFormat:@"%d", self.hash];
    if (nil != viewController) {
        if (nil == gParControllers) {
            gParControllers = TTCreateNonRetainingDictionary();
        }
        [gParControllers setObject:viewController forKey:key];
    } else {
        [gParControllers removeObjectForKey:key];
    }
}

@end
