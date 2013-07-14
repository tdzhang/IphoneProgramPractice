//
//  twitterPracticeViewController.h
//  WeiChatPratice
//
//  Created by Tongda Zhang on 7/28/12.
//  Copyright (c) 2012 Tongda Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "twitterPracticeAppDelegate.h"

@protocol WEI <NSObject>

-(void)sendText;

@end

@interface twitterPracticeViewController : UIViewController
@property (nonatomic,weak)id<WEI>delegate;

@end
