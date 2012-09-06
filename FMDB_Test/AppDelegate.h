//
//  AppDelegate.h
//  FMDB_Test
//
//  Created by Photon Infotech on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InsertViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSString *dbPath;
    UINavigationController * nav;
}
@property(nonatomic,strong) NSString *dbPath;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) InsertViewController *viewController;

-(void)createDataBasePath;

@end
