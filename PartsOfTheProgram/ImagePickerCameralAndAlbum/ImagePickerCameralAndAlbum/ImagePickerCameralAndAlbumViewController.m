//
//  ImagePickerCameralAndAlbumViewController.m
//  ImagePickerCameralAndAlbum
//
//  Created by Tongda Zhang on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImagePickerCameralAndAlbumViewController.h"

@interface ImagePickerCameralAndAlbumViewController ()
@property (nonatomic, retain) UIImagePickerController *imgPicker;
@end

@implementation ImagePickerCameralAndAlbumViewController
@synthesize myImageView;
@synthesize imgPicker=_imgPicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.allowsEditing = YES;
    [self.imgPicker setDelegate:self];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"haha");
    }
    self.imgPicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary ;
    
    /*
     UIImagePickerControllerSourceTypeCamera : to load the camera
     UIImagePickerControllerSourceTypePhotoLibrary : to load images from library
     UIImagePickerControllerSourceTypeSavedPhotosAlbum : loads all images saved
     
     */
}

- (void)viewDidUnload
{
    [self setMyImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)chooseImage:(UIButton*)sender {
    [self presentModalViewController:self.imgPicker animated:YES];

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self.myImageView setImage:image];
    [self dismissModalViewControllerAnimated:YES];
    
}
@end
