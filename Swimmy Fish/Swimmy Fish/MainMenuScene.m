//
//  MainMenuScene.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 11/18/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "MainMenuScene.h"
#import "GameScene.h"
#import "CreditsScene.h"
#import "InstructionsScene.h"

@implementation MainMenuScene
{
    SKSpriteNode *buttonCredits;
    SKSpriteNode *buttonInstructions;
    SKSpriteNode *buttonPlay;
}

- (void)didMoveToView:(SKView *)view {
    SKSpriteNode *mainMenuBackgroundSprite = [SKSpriteNode spriteNodeWithImageNamed:@"MainMenu.png"];
    mainMenuBackgroundSprite.position = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    [self addChild:mainMenuBackgroundSprite];
    
    buttonCredits = [SKSpriteNode spriteNodeWithImageNamed:@"MainMenu-Credits.png"];
    buttonCredits.position = CGPointMake(self.view.frame.size.width - (buttonCredits.size.width / 2) - 30, 50);
    [self addChild:buttonCredits];
    
    buttonInstructions = [SKSpriteNode spriteNodeWithImageNamed:@"MainMenu-Instructions.png"];
    buttonInstructions.position = CGPointMake(self.view.frame.size.width - (buttonCredits.size.width / 2) - 30, 120);
    [self addChild:buttonInstructions];
    
    buttonPlay = [SKSpriteNode spriteNodeWithImageNamed:@"MainMenu-Play.png"];
    buttonPlay.position = CGPointMake(self.view.frame.size.width - (buttonPlay.size.width / 2) - 30, 190);
    [self addChild:buttonPlay];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];

    if ([buttonPlay containsPoint:location]) {
        [self.view presentScene:[GameScene sceneWithSize:self.size] transition:[SKTransition doorsOpenHorizontalWithDuration:1]];
    } else if ([buttonCredits containsPoint:location]) {
        [self.view presentScene:[CreditsScene sceneWithSize:self.size] transition:[SKTransition doorsOpenHorizontalWithDuration:1]];
    } else if ([buttonInstructions containsPoint:location]) {
        [self.view presentScene:[InstructionsScene sceneWithSize:self.size] transition:[SKTransition doorsOpenHorizontalWithDuration:1]];
    }
}


@end
