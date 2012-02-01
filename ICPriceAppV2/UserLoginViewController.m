//
//  UserLoginViewController.m
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserLoginViewController.h"
#import "ASIFormDataRequest.h"
#import "HMGLTransitionManager.h"
#import "FlipTransition.h"
#import "NSStringAdditions.h"
#import "User.h"
@implementation UserLoginViewController



-(void)loadView{
    [super loadView];
    UIImageView *_back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 94)];
    _back.image = TTIMAGE(@"bundle://denglu.png");
    [self.view addSubview:_back];
    [_back release];
    
    _nameField = [[UITextField alloc] initWithFrame:CGRectMake(70, 24, 200, 21)];
    _nameField.placeholder = @"请输入帐号";
    _nameField.keyboardType = UIKeyboardTypeEmailAddress;
    _nameField.font = [UIFont systemFontOfSize:16];
    _nameField.textColor = RGBCOLOR(153, 153, 153);
    //_nameField.delegate = self;
    [self.view addSubview:_nameField];
    [_nameField release];
    
    _passField = [[UITextField alloc] initWithFrame:CGRectMake(70, 64, 200, 21)];
    _passField.placeholder = @"请输入密码";
    _passField.secureTextEntry = YES;
    _passField.font = [UIFont systemFontOfSize:16];
    _passField.textColor = RGBCOLOR(153, 153, 153);
    //_passField.delegate = self;
    [self.view addSubview:_passField];
    [_passField release];
    
    TTButton *_loginButton = [TTButton buttonWithStyle:@"loginButton:" title:@"登陆"];
    [_loginButton addTarget:self action:@selector(loginAction) 
           forControlEvents:UIControlEventTouchUpInside];
    _loginButton.frame = CGRectMake(10, 100, 300, 44);
    [self.view addSubview:_loginButton];
    
    [_nameField becomeFirstResponder];
    
    
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *name=  [defaults stringForKey:@"name"];
	NSString *pass=  [defaults stringForKey:@"pass"];
    if (name&&pass) {
		_nameField.text = name;
		_passField.text = pass;
		[self performSelector:@selector(loginAction) withObject:nil afterDelay:0.0];
	}else{
        _nameField.text = @"";
        _passField.text = @"";
        [_nameField becomeFirstResponder];
    }
}

//登陆
-(void)loginAction{
    if ([_nameField.text isEmptyOrWhitespace]) {
		[kAppDelegate alert:@"" message:@"请输入您的帐号"];
		return;
	}
	
	if ([_passField.text isEmptyOrWhitespace]) {
		[kAppDelegate alert:@"" message:@"请输入您的密码"];
		return;
	}
    
    [kAppDelegate HUDShow:@"登录中" yOffset:0];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.icprice.cn/handlers/ilogin.ashx?user=%@&psw=%@",_nameField.text,_passField.text]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //NSLog(@"self.nameField.text %@",self.nameField.text);
    //NSLog(@"self.passwordField.text %@",self.passwordField.text);
    [request setPostValue:_nameField.text forKey:@"username" ];
    [request setPostValue:_passField.text forKey:@"pwd"];
    [request setRequestMethod:@"POST"];
	[request setDelegate:self];
	request.didFinishSelector = @selector(finishRequest:);
	request.didFailSelector = @selector(finishFail:);
	[request startAsynchronous];
}

-(void)finishFail:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	[kAppDelegate alert:@"" message:[[request error] localizedDescription]];
}


-(void)finishRequest:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
    //NSLog(@"request %@",[request responseString]);
    if (![[request responseString] isEmptyOrWhitespace]) {
        NSArray * rows = [[request responseString] componentsSeparatedByString:split2];
        NSMutableArray *constants = [NSMutableArray arrayWithCapacity:4];
        User *user  = [[User alloc] init];
        NSArray *userInfo = [[rows objectAtIndex:0] componentsSeparatedByString:split1];
        
        // ID,公司ID,TrueName,角色ID,角色名,公司名,箱号ID,货位管理
        user.ider = [userInfo objectAtIndex:0];
        user.name = [userInfo objectAtIndex:2];
        user.roleId = [userInfo objectAtIndex:3];
        user.companyId = [userInfo objectAtIndex:1];
        user.companyName = [userInfo objectAtIndex:5];
        
        //保存用户信息
        kAppDelegate.user = user;
        [user release];	
        //保存用户信息
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_nameField.text forKey:@"name"];
        
        [defaults setObject:_passField.text forKey:@"pass"];
        [defaults synchronize];
        
        [_nameField resignFirstResponder];
        [_passField resignFirstResponder];
        
        for (int i=1; i<[rows count]; i++) {
            NSMutableDictionary *dType = [NSMutableDictionary dictionary];
            NSMutableArray* tempkey = [[NSMutableArray alloc] initWithCapacity:10];
            if ([[rows objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0) {
                NSArray *cells = [[rows objectAtIndex:i] componentsSeparatedByString:split4];
                for (NSString *values in cells) {
                    NSArray*key = [values componentsSeparatedByString:split1];
                    [dType setValue:[key objectAtIndex:0] forKey:[key objectAtIndex:1]];
                    [tempkey addObject:[key objectAtIndex:1]];
                }
                if (i==1) {
                    kAppDelegate.baths = tempkey;
                }
                
                [constants addObject:dType];
            }else {//如果常量值为空的处理
                if (i==0) {
                    kAppDelegate.baths = tempkey;
                }
                [dType setValue:@"" forKey:@""];
                [constants addObject:dType];
            }
            [tempkey release];
        }
        kAppDelegate.constants = constants;
        
        
        // UIViewController
        [self presentModalViewController:[kAppDelegate loadViewDeck:@"QuoteInquiryListController"] animated:YES];
    }else{
        [kAppDelegate alert:@"错误" message:@"登陆失败用户名或密码错误!"];
    }
        

}


@end
