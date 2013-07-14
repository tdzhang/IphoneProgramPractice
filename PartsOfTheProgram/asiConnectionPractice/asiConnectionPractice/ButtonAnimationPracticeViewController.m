//
//  ButtonAnimationPracticeViewController.m
//  asiConnectionPractice
//
//  Created by Tongda Zhang on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ButtonAnimationPracticeViewController.h"
#import "ASIFormDataRequest.h"


@interface ButtonAnimationPracticeViewController ()

@end

@implementation ButtonAnimationPracticeViewController

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
- (IBAction)sendFormData:(id)sender {
    NSURL *url=[NSURL URLWithString:@"http://www.funnect.me/events/add"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    __block ASIFormDataRequest *block_request=request;
    [request setCompletionBlock:^{
        // Use when fetching text data
        NSString *responseString = [block_request responseString];
        NSLog(@"%@",responseString);
        // Use when fetching binary data
        //NSData *responseData = [request responseData];
    }];
    [request setFailedBlock:^{
        NSError *error = [block_request error];
        NSLog(@"%@",error.description);
    }];
    
    [request setPostValue:@"1" forKey:@"user_id"];
    [request setPostValue:@"Watch PERMItus" forKey:@"title"];
    [request setPostValue:@"106 Mcfarland ct." forKey:@"address"];
    [request setPostValue:@"stanford ave." forKey:@"location"];
    NSData *data=UIImagePNGRepresentation([UIImage imageNamed:@"1234.png"]);
    [request setData:data withFileName:@"1234.png" andContentType:@"image/png" forKey:@"image"];
    [request setRequestMethod:@"POST"];
    [request startAsynchronous];

}

@end
