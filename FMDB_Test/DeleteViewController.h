//
//  DeleteViewController.h
//  FMDB_Test
//
//  Created by Photon Infotech on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FMDatabase.h"
@interface DeleteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView * table;
    NSMutableArray * cellTextArray;
    NSMutableArray * cellDetailTextArray;
    
}
-(void)editTable;
-(void)getFromDatabase;
@property (nonatomic, retain)UITableView * table;
@property(nonatomic,retain)NSMutableArray * cellTextArray;
@property(nonatomic,retain)NSMutableArray * cellDetailTextArray;

@end
