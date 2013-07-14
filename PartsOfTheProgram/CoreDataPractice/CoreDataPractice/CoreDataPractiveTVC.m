//
//  CoreDataPractiveTVC.m
//  CoreDataPractice
//
//  Created by Tongda Zhang on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoreDataPractiveTVC.h"
#import "Event.h"


@implementation CoreDataPractiveTVC
@synthesize document = _document;
@synthesize eventsArray=_eventsArray;
@synthesize addButton=_addButton;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
-(void)startFetchingData{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
    //request.predicate = [NSPredicate predicateWithFormat:@"any myID_number > 5"];
    NSSortDescriptor *sortByID = [NSSortDescriptor sortDescriptorWithKey:@"myID_number"ascending:YES];
    request.sortDescriptors=[NSArray arrayWithObjects:sortByID, nil];
    //Executing the fetch
    NSManagedObjectContext *moc=self.document.managedObjectContext;
    NSError *error;
    NSArray *events = [moc executeFetchRequest:request error:&error];
    self.eventsArray = [events mutableCopy];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set the title.
    self.title = @"Locations";
    // Set up the buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
        target:self
        action:@selector(addEvent)];
    self.addButton.enabled = YES;
    self.navigationItem.rightBarButtonItem = self.addButton;
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

    NSURL *url=[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    url=[url URLByAppendingPathComponent:@"Default Event Database"];

    self.document = [[UIManagedDocument alloc] initWithFileURL:url];
    if(![[NSFileManager defaultManager] fileExistsAtPath:[url path]]){
        //the document file does not exist, so create the file based on the url
        [self.document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            //document is ready; doing stuff with the UIManagedDocument
            [self startFetchingData];
            [self.tableView reloadData];
        }];
    }else if(self.document.documentState == UIDocumentStateClosed){
        //the document is exist and closed, so just open it
        [self.document openWithCompletionHandler:^(BOOL success){
            [self startFetchingData];
            [self.tableView reloadData];
        }];
    }else if(self.document.documentState == UIDocumentStateNormal){
        //already open, start to stuff
        [self startFetchingData];
        [self.tableView reloadData];
    }


 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.eventsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Event *event = (Event *)[self.eventsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",event.myID_number];
    cell.detailTextLabel.text = @"haha";
    return cell;
}


-(void)addEvent{
    //creat new event
    Event *event=(Event *)[NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:self.document.managedObjectContext];
    [event setMyID_number:[NSNumber numberWithInt:19]];//[NSNumber numberWithInt:arc4random()]
    
    [self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success){
        if(!success) {
            NSLog(@"failed to save document %@",self.document.localizedName);
        }
        else {
            NSLog(@"success");
        }
    }];

    
    [self.eventsArray insertObject:event atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        Event *event=[self.eventsArray objectAtIndex:indexPath.row];
        [self.eventsArray removeObject:event];
        [self.document.managedObjectContext deleteObject:event];
        [self.document saveToURL:self.document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success){
            if(!success) NSLog(@"failed to delete document %@",self.document.localizedName);
        }];
        
        NSLog(@"%d",indexPath.row);
        NSLog(@"%d",indexPath.section);
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
