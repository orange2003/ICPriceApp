#define kAppDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)

#define kRESTBaseUrl @"http://www.icprice.cn/handlers/Common.ashx"

#define kUrlPoview @"http://www.icprice.cn/handlers/autocomplete/auto.ashx?type=%@&q=%@&limit=%@"
#define kUrlPoviewUser @"http://www.icprice.cn/handlers/autocomplete/auto.ashx?type=user&q=%@&limit=%@&comid=%@&uid=%@"

#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define split1 @"|~"
#define split2 @"~.~"
#define split3 @"^^"
#define split4 @"-.-"