//
//  ActionSheetPracticeViewController.h
//  ActionSheetPractice
//
//  Created by Tongda Zhang on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface ActionSheetPracticeViewController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *UserInputPart;
@property (strong, nonatomic) IBOutlet UIButton *doWhatButton;
-(IBAction)showActionSheet:(id)sender;
@end
