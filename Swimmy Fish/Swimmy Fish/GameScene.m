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
    CharacterMain *characterMain;
    SKAction *sfxSwimUp;
    
    BOOL isCharacterAccelerating;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    self.backgroundColor = [SKColor colorWithRed:0.4f green:0.6f blue:1.0f alpha:1.0f];
    
    
    
    /* Some Physics Tests */
    
    self.physicsWorld.gravity = CGVectorMake(0, -1);
    
    SKNode *worldBottomBoundryNode = [SKNode node];
    worldBottomBoundryNode.position = CGPointMake(0, 0);
    worldBottomBoundryNode.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 30) toPoint:CGPointMake(self.size.width, 30)];
    worldBottomBoundryNode.physicsBody.collisionBitMask = 1;
    [self addChild:worldBottomBoundryNode];
    
    SKNode *worldTopBoundryNode = [SKNode node];
    worldTopBoundryNode.position = CGPointMake(0, 0);
    worldTopBoundryNode.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, self.size.height - 30) toPoint:CGPointMake(self.size.width, self.size.height - 30)];
    worldTopBoundryNode.physicsBody.collisionBitMask = 1;
    [self addChild:worldTopBoundryNode];
    
    isCharacterAccelerating = NO;
    
    UILongPressGestureRecognizer *pressDetection = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(userPressedScreen:)];
    pressDetection.minimumPressDuration = 0.1;
    [view addGestureRecognizer:pressDetection];
    
    
    
    /* Setup the main character fish */
    
    characterMain = [[CharacterMain alloc] initWithCharacter];
    characterMain.position = CGPointMake(100, 100);
    [self addChild:characterMain];
    
    
    
    /* Setup the seaweed */
    
    Seaweed *seaweedBottom = [[Seaweed alloc] initWithSeaweed];
    seaweedBottom.position = CGPointMake(250, seaweedBottom.size.height / 2);
    [self addChild:seaweedBottom];
    
    Seaweed *seaweedTop = [[Seaweed alloc] initWithSeaweed];
    seaweedTop.xScale = -(seaweedTop.xScale);
    seaweedTop.yScale = -(seaweedTop.yScale);
    seaweedTop.position = CGPointMake(350, self.view.bounds.size.height - (seaweedTop.size.height / 2));
    [self addChild:seaweedTop];
    
    

    /* Setup the Enemy Jelly Fish */
    
    EnemyJellyFish *enemyJellyFish = [[EnemyJellyFish alloc] initWithJellyFish];
    enemyJellyFish.position = CGPointMake(500, 250);
    [self addChild:enemyJellyFish];
    
    
    
    /* Preload the SFX */
    
    sfxSwimUp = [SKAction playSoundFileNamed:@"swim.mp3" waitForCompletion:YES];
}

-(void)userPressedScreen:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        isCharacterAccelerating = YES;
        NSLog(@"Started");
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        isCharacterAccelerating = NO;
        NSLog(@"Stopped");
    }
}

-(void)update:(NSTimeInterval)currentTime {
    if (isCharacterAccelerating == YES) {
        [characterMain.physicsBody applyForce:CGVectorMake(12000, 80000)];
        
        if (self.hasActions == NO) {
            [self runAction:sfxSwimUp];
        }
    }
}

@end
