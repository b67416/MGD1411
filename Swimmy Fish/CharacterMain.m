//
//  CharacterMain.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 10/29/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "CharacterMain.h"
#import "GameScene.h"

@implementation CharacterMain
{
    SKAction *actionFishWhack;
    SKAction *sfxFishWhack;
}

- (id)initWithCharacter {
    self = [super initWithImageNamed:@"mainCharacter"];
    
    if (self) {
        // Preload actions and SFX //
        
        actionFishWhack = [SKAction sequence:@[[SKAction scaleXTo:-(self.xScale) duration:.25],
                                               [SKAction scaleXTo:self.xScale duration:.25]]];
                           
        sfxFishWhack = [SKAction playSoundFileNamed:@"fishWhack.mp3" waitForCompletion:NO];
        
        
        
        // Setup Physics //
        
        self.physicsBody = [SKPhysicsBody bodyWithTexture:self.texture size:self.size];
        self.physicsBody.dynamic = YES;
        self.physicsBody.mass = 0;
        self.physicsBody.categoryBitMask = mainCharacterCategory;
        self.physicsBody.contactTestBitMask = enemyCategory;
        self.physicsBody.collisionBitMask = seaweedCategory;
        self.physicsBody.allowsRotation = NO;
    }
    
    return self;
}

-(void)whack {
    // Spin the fish sprite and play SFX //
    
    if (self.hasActions == NO) {
        [self runAction:[SKAction group:@[actionFishWhack, sfxFishWhack]]];
    }
}

@end
