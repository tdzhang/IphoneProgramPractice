//
//  yelpElementObject.h
//  YelpTest
//
//  Created by Tongda Zhang on 8/5/12.
//  Copyright (c) 2012 Tongda Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface yelpElementObject : NSObject
@property(nonatomic,strong)NSString *category;
@property(nonatomic,strong)NSString *display_phone;
@property(nonatomic,strong)NSString *distance;
@property(nonatomic,strong)NSString *image_url;
@property(nonatomic,strong)NSString *display_address;
@property(nonatomic,strong)NSString *latitude;
@property(nonatomic,strong)NSString *longitude;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *rating;
@property(nonatomic,strong)NSString *rating_img_url;
@property(nonatomic,strong)NSString *review_count;
@property(nonatomic,strong)NSString *snippet_text;
@property(nonatomic,strong)NSString *mobile_url;

+(NSArray*)getArrayFromJson:(NSArray*)json;

@end
