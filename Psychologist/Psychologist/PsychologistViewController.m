//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by Tongda Zhang on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"

@interface PsychologistViewController()
@property (nonatomic) int diagnosis;
@end


@implementation PsychologistViewController
@synthesize diagnosis=_diagnosis;

-(HappinessViewController *)splitViewHappinessViewController{
    //get detail view controller for ipad
    id hvc=[self.splitViewController.viewControllers lastObject];
    if (![hvc isKindOfClass:[HappinessViewController class]]){
        hvc =nil;
    }
    return hvc;
}

-(void) setAndShowDiagnosis:(int) diagnosis{
    self.diagnosis=diagnosis;
    
    //if it's ipad
    if ([self splitViewHappinessViewController]) {
        [self splitViewHappinessViewController].happiness = diagnosis;
    }
    else{
        [self performSegueWithIdentifier:@"showDiagnosis" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDiagnosis"]) {
        [segue.destinationViewController setHappiness:self.diagnosis];
    }
    else if([segue.identifier isEqualToString:@"celebrity"]){
        [segue.destinationViewController setHappiness:68];
    }
    else if([segue.identifier isEqualToString:@"problem"]){
        [segue.destinationViewController setHappiness:28];
    }
    else if([segue.identifier isEqualToString:@"TV"]){
        [segue.destinationViewController setHappiness:168];
    }
}

- (IBAction)flying {
    [self setAndShowDiagnosis:85];
}

- (IBAction)apple {
    [self setAndShowDiagnosis:100];
}

- (IBAction)running {
    [self setAndShowDiagnosis:20];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
