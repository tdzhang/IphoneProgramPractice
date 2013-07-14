//
//  ImagePickerCameralAndAlbumViewController.h
//  ImagePickerCameralAndAlbum
//
//  Created by Tongda Zhang on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickerCameralAndAlbumViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end
