//
//  MyIBAButtonFormField.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-2-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyIBAButtonFormField.h"

@implementation MyIBAButtonFormField


- (IBAFormFieldCell *)cell {
	if (cell_ == nil) {
		cell_ = [[IBALabelFormCell alloc] initWithFormFieldStyle:self.formFieldStyle reuseIdentifier:@"Cell"];
		cell_.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_button setImage:TTIMAGE(@"bundle://lianxi@2x.png") forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        _button.frame = CGRectMake(270, 0, 44, 44);
        [cell_.cellView addSubview:_button];
	}
	return cell_;
}

-(void)buttonAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonContactAction" object:nil];
}

@end
