//
//  EmbedReaderViewController.m
//  EmbedReader
//
//  Created by spadix on 5/2/11.
//

#import "EmbedReaderViewController.h"
#import <AudioToolbox/AudioServices.h>
#import "NSStringAdditions.h"
@implementation EmbedReaderViewController

@synthesize readerView, resultText;
@synthesize scanButton = _scanButton;
- (void) cleanup
{
    [cameraSim release];
    cameraSim = nil;
    readerView.readerDelegate = nil;
    [readerView release];
    readerView = nil;
    [resultText release];
    resultText = nil;
    [_scanButton release];
    _scanButton = nil;
    [_codes release];
    _codes = nil;
}

- (void) dealloc
{
    [self cleanup];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _codes = [[NSMutableArray alloc] init];
    }
    return  self;
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"条码扫描";
    
    UIBarButtonItem *_menu = [[UIBarButtonItem alloc] 
                              initWithTitle:@"取消" 
                              style:UIBarButtonItemStyleBordered 
                              target:self 
                              action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = _menu;
    [_menu release];
    resultText.editable = NO;
    // the delegate receives decode results
    readerView.readerDelegate = self;
    
    // you can use this to support the simulator
    if(TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc]
                        initWithViewController: self];
        cameraSim.readerView = readerView;
    }
    
    _text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    _text.text = @"扫描中...";
    _text.backgroundColor = [UIColor clearColor];
    _text.textColor = [UIColor blueColor];
    _text.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:_text];
    [self.view bringSubviewToFront:_text];
    [_text release];
}

-(void)backAction{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) viewDidUnload
{
    [self cleanup];
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    // auto-rotation is supported
    return(YES);
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    // compensate for view rotation so camera preview is not rotated
    [readerView willRotateToInterfaceOrientation: orient
                                        duration: duration];
}

- (void) viewDidAppear: (BOOL) animated
{
    //不休眠
    [UIApplication sharedApplication].idleTimerDisabled=YES;
    // run the reader when the view is visible
    [readerView start];
}

- (void) viewWillDisappear: (BOOL) animated
{
    //不休眠
    [UIApplication sharedApplication].idleTimerDisabled=NO;
    [readerView stop];
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    if ([_scanButton.title isEqualToString:@"启动"]) {
        return;
    }
    // do something useful with results
    for(ZBarSymbol *sym in syms) {
        //震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        _text.text = sym.data;
//        if ([resultText.text isEmptyOrWhitespace]) {
//            resultText.text = sym.data;
//            [_codes addObject:sym.data];
//            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//        }else{
//            NSUInteger index =  [_codes indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
//				
//				return [obj isEqualToString:sym.data];
//			}];
//			if (index == NSNotFound) {
//                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//                [_codes addObject:sym.data];
//                resultText.text = [NSString stringWithFormat:@"%@ \n%@",
//                                   resultText.text,sym.data];
//			}
//        }
        break;
    }
}

-(IBAction)scanAction{
    if ([_scanButton.title isEqualToString:@"停止"]) {
        _scanButton.title = @"启动";
    }else{
        _scanButton.title = @"停止";
    }
}

-(IBAction)resultClear{
    resultText.text = @"";
}

@end
