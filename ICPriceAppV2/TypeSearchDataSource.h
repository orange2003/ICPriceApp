//
//  TypeSearchDataSource.h
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@interface TypeSearchDataSource : TTListDataSource {
    NSString *_type;
}
@property (nonatomic, copy)  NSString *type;
@end
