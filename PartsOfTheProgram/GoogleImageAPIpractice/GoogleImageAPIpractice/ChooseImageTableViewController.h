//
//  ChooseImageTableViewController.h
//  GoogleImageAPIpractice
//
//  Created by Tongda Zhang on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageTableViewCell.h"

#define GOOGLE_IMAGE_NUM 8 //between 1~8
#define DEFAULT_IMAGE_REPLACEMENT @"big40.jpg" //to replace the image which cannot get the 

@interface ChooseImageTableViewController : UITableViewController<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (nonatomic,strong) NSString *predefinedKeyWord; //used for predefined search keywords
@end
