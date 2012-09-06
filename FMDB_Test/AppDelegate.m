//
//  AppDelegate.m
//  FMDB_Test
//
//  Created by Photon Infotech on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "InsertViewController.h"
#import "FMDatabase.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize dbPath;
- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self createDataBasePath];

    // Override point for customization after application launch.
    self.viewController = [[[InsertViewController alloc] init] autorelease];
    nav=[[UINavigationController alloc]initWithRootViewController:self.viewController];
    nav.navigationBar.tintColor=[UIColor darkGrayColor];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}
-(void)createDataBasePath{

    /*NSString *deskTopDir = @"/Users/photon/Desktop";
    dbPath =  [[deskTopDir stringByAppendingPathComponent:@"database.sqlite"]retain];*/
  
    
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *docsPath = [paths objectAtIndex:0];
     dbPath = [[docsPath stringByAppendingPathComponent:@"database.sqlite"]retain];
     NSLog(@"docsPath -->>%@",dbPath);
    
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    
    
    
    [database open];
    [database executeUpdate:@"create table user(name text primary key, age int)"];
    [database close];
    
 

}







/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)codeStudy{
    
       
    NSString *deskTopDir = @"/Users/photon/Desktop";
    dbPath =  [deskTopDir stringByAppendingPathComponent:@"database.sqlite"];
    

       
   /* NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"database.sqlite"];*/
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    

    
    [database open];
    [database executeUpdate:@"create table user(name text primary key, age int)"];
    
    //Insert>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    // Building the string ourself
    NSString *query = [NSString stringWithFormat:@"insert into user values ('%@', %d)",
                       @"Steve", 25];
    [database executeUpdate:query];
    
    
    
    // Let fmdb do the work
    [database executeUpdate:@"insert into user(name, age) values(?,?)",
     @"Jobs",[NSNumber numberWithInt:50],nil];
    [database executeUpdate:@"insert into user(name, age) values(?,?)",
     @"Jobs1",[NSNumber numberWithInt:501],nil];
    [database executeUpdate:@"insert into user(name, age) values(?,?)",
    @"Jobs2",[NSNumber numberWithInt:502],nil];
    
    
    
    
    //Update a record>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   
   // [database executeUpdate:@"update user set name = 'abcd' where age = 501"];
     NSString *sqlStat=@"update user set name = 'abcd' where age = 501";    
     [database executeUpdate:sqlStat];

    
    //Delete>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    [database executeUpdate:@"delete from user where age = 25"];
   // NSString *sqlStat=@"delete from user where age = 25";    
   // [database executeUpdate:sqlStat];
    
    [database executeUpdate:@"delete from user where name = 'Jobs2'"];
   // NSString *nameToDelete = @"delete from user where name = 'Jobs2'";
   // [database executeUpdate:nameToDelete];
    
    
    //Delete table
    //[database executeUpdate:@"drop table user"];
    


   /* // Fetch all users>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    FMResultSet *results = [database executeQuery:@"select * from user"];
    while([results next]) {
        NSString *name = [results stringForColumn:@"name"];
        NSInteger age  = [results intForColumn:@"age"];        
        NSLog(@"User: %@ - %d",name, age);
    }*/
    
    
    [database close];
    
     
    
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
