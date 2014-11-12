//
//  GameScene.h
//  Swimmy Fish
//

//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@end

static const uint32_t mainCharacterCategory = 0x1 << 0;
static const uint32_t seaweedCategory = 0x1 << 1;
static const uint32_t enemyCategory = 0x1 << 2;