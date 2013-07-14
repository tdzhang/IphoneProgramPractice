//
//  YelpTestViewController.m
//  YelpTest
//
//  Created by Tongda Zhang on 8/5/12.
//  Copyright (c) 2012 Tongda Zhang. All rights reserved.
//

#import "YelpTestViewController.h"

#import "OAuthConsumer.h"

@interface YelpTestViewController ()
@property (nonatomic,strong) NSMutableData* responseData;
@property (nonatomic,strong) NSArray *elements;
@end

@implementation YelpTestViewController
@synthesize responseData=_responseData;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
//-----------------------------------------------
- (IBAction)buttonclicked:(id)sender {
   // NSURL *URL = [NSURL URLWithString:@"http://api.yelp.com/v2/search?term=coffee&limit=3&sort=0&category_filter=food&ll=37.439224,-122.234144"];
     NSURL *URL = [NSURL URLWithString:@"http://api.yelp.com/v2/search?term=restaurants&location=new%20york"];
    OAConsumer *consumer = [[OAConsumer alloc] initWithKey:@"23oHa5rmIueIld73xqueeA" secret:@"XLdY-BNy8h3YKDcAHOU8HYoHCmw"];
    OAToken *token = [[OAToken alloc] initWithKey:@"2YIHKvMsb4WkxHW7rsOZG3CYPgXBmZf0" secret:@"zZuMa-Zx2w9TpTu1KeJnIhIjN2o"];
    
    id<OASignatureProviding, NSObject> provider = [[OAHMAC_SHA1SignatureProvider alloc] init] ;
    NSString *realm = nil;
    
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:URL
                                                                   consumer:consumer
                                                                      token:token
                                                                      realm:realm
                                                          signatureProvider:provider];
    [request prepare];
    _responseData = [[NSMutableData alloc] init];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];

}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error: %@, %@", [error localizedDescription], [error localizedFailureReason]);

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    NSLog(@"%@",json);
    self.elements=[yelpElementObject getArrayFromJson:[json objectForKey:@"businesses"]];
    for (yelpElementObject* element in self.elements) {
        NSLog(@"category:%@",element.category);
        NSLog(@"display_phone:%@",element.display_phone);
        NSLog(@"distance:%@",element.distance);
        NSLog(@"image_url:%@",element.image_url);
        NSLog(@"display_address:%@",element.display_address);
        NSLog(@"latitude:%@",element.latitude);
        NSLog(@"longitude:%@",element.longitude);
        NSLog(@"name:%@",element.name);
        NSLog(@"rating:%@",element.rating);
        NSLog(@"rating_img_url:%@",element.rating_img_url);
        NSLog(@"review_count:%@",element.review_count);
        NSLog(@"snippet_text:%@",element.snippet_text);
        NSLog(@"mobile_url:%@",element.mobile_url);
    }
}


- (IBAction)TimeButtonClicked:(id)sender {
    /*
    // Get current datetime
    NSDate *currentDateTime = [NSDate date];
    
    // Instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // Set the dateFormatter format
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    // Get the date time in NSString
    NSString *dateInString = [dateFormatter stringFromDate:currentDateTime];
    
    NSLog(@"%@",dateInString);

    
    NSDate *now = [NSDate date];
    NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
    [weekday setDateFormat: @"EEEE"];
    NSLog(@"The day of the week is: %@", [weekday stringFromDate:now]);
    */
    
    
    //next saturday
    NSDateComponents *weekdayComponents = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int currentWeekday = [weekdayComponents weekday]; //[1;7] ... 1 is sunday, 7 is saturday in gregorian calendar
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    if (6-currentWeekday<0) {
        [comp setDay:6 - currentWeekday+7];
    }
    [comp setDay:6 - currentWeekday];   // add some days so it will become sunday
 
    [comp setWeek:0];   // add weeks
        
    NSLog(@"%@",[[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:[NSDate date] options:0]);

    
    //tonight
    NSDateComponents *hourComponent = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:[NSDate date]];
    int hour = [hourComponent hour]; //[1;7] ... 1 is sunday, 7 is saturday in gregorian calendar
    
    NSDateComponents *hourComp= [[NSDateComponents alloc] init];
    if (23-currentWeekday<0) {
        [comp setDay:6 - currentWeekday+7];
    }
    [comp setDay:6 - currentWeekday];   // add some days so it will become sunday
    
    [comp setWeek:0];   // add weeks
    
    NSLog(@"%@",[[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:[NSDate date] options:0]);
    
    

    
}





@end
