//
//  PhotoUpDataSource.m
//  IcpriceDemo
//
//  Created by Fei Gao on 11-2-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoUpDataSource.h"
#import "IBAFormSection.h"
#import "IBATextFormField.h"

#import "IBAButtonFormField.h"
#import "IBAFormFieldStyle.h"
#import "IBAPickListFormField.h"

@implementation PhotoUpDataSource

- (id)initWithModel:(id)aModel {
	if (self = [super initWithModel:aModel]) {
		IBAFormSection *buttonsSection = [self addSectionWithHeaderTitle:@"" footerTitle:nil];
		IBAFormFieldStyle *buttonStyle = [[[IBAFormFieldStyle alloc] init] autorelease];
		buttonStyle.labelTextColor = [UIColor colorWithRed:0.318 green:0.400 blue:0.569 alpha:1.0];
		buttonStyle.labelFont = [UIFont boldSystemFontOfSize:14];
		buttonStyle.labelTextAlignment = UITextAlignmentLeft;
		buttonStyle.labelFrame = CGRectMake(9, 8, 280, 30);
		buttonsSection.formFieldStyle = buttonStyle;
            
		IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:@"" footerTitle:nil];
		
		IBAFormFieldStyle *style = [[[IBAFormFieldStyle alloc] init] autorelease];
		style.labelTextColor = [UIColor darkGrayColor];
        style.labelTextAlignment = UITextAlignmentLeft;
		style.labelFont = [UIFont systemFontOfSize:14];
		
		basicFieldSection.formFieldStyle = style;
		
		
		NSArray *bathOptions = [IBAPickListFormOption pickListOptionsForStrings:
								kAppDelegate.baths];
		
		IBAPickListFormOptionsStringTransformer *transformer1 = [[[IBAPickListFormOptionsStringTransformer alloc] initWithPickListOptions:bathOptions] autorelease];
		

		
		
		
		IBAPickListFormField *bath = [[IBAPickListFormField alloc] initWithKeyPath:@"batch"
																			 title:@"批号:"
																  valueTransformer:transformer1
																	 selectionMode:IBAPickListSelectionModeSingle
																		   options:bathOptions];
		
		[basicFieldSection addFormField:[bath autorelease]];
		
		
		
		NSArray *pickListOptions = [IBAPickListFormOption pickListOptionsForStrings: 
									[((NSMutableDictionary*)[kAppDelegate.constants objectAtIndex:1]) allKeys] ];
		IBAPickListFormOptionsStringTransformer *transformer = [[[IBAPickListFormOptionsStringTransformer alloc] initWithPickListOptions:pickListOptions] autorelease];
		
		IBAPickListFormField *stauts = [[IBAPickListFormField alloc] initWithKeyPath:@"status"
																			   title:@"分类:"
																	valueTransformer:transformer
																	   selectionMode:IBAPickListSelectionModeSingle
																			 options:pickListOptions];
		
		
		[basicFieldSection addFormField:[ stauts autorelease]];
		
		
		[basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"remarks" 
																			 title:@"描述:"] autorelease]];
	}
	return self;
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
