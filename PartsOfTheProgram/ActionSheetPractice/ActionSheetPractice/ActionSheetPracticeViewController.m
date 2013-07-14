//
//  ActionSheetPracticeViewController.m
//  ActionSheetPractice
//
//  Created by Tongda Zhang on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActionSheetPracticeViewController.h"

@implementation ActionSheetPracticeViewController
@synthesize UserInputPart;
@synthesize doWhatButton;

#pragma mark - stuff related to action sheet
-(IBAction)showActionSheet:(id)sender{
    UIActionSheet *pop=[[UIActionSheet alloc] initWithTitle:@"Mytitle" delegate:self cancelButtonTitle:@"Mycancel" destructiveButtonTitle:@"Mydestructive" otherButtonTitles:@"self define",@"other button2", nil];
    pop.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    [pop showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self.doWhatButton setTitle:@"destructive" forState:UIControlStateNormal];
    }else if(buttonIndex == 1){
        [self.UserInputPart setHidden:NO];
        [self.UserInputPart becomeFirstResponder];
        [self.doWhatButton setTitle:@"" forState:UIControlStateNormal];
    }else if(buttonIndex == 2){
        [self.doWhatButton setTitle:@"other 2" forState:UIControlStateNormal];
    }else if(buttonIndex == 3){
        [self.doWhatButton setTitle:@"cancel" forState:UIControlStateNormal];
    }
}

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
    [self.UserInputPart setHidden:YES];
    [self.UserInputPart setDelegate:self];
}

- (void)viewDidUnload
{
    [self setDoWhatButton:nil];
    [self setUserInputPart:nil];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - implemenmt protocal
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.UserInputPart.text length]==0) {
        UIAlertView *inputEmptyError = [[UIAlertView alloc] initWithTitle:@"Input Empty" message:@"You did not input anything" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [inputEmptyError show];
        [self.UserInputPart becomeFirstResponder];
    }
    [self.UserInputPart resignFirstResponder];
    [self.doWhatButton setTitle:self.UserInputPart.text forState:UIControlStateNormal];
    [self.UserInputPart setHidden:YES];
    return YES;
}


@end
