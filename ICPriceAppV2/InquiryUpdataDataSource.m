//
//  InquiryUpdataDataSource.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "IBAFormSection.h"
#import "IBATextFormField.h"
#import "InquiryUpdataDataSource.h"
#import "IBAButtonFormField.h"
#import "IBAFormFieldStyle.h"
#import "IBAPickListFormField.h"
#import "Inquiry.h"
#import "User.h"
@implementation InquiryUpdataDataSource
@synthesize numberKeyPad;
@synthesize type = _type;


//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
	[_type release];
    _type = nil;

	[numberKeyPad release];
	numberKeyPad = nil;
    [super dealloc];
}

- (id)initWithModel:(id)aModel {
	if (self = [super initWithModel:aModel]) {
		
		IBAFormSection *buttonsSection = [self addSectionWithHeaderTitle: ((Inquiry*)[kAppDelegate.temporaryValues objectForKey:@"inquiry"]).type footerTitle:nil];

		IBAFormFieldStyle *buttonStyle = [[[IBAFormFieldStyle alloc] init] autorelease];
		buttonStyle.labelTextColor = [UIColor colorWithRed:0.318 green:0.400 blue:0.569 alpha:1.0];
		buttonStyle.labelFont = [UIFont boldSystemFontOfSize:14];
		buttonStyle.labelTextAlignment = UITextAlignmentLeft;
		buttonStyle.labelFrame = CGRectMake(15, 8, 280, 30);
		
		buttonsSection.formFieldStyle = buttonStyle;
		
		// Some basic form fields that accept text input
		IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:@"" footerTitle:nil];

		IBAFormFieldStyle *style = [[[IBAFormFieldStyle alloc] init] autorelease];
		style.labelTextColor = [UIColor darkGrayColor];
        style.labelTextAlignment = UITextAlignmentLeft;
		style.labelFont = [UIFont systemFontOfSize:14];
        //style.labelFrame = CGRectMake(10, 9, 30, 30);
		style.valueTextAlignment = UITextAlignmentLeft;
		basicFieldSection.formFieldStyle = style;
		
		IBATextFormField *amountField = [[IBATextFormField alloc] initWithKeyPath:@"quantity"
																			title:@" 数量:"];
		
		
		
		
		IBATextFormField *moneyField = [[IBATextFormField alloc] initWithKeyPath:@"price"
																			title:@" 来价:"];
		
		[basicFieldSection addFormField:[amountField autorelease]];
		[basicFieldSection addFormField:[moneyField autorelease]];
		
        if (isPhone) {
			moneyField.textFormFieldCell.textField.keyboardType =UIKeyboardTypeNumberPad;
			moneyField.textFormFieldCell.textField.delegate = self;
			amountField.textFormFieldCell.textField.keyboardType = UIKeyboardTypeNumberPad;
		}else {
			moneyField.textFormFieldCell.textField.keyboardType =UIKeyboardTypeNumbersAndPunctuation;
			amountField.textFormFieldCell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
		}
		moneyField.textFormFieldCell.textField.placeholder = @"¥0.00";
		
        IBATextFormField *bath = [[IBATextFormField alloc] initWithKeyPath:@"batch"
																			title:@" 批号:"];
        
		
		[basicFieldSection addFormField:[bath autorelease]];
		
		NSArray *pickListOptions = [IBAPickListFormOption pickListOptionsForStrings:
									[((NSMutableDictionary*)[kAppDelegate.constants objectAtIndex:2]) allKeys] ];
        
		IBAPickListFormOptionsStringTransformer *transformer = [[[IBAPickListFormOptionsStringTransformer alloc] initWithPickListOptions:pickListOptions] autorelease];
		
		IBAPickListFormField *stauts = [[IBAPickListFormField alloc] initWithKeyPath:@"status"
																			   title:@" 状态:"
																	valueTransformer:transformer
																	   selectionMode:IBAPickListSelectionModeSingle
																			 options:pickListOptions];
		
		
		[basicFieldSection addFormField:[ stauts autorelease]];

		[basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"remarks" 
																			 title:@" 备注:"] autorelease]];
	}
	return self;
}



- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
	if (numberKeyPad) {
		numberKeyPad.currentTextField = textField;
	}
	return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {	
	if (!self.numberKeyPad) {
		self.numberKeyPad = [NumberKeypadDecimalPoint keypadForTextField:textField];
	}else {
		//if we go from one field to another - just change the textfield, don't reanimate the decimal point button
		self.numberKeyPad.currentTextField = textField;
	}
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
	//if (![textField isEqual:normal]) {
	if (textField == numberKeyPad.currentTextField) {
		/*
		 Hide the number keypad
		 */
		[self.numberKeyPad removeButtonFromKeyboard];
		self.numberKeyPad = nil;
	}
	
	/*
	 Hide the number keypad
	 */
	[self.numberKeyPad removeButtonFromKeyboard];
	self.numberKeyPad = nil;
}

-(CGFloat)heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 0;
    }else{
        return 20;
    }
} 

-(CGFloat)heightForFooterInSection:(NSInteger)section{
    return 0;
} 



@end
