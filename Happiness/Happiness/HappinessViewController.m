//
//  HappinessViewController.m
//  Happiness
//
//  Created by Tongda Zhang on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

@interface HappinessViewController() <FaceViewDataSource>
 
@property (weak, nonatomic) IBOutlet FaceView *faceview;

@end


@implementation HappinessViewController

@synthesize happiness = _happiness;
@synthesize faceview = _faceview;

-(void) setHappiness:(int)happiness{
    _happiness = happiness;
    [self.faceview setNeedsDisplay]; //redraw the view
}

-(void)setFaceview:(FaceView *)faceview{
    _faceview=faceview;
    [self.faceview addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceview action:@selector(pinch:)]];   //pinch recog
    [self.faceview addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handHappinessGesture:)]];
    self.faceview.dataSource =self;  //set the delegate
}

-(void)handHappinessGesture:(UIPanGestureRecognizer *)gesture{
    if ((gesture.state==UIGestureRecognizerStateChanged)||
        (gesture.state==UIGestureRecognizerStateEnded)) {
        CGPoint translation=[gesture translationInView:self.faceview];
        self.happiness -= translation.y /2 ;
        [gesture setTranslation:CGPointZero inView:self.faceview];
    }
}
     
-(float)smileForFaceView:(FaceView *)sender{
    return (self.happiness-50)/50.0;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
