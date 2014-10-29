//
//  Seaweed.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 10/29/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "Seaweed.h"

@implementation Seaweed

- (id)initWithSeaweed {
    self = [super initWithImageNamed:@"Seaweed.png"];
    
    /* Setup the scaling */
    self.xScale = .5;
    self.yScale = .5;
    
    return self;
}

@end
