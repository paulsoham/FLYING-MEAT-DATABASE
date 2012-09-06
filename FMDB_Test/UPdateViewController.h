//
//  UPdateViewController.h
//  FMDB_Test
//
//  Created by Photon Infotech on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FMDatabase.h"
@interface UPdateViewController : UIViewController<UITextFieldDelegate>{
    
    NSMutableArray * cellDataShow;
    NSMutableArray * cellDetailDataShow;

    UITextField * old_name;
    UITextField * old_age;
    UITextField * new_name;
    UITextField * new_age;

    int indexCount;
    
}
@property(nonatomic,assign)int indexCount;

@end
