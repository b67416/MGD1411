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
}

-(void)didMoveToView:(SKView *)view {
    // Setup your scene here //
    
    self.backgroundColor = [SKColor colorWithRed:0.4f green:0.6f blue:1.0f alpha:1.0f];
    
    gamePlayNode = [SKNode node];
    gamePlayNode.position = CGPointZero;
    [self addChild:gamePlayNode];
    
    
    // Setup the Physics //
    
    self.physicsWorld.gravity = CGVectorMake(0, -6);
    
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
    
    
    
    // Setup the touch controls //
    
    isCharacterAccelerating = NO;
    
    UILongPressGestureRecognizer *pressDetection = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(userPressedScreen:)];
    pressDetection.minimumPressDuration = 0.0;
    [view addGestureRecognizer:pressDetection];
    
    
    buttonWhackSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"buttonWhack.png"];
    buttonWhackSpriteNode.position = CGPointMake(self.size.width - (buttonWhackSpriteNode.size.width / 2), buttonWhackSpriteNode.size.height / 2);
    [self addChild:buttonWhackSpriteNode];
    
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
    
    sfxSwimUp = [SKAction playSoundFileNamed:@"swim.mp3" waitForCompletion:YES];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if ([buttonWhackSpriteNode containsPoint:location]) {
        [characterMain whack];
    } else {
        NSLog(@"something else tapped");
    }
}

-(void)userPressedScreen:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        isCharacterAccelerating = YES;
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        isCharacterAccelerating = NO;
    }
}

-(void)didSimulatePhysics {
    // Update the camera to follow the main fish //
    
    gamePlayNode.position = CGPointMake(100 - characterMain.position.x, 0);
}

-(void)update:(NSTimeInterval)currentTime {
    
    NSTimeInterval deltaTime = currentTime - lastUpdatedTime;
    
    if (isCharacterAccelerating == YES) {
        characterMain.physicsBody.velocity = CGVectorMake(0, 0);
        [characterMain.physicsBody applyImpulse:CGVectorMake(9000 * deltaTime, 18000 * deltaTime)];
        
        if (self.hasActions == NO) {
            [self runAction:sfxSwimUp];
        }
    }
    
    
    lastUpdatedTime = currentTime;

    
    
    // Add new seaweed after 3 seconds //
    
    deltaTimeCounter = deltaTimeCounter + deltaTime;
    if (deltaTimeCounter > 3) {
        NSLog(@"New Seaweed");
        deltaTimeCounter = 0;
        [self addNewSeaweed];
    }
}

@end
