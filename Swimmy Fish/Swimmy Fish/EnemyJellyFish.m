//
//  EnemyJellyFish.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 10/29/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "EnemyJellyFish.h"

@implementation EnemyJellyFish

- (id)initWithJellyFish {
    self = [super initWithImageNamed:@"JellyFish.png"];
    
    /* Setup the scaling */
    self.xScale = .25;
    self.yScale = .25;
    
    return self;
}

@end
