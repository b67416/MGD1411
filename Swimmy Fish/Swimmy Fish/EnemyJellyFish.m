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
    
    SKAction *moveDown = [SKAction moveBy:CGVectorMake(0, -100) duration:2];
    SKAction *moveUp = [SKAction moveBy:CGVectorMake(0, 100) duration:2];
    
    SKAction *moveUpDownForever = [SKAction repeatActionForever:[SKAction sequence:@[moveDown, moveUp]]];
    
    [self runAction:moveUpDownForever];
    
    return self;
}

@end
