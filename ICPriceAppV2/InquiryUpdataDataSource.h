//
//  InquiryUpdataDataSource.h
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "IBAFormDataSource.h"
#import "NumberKeypadDecimalPoint.h"
@interface InquiryUpdataDataSource : IBAFormDataSource <UITextFieldDelegate>{
	NSString *_type;
	NumberKeypadDecimalPoint *numberKeyPad;
}
@property (nonatomic,copy) NSString *type;
@property (nonatomic, retain) NumberKeypadDecimalPoint *numberKeyPad;
@end
