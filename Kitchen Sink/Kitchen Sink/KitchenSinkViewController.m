//
//  KitchenSinkViewController.m
//  Kitchen Sink
//
//  Created by Tongda Zhang on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KitchenSinkViewController.h"
#import "askViewController.h"

#define DRAIN_TIMER 5.0

@interface KitchenSinkViewController() <AskerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *kitchenSink;
@property (weak, nonatomic) NSTimer *drainTimer;
@end


@implementation KitchenSinkViewController
@synthesize kitchenSink=_kitchenSink;
@synthesize drainTimer = _drainTimer;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier hasPrefix:@"Create Label"]) {
        askViewController* asker=(askViewController *) segue.destinationViewController;
        asker.question=@"what do you want to say";
        asker.delegate= self;
       
    }
}

-(void)setRandomLocationForView:(UIView *)view{
    [view sizeToFit];
    CGRect sinkBounds = CGRectInset(self.kitchenSink.bounds,view.frame.size.width/2, view.frame.size.height/2);
    CGFloat x= arc4random() % (int)sinkBounds.size.width+view.frame.size.width/2;
    CGFloat y=arc4random() % (int)sinkBounds.size.height+view.frame.size.height/2;
    view.center=CGPointMake(x,y);
}


-()

-(void)startDraining{
    self.drainTimer = [NSTimer scheduledTimerWithTimeInterval:DRAIN_TIMER target:self selector:@selector(drain) userInfo:nil repeats:YES];
}

-(void)stopDraining{
    [self.drainTimer invalidate];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startDraining];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopDraining];
}

-(void)addLabel:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.text=text;
    label.font=[UIFont systemFontOfSize:48.0];
    label.backgroundColor=[UIColor clearColor];
    [self setRandomLocationForView:label];
    [self.kitchenSink addSubview:label];
}

-(void)askerViewController:(askViewController *)sender didAskQuestion:(NSString *)question andGotAnswer:(NSString *)answer{
    [self addLabel:answer];
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
