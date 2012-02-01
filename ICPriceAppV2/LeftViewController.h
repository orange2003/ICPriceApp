//
//  LeftViewController.h
//  ICPriceAppV2
//
//  Created by 高飞 on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

@class CMPopTipView;
@interface LeftViewController : TTTableViewController<UISearchBarDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    CMPopTipView* _popTipView;
    NSInteger _typeFlag;
}

@end
