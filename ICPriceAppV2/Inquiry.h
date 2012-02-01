//
//  Inquiry.h
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "Stock.h"

//询价POJO
@interface Inquiry : Stock<NSCopying> {
	NSString *status;//状态
	NSString *price;//来价
	NSString *source;//来自
	NSString *platform;//平台
	NSString *inquiry;//询价
	NSString *cusInqID;
	NSString *package;//封装
	NSString *priority;//优先级
	NSString *quote;//报价
	NSString *customerID;//客户ID
	NSString *customerName;//客户名
	NSString *customerAlias;//客户别名
	NSString *remarks;//备注
	NSString *supplierName;//供货商全称
	NSString *batch;//批号
}
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *platform;
@property (nonatomic, copy) NSString *inquiry;
@property (nonatomic, copy) NSString *cusInqID;
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *priority;
@property (nonatomic, copy) NSString *quote;
@property (nonatomic, copy) NSString *customerID;
@property (nonatomic, copy) NSString *customerName;
@property (nonatomic, copy) NSString *customerAlias;
@property (nonatomic, copy) NSString *remarks;
@property (nonatomic, copy) NSString *supplierName;
@property (nonatomic, copy) NSString *batch;
@end
