//
//  Seaweed.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 10/29/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "Seaweed.h"

@implementation Seaweed

- (id)initWithSeaweedBottom {
    return [self initWithSeaweed:NO];
}

- (id)initWithSeaweedTop {
    return [self initWithSeaweed:YES];
}

- (id)initWithSeaweed:(BOOL)isFlipped {
    if (isFlipped) {
        self = [super initWithImageNamed:@"Seaweed-Top"];
    } else {
        self = [super initWithImageNamed:@"Seaweed-Bottom"];
    }
    
    
    // Setup Physics //
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.mass = 0;
    self.physicsBody.collisionBitMask = 1;
    self.physicsBody.allowsRotation = NO;
    
    return self;
}

@end
