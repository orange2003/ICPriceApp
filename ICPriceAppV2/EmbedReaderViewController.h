//
//  EmbedReaderViewController.h
//  EmbedReader
//
//  Created by spadix on 5/2/11.
//

# import "ZBarSDK.h"

@interface EmbedReaderViewController : UIViewController< ZBarReaderViewDelegate >{
    ZBarReaderView *readerView;
    UITextView *resultText;
    ZBarCameraSimulator *cameraSim;
    UIBarButtonItem *_scanButton;
    NSMutableArray *_codes;
    UILabel *_text;
}

@property (nonatomic, retain) IBOutlet ZBarReaderView *readerView;
@property (nonatomic, retain) IBOutlet UITextView *resultText;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *scanButton;
-(IBAction)resultClear;
-(IBAction)scanAction;
@end
