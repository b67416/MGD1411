//
//  Seaweed.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 10/29/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "Seaweed.h"
#import "GameScene.h"

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
    
    self.physicsBody = [SKPhysicsBody bodyWithTexture:self.texture size:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.mass = 0;
    self.physicsBody.categoryBitMask = seaweedCategory;
    self.physicsBody.allowsRotation = NO;
    
    return self;
}

@end
