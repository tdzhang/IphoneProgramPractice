//
//  ScrollViewPracticeViewController.h
//  ScrollViewPractice
//
//  Created by Tongda Zhang on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestUIView.h"
#import <QuartzCore/QuartzCore.h>

@interface ScrollViewPracticeViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@end
