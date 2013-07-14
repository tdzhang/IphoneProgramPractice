//
//  ScrollViewPracticeViewController.m
//  ScrollViewPractice
//
//  Created by Tongda Zhang on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScrollViewPracticeViewController.h"

@implementation ScrollViewPracticeViewController
@synthesize myScrollView;

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
    [self setMyScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSInteger numberOfViews = 3;
    //add 3 view in the scroll view
    for (int i = 0; i < numberOfViews; i++) {
        TestUIView *cell=nil;
        //add the self defined interface "testUI/MyTestUIView.xib"
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"MyTestUIView" owner:nil options:nil];
        
        for (UIView *view in views) {
            if([view isKindOfClass:[TestUIView class]])
            {
                cell = (TestUIView*)view;
            }
        }
        //set the layers of the cell
       /* CALayer *backLayer=[cell layer];
        CALayer *imageLayer=[cell.imageView layer];
        CALayer *buttonLayer=[cell.button layer];
        [buttonLayer insertSublayer:backLayer above:imageLayer];
    */
         
        //set the property of the cell
        [cell.Title setText:@"Title"];
        [cell.detail setText:@"Details~"];
        CGFloat xOrigin = i*self.view.frame.size.width;
        [cell setFrame:CGRectMake(xOrigin, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [cell setBackgroundColor:[UIColor colorWithRed:0.5/i green:0.5 blue:0.5 alpha:1]];
        //add the cell into the scroll view
        [self.myScrollView addSubview:cell];
    }
    //set the property of the sxcroll view
    self.myScrollView.contentSize =CGSizeMake(3*self.view.frame.size.width, self.view.frame.size.height);
    self.myScrollView.contentOffset = CGPointMake(0, 0);
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


#pragma mark - implement the UIScrollViewDelegate
//when the scrolling over，需要进行刷新操作
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"end here x=%f, y=%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    NSLog(@"the orginal width=%f height=%f",self.view.frame.size.width,self.view.frame.size.height);
    //当到底的时候。进行刷新操作。添加新的view进去等等
    if (scrollView.contentOffset.x>1.8*self.view.frame.size.width) {
        NSArray *views=self.myScrollView.subviews;
        for (UIView* view in views) {
            NSLog(@"center=  %f,%f",view.center.x,view.center.y);
            [view setCenter:CGPointMake(view.center.x+320, view.center.y)];
        }
    }
 
}

@end
