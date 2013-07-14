//
//  ButtonAnimationPracticeViewController.m
//  ButtonAnimationPractice
//
//  Created by Tongda Zhang on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ButtonAnimationPracticeViewController.h"

#define ANIMATION_TIME_DURATION 0.7

@interface ButtonAnimationPracticeViewController ()
@property (nonatomic,strong)UIButton* buttonA;
@property (nonatomic,strong)UIButton* buttonB;
@property (nonatomic,strong)UIButton* buttonC;
@property (nonatomic)BOOL flag;
-(void)aMethod:(UIButton*)sender;
@end

@implementation ButtonAnimationPracticeViewController
@synthesize flag=_flag;
@synthesize buttonA=_buttonA;
@synthesize buttonB=_buttonB;
@synthesize buttonC=_buttonC;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //set the show flag to NO;
    self.flag=NO;
    //////////////////////////
    self.buttonA = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.buttonA addTarget:self 
                     action:@selector(aMethod:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.buttonA setTitle:@"A" forState:UIControlStateNormal];
    self.buttonA.frame = CGRectMake(10.0, 370.0, 25.0, 25.0);
    [self.buttonA setHidden:YES];
    [self.view addSubview:self.buttonA];
    
    //////////////////////////
    self.buttonB = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.buttonB addTarget:self 
                     action:@selector(aMethod:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.buttonB setTitle:@"B" forState:UIControlStateNormal];
    self.buttonB.frame = CGRectMake(10.0, 370.0, 25.0, 25.0);
    [self.buttonB setHidden:YES];
    [self.view addSubview:self.buttonB];
    
    //////////////////////////
    self.buttonC = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.buttonC addTarget:self 
                     action:@selector(aMethod:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.buttonC setTitle:@"C" forState:UIControlStateNormal];
    self.buttonC.frame = CGRectMake(10.0, 370.0, 25.0, 25.0);
    [self.buttonC setHidden:YES];
    [self.view addSubview:self.buttonC];
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
- (IBAction)AddNewButton:(id)sender {
    if (self.flag==NO) {
        self.buttonA.frame = CGRectMake(10.0, 370.0, 25.0, 25.0);
        self.buttonB.frame = CGRectMake(10.0, 370.0, 25.0, 25.0);
        self.buttonC.frame = CGRectMake(10.0, 370.0, 25.0, 25.0);
        [self.buttonA setHidden:NO];
        [self.buttonA setAlpha:0];
        [self.buttonB setHidden:NO];
        [self.buttonB setAlpha:0];
        [self.buttonC setHidden:NO];
        [self.buttonC setAlpha:0];
        
        CABasicAnimation *fullRotation;
        fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.fromValue = [NSNumber numberWithFloat:0];
        fullRotation.toValue = [NSNumber numberWithFloat:((10*M_PI))];
        fullRotation.duration = ANIMATION_TIME_DURATION;
        fullRotation.repeatCount = 1;
        [self.buttonA.layer addAnimation:fullRotation forKey:@"360"];
        [self.buttonB.layer addAnimation:fullRotation forKey:@"360"];
        [self.buttonC.layer addAnimation:fullRotation forKey:@"360"];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelay:0.0];
        [UIView setAnimationDuration:ANIMATION_TIME_DURATION];
        self.buttonA.frame = CGRectMake(10.0, 290.0, 25.0, 25.0);
        self.buttonB.frame = CGRectMake(80.0, 295.0, 25.0, 25.0);
        self.buttonC.frame = CGRectMake(80.0, 370.0, 25.0, 25.0);
        [self.buttonA setAlpha:1];
        [self.buttonB setAlpha:1];
        [self.buttonC setAlpha:1];
        [UIView commitAnimations];
        self.flag=YES;
    }
    else{
        CABasicAnimation *fullRotation;
        fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.fromValue = [NSNumber numberWithFloat:0];
        fullRotation.toValue = [NSNumber numberWithFloat:((10*M_PI))];
        fullRotation.duration = ANIMATION_TIME_DURATION;
        fullRotation.repeatCount = 1;
        [self.buttonA.layer addAnimation:fullRotation forKey:@"360"];
        [self.buttonB.layer addAnimation:fullRotation forKey:@"360"];
        [self.buttonC.layer addAnimation:fullRotation forKey:@"360"];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelay:0.0];
        [UIView setAnimationDuration:ANIMATION_TIME_DURATION];
        self.buttonA.frame = CGRectMake(10.0, 370.0, 25.0, 25.0);
        self.buttonB.frame = CGRectMake(10.0, 370.0, 25.0, 25.0);
        self.buttonC.frame = CGRectMake(10.0, 370.0, 25.0, 25.0);
        [self.buttonA setAlpha:0];
        [self.buttonB setAlpha:0];
        [self.buttonC setAlpha:0];
        [UIView commitAnimations];
        self.flag=NO;
    }
    
}

-(void)performClose:(id)sender{
    
    [self.buttonA.layer removeAllAnimations];
    [self.buttonB.layer removeAllAnimations];
    [self.buttonC.layer removeAllAnimations];
    [self.buttonA setHidden:YES];
    [self.buttonB setHidden:YES];
    [self.buttonC setHidden:YES];
    [self performSegueWithIdentifier:@"1" sender:self];
}

-(void)aMethod:(UIButton*)sender{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationDuration:ANIMATION_TIME_DURATION];
    //sender.frame = CGRectMake(100.0, 210.0, 160.0, 40.0);
    [sender setTransform:CGAffineTransformMakeScale(40, 40)];
    [sender setAlpha:0];
    [UIView commitAnimations];
    

    [self performSelector:@selector(performClose:) withObject:sender afterDelay:ANIMATION_TIME_DURATION];

}


@end
