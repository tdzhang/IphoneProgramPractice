//
//  CoreDataPractiveTVC.h
//  CoreDataPractice
//
//  Created by Tongda Zhang on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataPractiveTVC : UITableViewController
@property (nonatomic, retain) NSMutableArray *eventsArray;
@property (nonatomic, retain) UIBarButtonItem *addButton;
@property (nonatomic, retain) UIManagedDocument *document;
@end
