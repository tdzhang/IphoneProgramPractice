//
//  NotificationPracticeViewController.m
//  NotificationPractice
//
//  Created by Tongda Zhang on 7/29/12.
//  Copyright (c) 2012 Tongda Zhang. All rights reserved.
//

#import "NotificationPracticeViewController.h"

@interface NotificationPracticeViewController ()

@end

@implementation NotificationPracticeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


//local notification
- (IBAction)ScheduleALocalNotification:(id)sender {
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:29];
    [dateComps setMonth:7];
    [dateComps setYear:2012];
    [dateComps setHour:22];
    [dateComps setMinute:40];
    //NSDate *itemDate = [calendar dateFromComponents:dateComps];
    
    NSDate *itemDate = [NSDate date];
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = [itemDate dateByAddingTimeInterval:+5];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotif.alertBody = [NSString stringWithFormat:NSLocalizedString(@"%@ in %i minutes.", nil),
                            @"HAHA", 3];
    localNotif.alertAction = NSLocalizedString(@"View Details", nil);
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"HEIHEI" forKey:@"TODO"];
    localNotif.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

+ (void) handleReceivedNotification:(UILocalNotification*) thisNotification
{
	NSLog(@"Received: %@",[thisNotification description]);
    NSString*cate=[thisNotification.userInfo objectForKey:@"TODO"];
    NSLog(@"value:%@",cate);
	[UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber-1;
}

@end
