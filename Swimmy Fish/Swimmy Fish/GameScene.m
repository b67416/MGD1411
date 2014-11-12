//
//  GameScene.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 10/29/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "GameScene.h"
#import "CharacterMain.h"
#import "Seaweed.h"
#import "EnemyJellyFish.h"

@implementation GameScene
{
    SKNode *gamePlayNode;
    CharacterMain *characterMain;
    SKAction *sfxSwimUp;
    
    BOOL isCharacterAccelerating;
    NSTimeInterval lastUpdatedTime;
    
    NSInteger seaweedCurrentPosition;
    NSTimeInterval deltaTimeCounter;
    
    SKSpriteNode *buttonWhackSpriteNode;
    
    SKSpriteNode *buttonPauseSpriteNode;
    SKLabelNode *pausedLabelNode;
}

-(void)didMoveToView:(SKView *)view {
    // Setup your scene here //
    
    self.backgroundColor = [SKColor colorWithRed:0.4f green:0.6f blue:1.0f alpha:1.0f];
    
    gamePlayNode = [SKNode node];
    gamePlayNode.position = CGPointZero;
    [self addChild:gamePlayNode];
    
    
    // Setup the Physics //
    
    self.physicsWorld.gravity = CGVectorMake(0, -4);
    
    SKNode *worldBottomBoundryNode = [SKNode node];
    worldBottomBoundryNode.position = CGPointZero;
    worldBottomBoundryNode.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 10) toPoint:CGPointMake(self.size.width, 10)];
    worldBottomBoundryNode.physicsBody.collisionBitMask = 1;
    [self addChild:worldBottomBoundryNode];
    
    SKNode *worldTopBoundryNode = [SKNode node];
    worldTopBoundryNode.position = CGPointZero;
    worldTopBoundryNode.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, self.size.height - 10) toPoint:CGPointMake(self.size.width, self.size.height - 10)];
    worldTopBoundryNode.physicsBody.collisionBitMask = 1;
    [self addChild:worldTopBoundryNode];
    
    
    
    // Setup the fish whack button //
    
    buttonWhackSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"buttonWhack"];
    buttonWhackSpriteNode.position = CGPointMake((buttonWhackSpriteNode.size.width / 2), buttonWhackSpriteNode.size.height / 2);
    buttonWhackSpriteNode.zPosition = 99;
    [self addChild:buttonWhackSpriteNode];
    
    // Setup the pause button //
    buttonPauseSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"buttonPause"];
    buttonPauseSpriteNode.xScale = .5;
    buttonPauseSpriteNode.yScale = .5;
    buttonPauseSpriteNode.alpha = .75;
    buttonPauseSpriteNode.position = CGPointMake(self.size.width - (buttonPauseSpriteNode.size.width / 2), self.size.height - (buttonPauseSpriteNode.size.height / 2));
    buttonPauseSpriteNode.zPosition = 99;
    [self addChild:buttonPauseSpriteNode];
    
    pausedLabelNode = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
    pausedLabelNode.text = @"Game Paused";
    pausedLabelNode.fontColor = [SKColor yellowColor];
    pausedLabelNode.fontSize = 50;
    pausedLabelNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    // Setup the main character fish //
    
    characterMain = [[CharacterMain alloc] initWithCharacter];
    characterMain.position = CGPointMake(100, 100);
    [gamePlayNode addChild:characterMain];
    
    
    
    // Setup the seaweed //
    
    seaweedCurrentPosition = 0;
    [self addNewSeaweed];
    
    
    
    // Setup the Enemy Jelly Fish //
    
    EnemyJellyFish *enemyJellyFish = [[EnemyJellyFish alloc] initWithJellyFish];
    enemyJellyFish.position = CGPointMake(500, 250);
    [gamePlayNode addChild:enemyJellyFish];
    
    
    
    // Preload the SFX //
    
    sfxSwimUp = [SKAction playSoundFileNamed:@"swim.mp3" waitForCompletion:NO];
}

-(void)addNewSeaweed {
    Seaweed *seaweedBottom = [[Seaweed alloc] initWithSeaweedBottom];
    seaweedBottom.position = CGPointMake(seaweedCurrentPosition + 200, seaweedBottom.size.height / 2);
    [gamePlayNode addChild:seaweedBottom];
    
    Seaweed *seaweedTop = [[Seaweed alloc] initWithSeaweedTop];
    seaweedTop.position = CGPointMake(seaweedCurrentPosition + 400, self.view.bounds.size.height - (seaweedTop.size.height / 2));
    [gamePlayNode addChild:seaweedTop];
    
    seaweedCurrentPosition = seaweedCurrentPosition + 400;
}

-(void)pauseGame:(BOOL)shouldPause {
    if (shouldPause) {
        gamePlayNode.paused = YES;
        gamePlayNode.alpha = .5;
        
        self.physicsWorld.speed = 0;
        
        [buttonWhackSpriteNode removeFromParent];
        
        buttonPauseSpriteNode.alpha = 1;
        
        [self addChild:pausedLabelNode];
    } else {
        gamePlayNode.paused = NO;
        gamePlayNode.alpha = 1;
        
        self.physicsWorld.speed = 1;
        
        [self addChild:buttonWhackSpriteNode];
        
        buttonPauseSpriteNode.alpha = .75;
        
        [pausedLabelNode removeFromParent];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if (gamePlayNode.paused) {
        if ([buttonPauseSpriteNode containsPoint:location]) {
            [self pauseGame:NO];
        }
    } else {
        if ([buttonWhackSpriteNode containsPoint:location]) {
            [characterMain whack];
        } else if ([buttonPauseSpriteNode containsPoint:location]) {
            [self pauseGame:YES];
        } else {
            [characterMain runAction:sfxSwimUp];
            [characterMain.physicsBody setVelocity:CGVectorMake(0, 0)];
            [characterMain.physicsBody applyImpulse:CGVectorMake(150, 300)];
        }
    }
}

-(void)didSimulatePhysics {
    // Update the camera to follow the main fish //
    
    gamePlayNode.position = CGPointMake(200 - characterMain.position.x, 0);
}

-(void)update:(NSTimeInterval)currentTime {

    NSTimeInterval deltaTime = currentTime - lastUpdatedTime;
    lastUpdatedTime = currentTime;

    
    
    // Add new seaweed after 2-ish seconds //
    if (gamePlayNode.paused == NO) {
    deltaTimeCounter = deltaTimeCounter + deltaTime;
        if (deltaTimeCounter > 2) {
            deltaTimeCounter = 0;
            [self addNewSeaweed];
        }
    }
}

@end
