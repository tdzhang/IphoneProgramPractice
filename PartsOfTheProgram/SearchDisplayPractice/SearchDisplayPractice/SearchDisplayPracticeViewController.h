//
//  SearchDisplayPracticeViewController.h
//  SearchDisplayPractice
//
//  Created by Tongda Zhang on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchDisplayPracticeViewController : UIViewController <UISearchDisplayDelegate>

@property (nonatomic,strong) NSArray *items;
@property (nonatomic,strong) NSArray *result;
@end



