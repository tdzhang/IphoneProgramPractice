//
//  MapViewPracticeViewController.h
//  MapViewPractice
//
//  Created by Tongda Zhang on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface MapViewPracticeViewController : UIViewController<SelfChooseLocation>
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
