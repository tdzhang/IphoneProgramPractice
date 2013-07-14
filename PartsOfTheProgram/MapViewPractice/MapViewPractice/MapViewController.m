//
//  MapViewController.m
//  MapViewPractice
//
//  Created by Tongda Zhang on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

@interface  MapViewController()
@property (nonatomic, strong)MKPointAnnotation* annotation;
@property (nonatomic,strong)NSNumber* oldZoom;
@property (nonatomic,strong)NSNumber* currentZOOMVALUE;
@end

@implementation MapViewController
@synthesize myMapView=_myMapView;
@synthesize mySearchBar = _mySearchBar;
@synthesize myStepper = _myStepper;
@synthesize annotation=_annotation;
@synthesize delegate=_delegate;
@synthesize oldZoom=_oldZoom;
@synthesize currentZOOMVALUE=_currentZOOMVALUE;


-(void)setAnnotation:(MKPointAnnotation *)annotation
{
    if (self.myMapView.annotations) {
        [self.myMapView removeAnnotations:self.myMapView.annotations];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

//show User curent location
-(void)showUserCurrentLocation{
    MKMapView *mapView=self.myMapView;
    CLLocation *userLoc = mapView.userLocation.location;
    CLLocationCoordinate2D userCoordinate = userLoc.coordinate;

    MKCoordinateRegion region;
    MKCoordinateSpan span;
    CLLocationCoordinate2D location;
    span.latitudeDelta = DEFAULT_ZOOMING_SPAN_LATITUDE;
    span.longitudeDelta = DEFAULT_ZOOMING_SPAN_LONGITUDE;
    self.currentZOOMVALUE=[NSNumber numberWithDouble:DEFAULT_ZOOMING_SPAN_LONGITUDE];
    location.latitude=userCoordinate.latitude;
    location.longitude=userCoordinate.longitude;
    region.span=span;
    region.center=location;
    [mapView setRegion:region animated:YES];
    
    self.myStepper.minimumValue = 1;
    self.myStepper.maximumValue = 9;
    self.myStepper.stepValue = 1;
    self.myStepper.wraps = NO;
    self.myStepper.autorepeat = NO;
    self.myStepper.continuous = NO;   
    [self.myStepper setValue:5];
    self.oldZoom =[NSNumber numberWithDouble:5];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    MKMapView *mapView=self.myMapView;
    mapView.showsUserLocation=YES;
    mapView.mapType=MKMapTypeStandard;
    mapView.delegate=self;
    
    
    
    //只有第二次启动的时候，user location 才会有值
    CLLocation *userLoc = mapView.userLocation.location;
    CLLocationCoordinate2D userCoordinate = userLoc.coordinate;
    //NSLog(@"user latitude = %f",userCoordinate.latitude);
    //NSLog(@"user longitude = %f",userCoordinate.longitude);
    if (userCoordinate.latitude>0.001) {
        [self showUserCurrentLocation];
    }
    
    //add gesture recognizer for usering choosing locaiton
    UILongPressGestureRecognizer* lpgr =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration =0.25;
    lpgr.delegate = self;
    [self.myMapView addGestureRecognizer:lpgr];
    
    
    //initailize the zooming part
    self.myStepper.minimumValue = 1;
    self.myStepper.maximumValue = 9;
    self.myStepper.stepValue = 1;
    self.myStepper.wraps = NO;
    self.myStepper.autorepeat = NO;
    self.myStepper.continuous = NO;   
    [self.myStepper setValue:5];
    self.oldZoom =[NSNumber numberWithDouble:5];
}




- (void)viewDidUnload
{
    [self setMyMapView:nil];
    [self setMySearchBar:nil];
    [self setMyStepper:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - implement the Gesture related method
- (void) handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        /*
         Only handle state as the touches began
         set the location of the annotation
         */
        
        CLLocationCoordinate2D coordinate = [self.myMapView convertPoint:[gestureRecognizer locationInView:self.myMapView] toCoordinateFromView:self.myMapView];
        
        // Do anything else with the coordinate as you see fit in your application
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = coordinate;
        annotationPoint.title=@"You Choose Here:";
        annotationPoint.subtitle=[NSString stringWithFormat:@"Latitude:%f, Longitute:%f",coordinate.latitude,coordinate.longitude];
        self.annotation=annotationPoint;
        [self.myMapView addAnnotation:annotationPoint];
        [self.myMapView selectAnnotation:annotationPoint animated:YES];
        /*//reset the MapView region
        MKCoordinateRegion region;
        region.center=coordinate;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.005;
        span.longitudeDelta = 0.005;
        region.span = span;
        [self.myMapView setRegion:region animated:YES];
         */
    }
}

#pragma mark - implement the Stepper part (ZooMing)
- (IBAction)Zooming:(id)sender {
    double oldzoom=[self.oldZoom doubleValue];
    double zoom = self.myStepper.value;
    NSLog(@"oldzoom: %f",oldzoom);
    NSLog(@"zoom: %f",zoom);
    double la,lo;
    if (zoom<oldzoom) {
        la=[self.currentZOOMVALUE doubleValue]*ZOOM_RATIO;
        lo=[self.currentZOOMVALUE doubleValue]*ZOOM_RATIO;
        self.currentZOOMVALUE = [NSNumber numberWithDouble:la];
    }else{
        la=[self.currentZOOMVALUE doubleValue]/ZOOM_RATIO;
        lo=[self.currentZOOMVALUE doubleValue]/ZOOM_RATIO;
         self.currentZOOMVALUE = [NSNumber numberWithDouble:la];
    }
    self.oldZoom = [NSNumber numberWithDouble:zoom];
    MKCoordinateRegion region;
    CLLocationCoordinate2D coordinate;
   
    coordinate.latitude= self.myMapView.centerCoordinate.latitude;
    coordinate.longitude= self.myMapView.centerCoordinate.longitude;
    region.center=coordinate;
    MKCoordinateSpan span;
    span.latitudeDelta = la;
    span.longitudeDelta = lo;
    region.span = span;
    [self.myMapView setRegion:region animated:YES];

}

- (IBAction)returnToMyLocation {
    [self showUserCurrentLocation];
}


#pragma mark - implement the UISeachBar protocal
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:searchBar.text completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSLog(@"size: %d",[placemarks count]);
        MKCoordinateRegion region;
        region.center.latitude = placemark.region.center.latitude;
        region.center.longitude = placemark.region.center.longitude;
        
        /*
        MKCoordinateSpan span;
        double radius = placemark.region.radius / 1000; // convert to km
        NSLog(@"Radius is %f", radius);
        span.latitudeDelta = radius / 112.0;
        region.span = span;
        */
        MKCoordinateSpan span;
        span.latitudeDelta = DEFAULT_ZOOMING_SPAN_LATITUDE;
        span.longitudeDelta=DEFAULT_ZOOMING_SPAN_LONGITUDE;
        region.span = span;
        
        //add annotation
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = placemark.region.center;
        annotationPoint.title = placemark.name;
        if(!annotationPoint.title)annotationPoint.title=@"NO name:";
            annotationPoint.subtitle = placemark.locality;
        if(!annotationPoint.subtitle)annotationPoint.subtitle=@"No subtitle name.";
        self.annotation=annotationPoint;
        [self.myMapView addAnnotation:annotationPoint];
        [self.myMapView setRegion:region animated:YES];
    }];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setText:@""];
    [searchBar resignFirstResponder];
}

#pragma mark - implement the map view protocal
//when the user location update happen
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    [self showUserCurrentLocation];
}

//create the annnotation view
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
    if(!aView){
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
        aView.canShowCallout = YES;
        //add left image view 30*30
        //aView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
    }
    aView.annotation=annotation;
    
    //add button on the right of the annotation detail
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeContactAdd];
    [rightButton setTitle:@"Choose" forState:UIControlStateNormal];
    aView.rightCalloutAccessoryView = rightButton;
    
    [(UIImageView *)aView.leftCalloutAccessoryView setImage:nil];
 
    return aView;
}



//did something when user touch the pin
/*-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //add image (can define a delegate and using delegate method to get a related image back)
    //UIImage *image=nil;
    //[(UIImageView *)view.leftCalloutAccessoryView setImage:image];
}*/


//do the right thing when user tap the button of the annotation
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    if ([(UIButton*)control buttonType]==UIButtonTypeContactAdd) {
        //do somthing and return
        if ([self.delegate conformsToProtocol:@protocol(SelfChooseLocation)]) {
            [self.delegate UpdateLocation:view sendFrom:self];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end










