//
//  askViewController.h
//  Kitchen Sink
//
//  Created by Tongda Zhang on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class askViewController;

@protocol AskerViewControllerDelegate <NSObject>

-(void) askerViewController:(askViewController *)sender
               didAskQuestion:(NSString *)question
               andGotAnswer:(NSString *)answer;

@end

@interface askViewController : UIViewController
@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *answer;
@property (nonatomic, weak) id <AskerViewControllerDelegate> delegate;
@end
