//
//  TestUIView.m
//  ScrollViewPractice
//
//  Created by Tongda Zhang on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestUIView.h"

@implementation TestUIView
@synthesize Title=_Title;
@synthesize detail=_detail;
@synthesize imageView=_imageView;
@synthesize button=_button;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
    /*
    [self.imageView layer]
    [self.button layer];
     */
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
