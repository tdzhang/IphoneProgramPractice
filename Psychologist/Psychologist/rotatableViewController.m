//
//  rotatableViewController.m
//  Psychologist
//
//  Created by Tongda Zhang on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "rotatableViewController.h"
#import "SplitViewBarButtonItemPresenter.h"

@implementation rotatableViewController

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.splitViewController.delegate =self;
}

-(id <SplitViewBarButtonItemPresenter>)splitViewBarButtonItemPresenter
{
    id detailVC=[self.splitViewController.viewControllers lastObject];
    if(![detailVC conformsToProtocol:@protocol(SplitViewBarButtonItemPresenter)]){
        detailVC=nil;
    }
    return detailVC;
}

-(BOOL)splitViewController:(UISplitViewController *)svc 
  shouldHideViewController:(UIViewController *)vc 
inOrientation:(UIInterfaceOrientation)orientation{
    return [self splitViewBarButtonItemPresenter]? UIInterfaceOrientationIsPortrait(orientation) : NO;
}

-(void)splitViewController:(UISplitViewController *)svc 
    willHideViewController:(UIViewController *)aViewController 
         withBarButtonItem:(UIBarButtonItem *)barButtonItem 
      forPopoverController:(UIPopoverController *)pc{
    barButtonItem.title=self.title;
    //tell the detail vew to put this button up
    [self splitViewBarButtonItemPresenter].SplitViewBarButtonItem = barButtonItem;
}

-(void)splitViewController:(UISplitViewController *)svc 
    willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    [self splitViewBarButtonItemPresenter].SplitViewBarButtonItem = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
