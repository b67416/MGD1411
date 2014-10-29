//
//  GameScene.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 10/29/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "GameScene.h"
#import "CharacterMain.h"

@implementation GameScene
{
    CharacterMain *characterMain;
    SKAction *sfxSwimUp;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    self.backgroundColor = [SKColor colorWithRed:0.4f green:0.6f blue:1.0f alpha:1.0f];
    
    
    /* Setup the main character fish */
    
    characterMain = [CharacterMain initWithCharacterSprite];
    characterMain.position = CGPointMake(100, 100);
    characterMain.xScale = 0.25f;
    characterMain.yScale = 0.25f;
    [self addChild:characterMain];
    
    /* Preload the SFX */
    
    sfxSwimUp = [SKAction playSoundFileNamed:@"swim.mp3" waitForCompletion:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    /* Play the swim up sound when user touches the screen */
    [self runAction:sfxSwimUp];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
