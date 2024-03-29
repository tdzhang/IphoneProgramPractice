//
//  HappinessViewController.h
//  Happiness
//
//  Created by CS193p Instructor.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySmileTVC.h"
#import "SplitViewBarButtonItemPresenter.h"

@interface HappinessViewController : UIViewController <SplitViewBarButtonItemPresenter,MySmileTVCdelegate>

@property (nonatomic) int happiness;  // 0 is sad; 100 is very happy

@end
