//
//  CalculatorViewController.m
//  retryCalculator
//
//  Created by Tongda Zhang on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController
@synthesize display;
@synthesize diction=_diction;

-(NSMutableDictionary *)diction{
    if (_diction==nil){
        _diction=[NSMutableDictionary dictionary];
        [_diction setObject:@"123" forKey:@"gg"];
    }
    return _diction;
}

- (IBAction)buttonPressed:(UIButton *)sender {
    //self.display.text=[sender currentTitle];
    self.display.text=[self.diction valueForKey:@"gg"];
}

@end
