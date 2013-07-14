//
//  GoogleImageAPIpracticeViewController.m
//  GoogleImageAPIpractice
//
//  Created by Tongda Zhang on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GoogleImageAPIpracticeViewController.h"
#include "ChooseImageTableViewController.h"


@interface GoogleImageAPIpracticeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myimageView;
@property(nonatomic,retain) NSMutableData *data;
@end

@implementation GoogleImageAPIpracticeViewController
@synthesize myimageView = _myimageView;
@synthesize data=_data;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMyimageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - button action
- (IBAction)StartSearch:(UIButton*)sender {
    NSString *keyword=@"stanford%20guest%20house";
    NSString *request_string=[NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=%d&q=%@",GOOGLE_IMAGE_NUM,keyword];
    NSLog(@"%@",request_string);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:request_string]];
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

#pragma mark - implement NSURLconnection delegate methods 
//to deal with the returned data

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.data = [[NSMutableData alloc] init];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    /*UIAlertView *someError = [[UIAlertView alloc] initWithTitle:@"Connection Error" message: @"Unable to connect to searching server" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
     [someError show];*/
    NSLog(@"%@",connection.originalRequest.URL);
    NSLog(@"%@",error);
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection {     
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:self.data options:kNilOptions error:&error];
    NSLog(@"all %@",[json allKeys]);
    NSDictionary* responseData = [json objectForKey:@"responseData"];
    NSArray *results = [responseData objectForKey:@"results"];
    NSLog(@"get %d results",[results count]);
    NSString *url=[[results objectAtIndex:0] objectForKey:@"url"];
    NSLog(@"%@",url);
    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{    
        if ( data == nil )return;
        
        dispatch_async( dispatch_get_main_queue(),^{        
            // Add code here to update the UI/send notifications based on the        
            // results of the background processing    
            [self.myimageView setImage:[UIImage imageWithData:data]];
        });
    });

    /*
    NSDictionary *meta = [json objectForKey:@"meta"];
    NSNumber *meta_code=[meta objectForKey:@"code"];
    NSLog(@"%@",meta_code);
    
    NSMutableArray *searchResult = [NSMutableArray array];
    if ([meta_code intValue] == 200) {
        NSDictionary *response = [json objectForKey:@"response"];
        NSArray *venues=[response objectForKey:@"venues"];
        NSNumber *count =[NSNumber numberWithInt:[venues count]];
        NSLog(@"Have %@ elements",count);
        //start to put fetched data in to self.foursquareSearchResults
        for (NSDictionary *venue in venues) {
            FourSquarePlace *place = [FourSquarePlace initializeWithNSDictionary:venue];
            [searchResult addObject:place];
        }
    }
     */
}

#pragma mark - segue stuff
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ChooseImageTableViewController *temp =nil;
    temp=(ChooseImageTableViewController *)segue.destinationViewController;
    temp.predefinedKeyWord = @"stanford guest house";
    
}

@end
