//
//  HappinessViewController.m
//  Happiness
//
//  Created by CS193p Instructor.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"
#import "MySmileTVC.h"

@interface HappinessViewController() <FaceViewDataSource>
@property (nonatomic, weak) IBOutlet FaceView *faceView;
@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;        // to put splitViewBarButtonitem in
@end

@implementation HappinessViewController

@synthesize happiness = _happiness;
@synthesize faceView = _faceView;
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;   // implementation of SplitViewBarButtonItemPresenter protocol
@synthesize toolbar = _toolbar;                                 // to put splitViewBarButtonItem in

// START CODE MODIFIED AFTER LECTURE

// Puts the splitViewBarButton in our toolbar (and/or removes the old one).
// Must be called when our splitViewBarButtonItem property changes
//  (and also after our view has been loaded from the storyboard (viewDidLoad)).
#define FAV_NAME_DIA @"TheTableOfSmiles.ABC"
#define FAVORITES_KEY @"CalculatorGraphViewController.Favorites"
- (IBAction)addDiagnosisResult:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favorites = [[defaults objectForKey:FAV_NAME_DIA] mutableCopy];
    if (!favorites) favorites = [NSMutableArray array];

    NSNumber *number=[NSNumber numberWithInt:self.happiness];
    [favorites addObject:number];
    //[favorites addObject:[[NSNumber alloc] initWithInt:self.happiness]];
    [defaults setObject:favorites forKey:FAV_NAME_DIA];
    [defaults synchronize];
    
    /*
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *fav=[[userDefault objectForKey:FAV_NAME_DIA] mutableCopy];
    if (!fav) {
        fav=[NSMutableArray array];
    }
    NSNumber *number=[NSNumber numberWithInt:self.happiness];
    
    [fav addObject:number];
    [userDefault setObject:fav forKey:FAV_NAME_DIA];
    [userDefault synchronize];
     */
}

- (void)handleSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem
{
    NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
    if (_splitViewBarButtonItem) [toolbarItems removeObject:_splitViewBarButtonItem];
    if (splitViewBarButtonItem) [toolbarItems insertObject:splitViewBarButtonItem atIndex:0];
    self.toolbar.items = toolbarItems;
    _splitViewBarButtonItem = splitViewBarButtonItem;
}

- (void)setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem
{
    if (splitViewBarButtonItem != _splitViewBarButtonItem) {
        [self handleSplitViewBarButtonItem:splitViewBarButtonItem];
    }
}

// viewDidLoad is callled after this view controller has been fully instantiated
//  and its outlets have all been hooked up.

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self handleSplitViewBarButtonItem:self.splitViewBarButtonItem];
}

// END CODE MODIFIED AFTER LECTURE

- (void)setHappiness:(int)happiness
{
    _happiness = happiness;
    [self.faceView setNeedsDisplay]; // any time our Model changes, redraw our View
}

- (void)setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    // enable pinch gestures in the FaceView using its pinch: handler
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
    // recognize a pan gesture and modify our Model
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappinessGesture:)]];
    self.faceView.dataSource = self;
}

- (void)handleHappinessGesture:(UIPanGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        CGPoint translation = [gesture translationInView:self.faceView];
        self.happiness -= translation.y / 2; // will update FaceView via setHappiness:
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }
}

- (float)smileForFaceView:(FaceView *)sender
{
    return (self.happiness - 50) / 50.0;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"regueForTable"]) {
        if ([segue.destinationViewController isKindOfClass:[MySmileTVC class]]) {
            NSArray *temp=[[NSUserDefaults standardUserDefaults] objectForKey:FAV_NAME_DIA];
            [segue.destinationViewController setSmiles:temp];
            [segue.destinationViewController setDelegate:self];
        }
    }
}

-(void)reDidTheSimle:(MySmileTVC *)sender choosenSmile:(id)smileChoosen{
    self.happiness=[smileChoosen intValue];
    [self.navigationController popViewControllerAnimated:YES];//pop the navigation controller stack, navigate to 上一级的视图
}


//the delegate implementation about delete a Table Element
-(void)deleteASmile:(MySmileTVC *)sender choosenSmile:(id)smileChoosen{
    NSMutableArray *favorates =[NSMutableArray array];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    for (id smile in [defaults objectForKey:FAV_NAME_DIA]) {
        if ([smile intValue] != [smileChoosen intValue]) {
            [favorates addObject:smile];
        }
    }
    [defaults setObject:favorates forKey:FAV_NAME_DIA];
    [defaults synchronize];
    sender.smiles=favorates;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES; // support all orientations
}

@end
