//
//  twitterPracticeViewController.m
//  WeiChatPratice
//
//  Created by Tongda Zhang on 7/28/12.
//  Copyright (c) 2012 Tongda Zhang. All rights reserved.
//

#import "twitterPracticeViewController.h"

@interface twitterPracticeViewController ()

@end

@implementation twitterPracticeViewController
@synthesize delegate=_delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    twitterPracticeAppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    self.delegate=(id)appDelegate;
    
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

- (IBAction)SendMessageToWeichat:(id)sender {
    [self.delegate sendText];
}
@end
