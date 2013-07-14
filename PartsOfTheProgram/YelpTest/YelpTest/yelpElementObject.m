//
//  yelpElementObject.m
//  YelpTest
//
//  Created by Tongda Zhang on 8/5/12.
//  Copyright (c) 2012 Tongda Zhang. All rights reserved.
//

#import "yelpElementObject.h"

@interface yelpElementObject()

+(yelpElementObject *)getObjectByOneJson:(NSDictionary*)json;

@end

@implementation yelpElementObject
@synthesize category=_category;
@synthesize display_phone=_display_phone;
@synthesize distance=_distance;
@synthesize image_url=_image_url;
@synthesize display_address=_display_address;
@synthesize latitude=_latitude;
@synthesize longitude=_longitude;
@synthesize name=_name;
@synthesize rating=_rating;
@synthesize rating_img_url=_rating_img_url;
@synthesize review_count=_review_count;
@synthesize mobile_url=_mobile_url;


+(yelpElementObject *)getObjectByOneJson:(NSDictionary*)json{
    yelpElementObject *element=[yelpElementObject new];
    NSArray *categories=[json objectForKey:@"categories"];
    if ([categories count]>0) {
        element.category=[[categories objectAtIndex:0] objectAtIndex:0];
    }
    
    element.display_phone=[json objectForKey:@"display_phone"];
    element.distance=[json objectForKey:@"distance"];
    element.image_url=[json objectForKey:@"image_url"];
    
    NSDictionary* location=[json objectForKey:@"location"];
    NSArray* display_address=[location objectForKey:@"display_address"];
    element.display_address=[display_address componentsJoinedByString: @","];

    NSDictionary* coordinate=[location objectForKey:@"coordinate"];
element.latitude=[coordinate objectForKey:@"latitude"];
element.longitude=[coordinate objectForKey:@"longitude"];
element.name=[json objectForKey:@"name"];
element.rating=[json objectForKey:@"phone"];
element.rating_img_url=[json objectForKey:@"rating_img_url_large"];
element.review_count=[json objectForKey:@"review_count"];
element.mobile_url=[json objectForKey:@"rating_img_url_large"];

return element;
}

+(NSArray*)getArrayFromJson:(NSArray*)json{
    NSMutableArray* elements=[NSMutableArray array];
    for (NSDictionary* one in json) {
        [elements addObject:[yelpElementObject getObjectByOneJson:one]];
    }
    return [elements copy];
}

@end
