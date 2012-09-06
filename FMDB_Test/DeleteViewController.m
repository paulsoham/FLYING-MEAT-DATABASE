//
//  DeleteViewController.m
//  FMDB_Test
//
//  Created by Photon Infotech on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DeleteViewController.h"

@implementation DeleteViewController
@synthesize table;
@synthesize cellTextArray,cellDetailTextArray;

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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [cellTextArray removeAllObjects];
    [cellDetailTextArray removeAllObjects];
    
    [self getFromDatabase];
    [self.table reloadData];
    
 
	
    
    UIBarButtonItem * editButton = [[UIBarButtonItem alloc]initWithTitle:@"DONE" style:UIBarButtonItemStyleBordered target:self action:@selector(editTable)];
    [self.navigationItem setRightBarButtonItem:editButton];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"DELETE";
    cellTextArray=[[NSMutableArray alloc]initWithCapacity:1];
    cellDetailTextArray=[[NSMutableArray alloc]initWithCapacity:1];
    
    self.table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStyleGrouped];
    self.table.delegate=self;
    self.table.dataSource=self;
    self.table.tag=2;
    self.table.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:self.table];
    
    [self editTable];
}

-(void)getFromDatabase{
    
    NSString *databasePath = [(AppDelegate *)[[UIApplication sharedApplication] delegate]dbPath];
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    
    [db open]; 
    
    
    FMResultSet *results = [db executeQuery:@"select * from user"];
    while([results next]) {
        NSString *name1 = [results stringForColumn:@"name"];
        NSInteger age1  = [results intForColumn:@"age"];        
        NSLog(@"User: %@ - %d",name1, age1);
        [cellTextArray addObject:name1];
        [cellDetailTextArray addObject:[NSString stringWithFormat:@"%d",age1]];
        
    }
    
    [db close];
    
}
-(void)editTable{
    
    if (self.editing) {
        [super setEditing:NO animated:NO];
        [self.table setEditing:NO animated:NO];
        [self.table reloadData];
        [self.navigationItem.rightBarButtonItem setTitle:@"DELETE"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
    }
    else{
        [super setEditing:YES animated:YES];
        [self.table setEditing:YES animated:YES];
        [self.table reloadData];
        [self.navigationItem.rightBarButtonItem setTitle:@"DONE"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	return cellTextArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    
    [cell.textLabel setText:[cellTextArray objectAtIndex:indexPath.row]];
    [cell.detailTextLabel setText:[cellDetailTextArray objectAtIndex:indexPath.row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ;    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.editing == NO || !indexPath) {
        return UITableViewCellEditingStyleNone;
    }
    
    if (self.editing && indexPath.row == ([cellTextArray count])) {
        return  UITableViewCellEditingStyleInsert;
    }
    else{
        
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *databasePath = [(AppDelegate *)[[UIApplication sharedApplication] delegate]dbPath];
        FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
        
        [db open]; 
        
        NSString *nameToDelete =[NSString stringWithFormat:@"delete from user where name = %@",[cellTextArray objectAtIndex:indexPath.row]];
        [db executeUpdate:nameToDelete];
        
        NSString *ageToDelete =[NSString stringWithFormat:@"delete from user where age = %@",[cellDetailTextArray objectAtIndex:indexPath.row]];
        [db executeUpdate:ageToDelete];
        
        [db close];
        
        
        [cellTextArray removeObjectAtIndex:indexPath.row];
        [cellDetailTextArray removeObjectAtIndex:indexPath.row];
        
        
        [tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath]
                         withRowAnimation: UITableViewRowAnimationRight];
        
        [tableView reloadData];
        
        
        
        
    }
}



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    NSString * item = [[cellTextArray objectAtIndex:sourceIndexPath.row]retain];
    [cellTextArray removeObject:item];
    [cellTextArray insertObject:item atIndex:destinationIndexPath.row];
    [item release];
    
    
    NSString * item2 = [[cellDetailTextArray objectAtIndex:sourceIndexPath.row]retain];
    [cellDetailTextArray removeObject:item2];
    [cellDetailTextArray insertObject:item2 atIndex:destinationIndexPath.row];
    [item2 release];
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
