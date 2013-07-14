//
//  MySmileTVC.h
//  Psychologist
//
//  Created by Tongda Zhang on 6/15/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MySmileTVC;

@protocol MySmileTVCdelegate

@optional
-(void)reDidTheSimle:(MySmileTVC *)sender
        choosenSmile:(id)smileChoosen;
-(void)deleteASmile:(MySmileTVC *)sender
       choosenSmile:(id)smileChoosen;
@end

@interface MySmileTVC : UITableViewController
@property (strong, nonatomic) NSArray *smiles;
@property (nonatomic,weak) id <MySmileTVCdelegate> delegate;
@end
