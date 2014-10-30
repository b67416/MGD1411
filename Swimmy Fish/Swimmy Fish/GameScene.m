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
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    self.backgroundColor = [SKColor colorWithRed:0.4f green:0.6f blue:1.0f alpha:1.0f];
    
    
    
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Play the swim up sound when user touches the screen */
    
    [self runAction:sfxSwimUp];
    
    SKAction *move = [SKAction moveByX:20 y:20 duration:.25];
    [characterMain runAction:move];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Keep the main fish moving down if not off the screen */
    
    [characterMain runAction:[SKAction moveByX:0 y:-.75 duration:1/60]];
}

@end
