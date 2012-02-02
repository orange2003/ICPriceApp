//
//  QuoteUpdataDataSource.h
//  ICPriceAppV2
//
//  Created by 高飞 on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IBAFormDataSource.h"
#import "NumberKeypadDecimalPoint.h"

@interface QuoteUpdataDataSource : IBAFormDataSource <UITextFieldDelegate>{
    NumberKeypadDecimalPoint *numberKeyPad;
}
@property (nonatomic, retain) NumberKeypadDecimalPoint *numberKeyPad;
@end
