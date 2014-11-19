//
//  CreditsScene.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 11/18/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "CreditsScene.h"
#import "MainMenuScene.h"

@implementation CreditsScene
{
    SKSpriteNode *buttonReturn;
}

- (void)didMoveToView:(SKView *)view {
    SKSpriteNode *backgroundSprite = [SKSpriteNode spriteNodeWithImageNamed:@"Credits.png"];
    backgroundSprite.position = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    [self addChild:backgroundSprite];
    
    buttonReturn = [SKSpriteNode spriteNodeWithImageNamed:@"Credits_Button.png"];
    buttonReturn.position = CGPointMake(self.view.frame.size.width - (buttonReturn.size.width / 2) - 30, 50);
    [self addChild:buttonReturn];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if ([buttonReturn containsPoint:location]) {
        [self.view presentScene:[MainMenuScene sceneWithSize:self.size] transition:[SKTransition doorsCloseHorizontalWithDuration:1]];
    }
}


@end
