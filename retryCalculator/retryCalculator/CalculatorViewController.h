//
//  CalculatorViewController.h
//  retryCalculator
//
//  Created by Tongda Zhang on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (strong,nonatomic) NSMutableDictionary *diction;

@end
