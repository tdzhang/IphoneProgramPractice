//
//  TimeAndDatePickerViewController.h
//  TimeAndDatePicker
//
//  Created by Tongda Zhang on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeChooseViewController.h"
@interface TimeAndDatePickerViewController : UIViewController<TimeChooseProtocal>
@property (weak, nonatomic) IBOutlet UILabel *ShowDate;

@end
