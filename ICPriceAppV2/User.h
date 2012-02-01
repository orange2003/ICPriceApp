//
//  User.h
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@interface User : NSObject {
	NSString *ider;
	NSString *roleId;//角色id
	NSString *companyId;//公司id
	NSString *companyName;//公司名
	NSString *platform;//平台id
	NSString *currency;//默认货币
	NSString *companyPlantform;//公司默认平台
	NSString *inquiryTips;//询价提示
	NSString *platformNum;//平台数
	NSString *platName;
	NSString *name;
}
@property (nonatomic, copy) NSString *ider;
@property (nonatomic, copy) NSString *roleId;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *platform;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *companyPlantform;
@property (nonatomic, copy) NSString *inquiryTips;
@property (nonatomic, copy) NSString *platformNum;
@property (nonatomic, copy) NSString *platName;
@property (nonatomic, copy) NSString *name;
@end
