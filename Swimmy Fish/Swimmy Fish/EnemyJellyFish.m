//
//  EnemyJellyFish.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 10/29/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "EnemyJellyFish.h"
#import "GameScene.h"

@implementation EnemyJellyFish

- (id)initWithJellyFish {
    SKTextureAtlas *jellyfishAtlas = [SKTextureAtlas atlasNamed:@"GameGraphics"];
    
    NSArray *jellyfishFramesArray = [NSArray arrayWithObjects:
                                     [jellyfishAtlas textureNamed:@"JellyFish-1"],
                                     [jellyfishAtlas textureNamed:@"JellyFish-2"],
                                     [jellyfishAtlas textureNamed:@"JellyFish-3"],
                                     [jellyfishAtlas textureNamed:@"JellyFish-4"], nil];
    
    
    self = [super initWithTexture:jellyfishFramesArray[0]];
    
    self.physicsBody = [SKPhysicsBody bodyWithTexture:self.texture size:self.size];
    self.physicsBody.categoryBitMask = enemyCategory;
    self.physicsBody.dynamic = NO;
    self.physicsBody.mass = 0;
    self.physicsBody.allowsRotation = NO;


    
    SKAction *moveDown = [SKAction moveBy:CGVectorMake(0, -100) duration:2];
    SKAction *moveUp = [SKAction moveBy:CGVectorMake(0, 100) duration:2];
    
    SKAction *moveUpDownForever = [SKAction repeatActionForever:[SKAction sequence:@[moveDown, moveUp]]];
    
    SKAction *animationAction = [SKAction repeatActionForever:[SKAction animateWithTextures:jellyfishFramesArray timePerFrame:0.1 resize:NO restore:YES]];
    
    [self runAction:[SKAction group:@[moveUpDownForever, animationAction]]];
    
    
    return self;
}

@end
