//
//  Stock.h
//  IcpriceDemo
//
//  Created by Fei Gao on 11-1-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


@interface Stock : NSObject {
	NSString *ider;
	NSString *type;//型号
	NSString *quantity;//数量
	NSString *brand;//厂牌
	NSString *description;//说明
	NSString *date;//日期
	NSString *alias; //助记名
	NSString *truth; //库存真实性
	NSString *address;//简址
	NSString *supplier;//供货商
}
@property (nonatomic, copy) NSString *ider;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *brand;

@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *alias;
@property (nonatomic, copy) NSString *truth;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *supplier;

@end
