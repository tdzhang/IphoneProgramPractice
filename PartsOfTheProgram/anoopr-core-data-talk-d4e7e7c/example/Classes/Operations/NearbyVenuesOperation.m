//
//  NearbyVenuesOperation.m
//  CoreDataTalk
//
//  Created by Anoop Ranganath on 1/22/11.
//  Copyright 2011 Anoop Ranganath. All rights reserved.
//

#import "NearbyVenuesOperation.h"
#import "Constants.h"
#import "Venue.h"
#import "Category.h"

@implementation NearbyVenuesOperation

- (id)initWithLocation:(CLLocation *)location {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [defaults objectForKey:@"access_token"];
	NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%f,%f&oauth_token=%@",
						   location.coordinate.latitude, 
						   location.coordinate.longitude,
						   accessToken];

    self = [super initWithURL:[NSURL URLWithString:urlString]];
    if (self) {
    }
    return self;
}

- (void)updateManagedObjectContext:(NSManagedObjectContext *)moc {
	// A hacky way to get the Nearby Venues. Don't do this in your app.
	NSArray *nearbyVenuesDicts = [[[[self.responseDictionary objectForKey:@"response"] objectForKey:@"groups"] lastObject] objectForKey:@"items"];
	
	[Venue primeCacheWithIds:[nearbyVenuesDicts valueForKeyPath:@"id"] relationshipKeyPaths:[NSArray arrayWithObject:@"categories"] managedObjectContext:moc];
	[Category primeCacheWithIds:[nearbyVenuesDicts valueForKeyPath:@"categories.id"] managedObjectContext:moc];
	
	for (NSDictionary *venueDict in nearbyVenuesDicts) {
		[Venue updateOrInsertWithDictionary:venueDict managedObjectContext:moc];
	}
	
	[Category flushCache];
	[Venue flushCache];
}

@end
