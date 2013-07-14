//
//  FourSquarePracticeViewController.m
//  FourSquarePractice
//
//  Created by Tongda Zhang on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FourSquarePracticeViewController.h"

@interface FourSquarePracticeViewController()
@property(nonatomic,retain) NSMutableData *data;
@end

@implementation FourSquarePracticeViewController
@synthesize myLabel;
@synthesize data=_data;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMyLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark - button action
- (IBAction)StartFetchingData:(id)sender {
    //submit request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.foursquare.com/v2/venues/search?ll=37.3,-122&oauth_token=ZH04LVGZECDJMXXQ4D1BHJXHBI1RIYNRMUTYKM3VSGZVMDAN&v=20120623"]];
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
    [self.myLabel setText:@"Unable to fetch data"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {            
    //translating the data
    //NSString *responseString = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",responseString);
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:self.data options:kNilOptions error:&error];
    NSLog(@"all %@",[json allKeys]);
    NSDictionary *meta = [json objectForKey:@"meta"];
    NSNumber *meta_code=[meta objectForKey:@"code"];
    NSLog(@"%@",meta_code);
    if ([meta_code intValue] == 200) {
        NSDictionary *response = [json objectForKey:@"response"];
        NSArray *venues=[response objectForKey:@"venues"];
        NSNumber *count =[NSNumber numberWithInt:[venues count]];
        //NSLog(@"Have %@ elements",count);
    
        [self.myLabel setText:[NSString stringWithFormat:@"Have found %@ venues.",count]];
        for (NSDictionary *venue in venues) {
            NSString *name=[venue objectForKey:@"name"];
            NSLog(@"name: %@",name);
            
            NSDictionary *location = [venue objectForKey:@"location"];
            NSString *address = [location objectForKey:@"address"];
            NSNumber *latitude = [location objectForKey:@"lat"];
            NSNumber *longitude = [location objectForKey:@"lng"];
            NSLog(@"address: %@",address);
            NSLog(@"long:%@  la%@",latitude,longitude);
        
        }

    }
    
        
}



@end

















