//
//  UPdateViewController.m
//  FMDB_Test
//
//  Created by Photon Infotech on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UPdateViewController.h"

@implementation UPdateViewController
@synthesize indexCount;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.view.frame=CGRectMake(0, -15, 320, 480);
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    self.view.frame=CGRectMake(0, 0, 320, 480);

    [old_name resignFirstResponder];
    [old_age resignFirstResponder];
    [new_name resignFirstResponder];
    [new_age resignFirstResponder];
    return YES;
}
-(void)getFromDatabase{
    
    NSString *databasePath = [(AppDelegate *)[[UIApplication sharedApplication] delegate]dbPath];
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    
    [db open]; 
    
    
    FMResultSet *results = [db executeQuery:@"select * from user"];
    while([results next]) {
        NSString *name = [results stringForColumn:@"name"];
        NSInteger age  = [results intForColumn:@"age"];        
        [cellDataShow addObject:name];
        [cellDetailDataShow addObject:[NSString stringWithFormat:@"%d",age]];
        
    }
    
    [db close];
    NSLog(@"cellDataShow==>>%@",cellDataShow);
    NSLog(@"cellDetailDataShow==>>%@",cellDetailDataShow);

}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"UPDATE";
    self.view.backgroundColor=[UIColor lightGrayColor];

    cellDataShow=[[NSMutableArray alloc]initWithCapacity:1];
    cellDetailDataShow=[[NSMutableArray alloc]initWithCapacity:1];
    
    [self getFromDatabase];
   
    
    old_name=[[UITextField alloc]init];
    [self.view addSubview:old_name];
    old_name.frame=CGRectMake(10, 20, 300, 40);
    old_name.backgroundColor=[UIColor greenColor];
    old_name.textAlignment=UITextAlignmentCenter;
    old_name.text=[cellDataShow objectAtIndex:indexCount];
    old_name.userInteractionEnabled=NO;
    old_name.delegate=self;
    
    old_age=[[UITextField alloc]init];
    [self.view addSubview:old_age];
    old_age.frame=CGRectMake(10, 70, 300, 40);
    old_age.backgroundColor=[UIColor greenColor];
    old_age.textAlignment=UITextAlignmentCenter;
    old_age.text=[cellDetailDataShow objectAtIndex:indexCount];
    old_age.userInteractionEnabled=NO;
    old_age.delegate=self;

    
    new_name=[[UITextField alloc]init];
    [self.view addSubview:new_name];
    new_name.frame=CGRectMake(10, 120, 300, 40);
    new_name.placeholder=@"Update Name";
    new_name.backgroundColor=[UIColor yellowColor];
    new_name.textAlignment=UITextAlignmentCenter;
    new_name.delegate=self;

    new_age=[[UITextField alloc]init];
    [self.view addSubview:new_age];
    new_age.placeholder=@"Update Age";
    new_age.frame=CGRectMake(10, 170, 300, 40);
    new_age.backgroundColor=[UIColor yellowColor];
    new_age.textAlignment=UITextAlignmentCenter;
    new_age.delegate=self;

    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(80, 220, 162, 53);
    [button setTitle:@"Update" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(updateBtnPressed) forControlEvents: UIControlEventTouchUpInside];      
    [self.view addSubview:button];
    
}
-(void)updateBtnPressed{
    
    [old_name resignFirstResponder];
    [old_age resignFirstResponder];
    [new_name resignFirstResponder];
    [new_age resignFirstResponder];
    
    
    NSString *databasePath = [(AppDelegate *)[[UIApplication sharedApplication] delegate]dbPath];
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    
    [db open];

    NSString * nameUpdate= [NSString stringWithFormat:@"update user set name ='%@' where name ='%@'",new_name.text,old_name.text];
    [db executeUpdate:nameUpdate];

    
    NSString * ageUpdate= [NSString stringWithFormat:@"update user set age =%@ where age =%@",new_age.text,old_age.text];
    [db executeUpdate:ageUpdate];
    
    
    [db close];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
