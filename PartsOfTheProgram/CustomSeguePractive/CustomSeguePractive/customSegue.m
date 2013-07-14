//
//  customSegue.m
//  CustomSeguePractive
//
//  Created by Tongda Zhang on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "customSegue.h"

@implementation customSegue
- (void) perform {
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    
    [UIView transitionWithView:src.navigationController.view duration:2
                    options:UIViewAnimationOptionTransitionCurlUp
                    animations:^{
                        [src.navigationController pushViewController:dst animated:NO];
                    }
                    completion:NULL];
}
@end













/*
 - (void) perform {
 UIViewController *src = (UIViewController *) self.sourceViewController;
 UIViewController *dst = (UIViewController *) self.destinationViewController;
 
 [UIView transitionWithView:src.navigationController.view duration:0.2
 options:UIViewAnimationOptionTransitionFlipFromLeft
 animations:^{
 [src.navigationController pushViewController:dst animated:NO];
 }
 completion:NULL];
 }
*/