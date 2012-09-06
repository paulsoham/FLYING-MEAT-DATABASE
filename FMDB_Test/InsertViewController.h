//
//  InsertViewController.h
//  FMDB_Test
//
//  Created by Photon Infotech on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FMDatabase.h"
#import "UPdateViewController.h"
#import "ShowDataviewController.h"

@interface InsertViewController : UIViewController<UITextFieldDelegate>{
    UIButton * buttonInsert;
    UIButton * buttonShow;
    UITextField * name;
    UITextField * age;
    NSMutableArray * textData;
    NSMutableArray * detailTextData;

    UILabel * show;
}
@property(nonatomic,copy)NSMutableArray * textData;
@property(nonatomic,copy)NSMutableArray * detailTextData;

@end
