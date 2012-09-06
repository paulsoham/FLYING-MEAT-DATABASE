//
//  InsertViewController.m
//  FMDB_Test
//
//  Created by Photon Infotech on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InsertViewController.h"
@implementation InsertViewController
@synthesize detailTextData,textData;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [name resignFirstResponder];
    [age resignFirstResponder];
    return YES;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [textData removeAllObjects];
    [detailTextData removeAllObjects];

    show.hidden=YES;
    name.hidden=NO;
    age.hidden=NO;
    buttonShow.hidden=YES;
    buttonInsert.hidden=NO;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];

    self.title=@"INSERT";
      
    name=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
    [self.view addSubview:name];
    name.backgroundColor=[UIColor yellowColor];
    name.autocorrectionType=UITextAutocorrectionTypeNo;
    name.delegate=self;
    name.textAlignment=UITextAlignmentCenter;
    name.placeholder=@"Put Name";
    
    age=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, 300, 30)];
    [self.view addSubview:age];
    age.textAlignment=UITextAlignmentCenter;
    age.backgroundColor=[UIColor yellowColor];
    age.autocorrectionType=UITextAutocorrectionTypeNo;
    age.delegate=self;
    age.placeholder=@"Put Age";
    
    
    buttonInsert = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonInsert.frame=CGRectMake(80, 100, 162, 53);
    [buttonInsert setTitle:@"INSERT" forState:UIControlStateNormal];
    [buttonInsert addTarget:self action:@selector(insertButtonPressed) forControlEvents: UIControlEventTouchUpInside];      
    [self.view addSubview:buttonInsert];
    
    textData=[[NSMutableArray alloc]initWithCapacity:0];
    detailTextData=[[NSMutableArray alloc]initWithCapacity:0];

    
    
    
   

    
}
-(void)insertButtonPressed{
    buttonInsert.hidden=YES;
    [age setHidden:YES];
    [name setHidden:YES];
     
    [age resignFirstResponder];

    NSString *databasePath = [(AppDelegate *)[[UIApplication sharedApplication] delegate]dbPath];
    NSLog(@"docsPath 2 -->>%@",databasePath);

    FMDatabase * db = [FMDatabase databaseWithPath:databasePath];
    
    [db open]; 
    
    NSString *query = [NSString stringWithFormat:@"insert into user values ('%@', %d)",name.text, [age.text intValue]];
    [db executeUpdate:query];
    
    
    FMResultSet *results = [db executeQuery:@"select * from user"];
    while([results next]) {
        NSString *name1 = [results stringForColumn:@"name"];
        NSInteger age1  = [results intForColumn:@"age"];        
        NSLog(@"User: %@ - %d",name1, age1);
        [textData addObject:name1];
        [detailTextData addObject:[NSString stringWithFormat:@"%d",age1]];

    }
    
    [db close];

    
    
    show =[[[UILabel alloc]initWithFrame:CGRectMake(10, 170, 300, 100)]autorelease];
    [self.view addSubview:show];
    show.backgroundColor=[UIColor whiteColor];
    show.numberOfLines=5;
    show.textAlignment=UITextAlignmentCenter;
    show.text=[NSString stringWithFormat:@"%@,%@",[textData lastObject],[detailTextData lastObject]];

   
    name.text=@"";
    age.text=@"";
    
    buttonShow = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonShow.frame=CGRectMake(80, 300, 162, 40);
    [buttonShow setTitle:@"SHOW" forState:UIControlStateNormal];
    [buttonShow addTarget:self action:@selector(ShowButtonAction) forControlEvents: UIControlEventTouchUpInside];      
    [self.view addSubview:buttonShow];
}

-(void)ShowButtonAction{
    
    ShowDataviewController * upVw=[[ShowDataviewController alloc]init];
    [self.navigationController pushViewController:upVw animated:YES];
    
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
