//
//  InstructionsScene.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 11/18/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "InstructionsScene.h"
#import "MainMenuScene.h"

@implementation InstructionsScene


- (void)didMoveToView:(SKView *)view {
    SKSpriteNode *backgroundSprite = [SKSpriteNode spriteNodeWithImageNamed:@"Instructions.png"];
    backgroundSprite.position = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    [self addChild:backgroundSprite];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view presentScene:[MainMenuScene sceneWithSize:self.size] transition:[SKTransition doorsCloseHorizontalWithDuration:1]];
}

@end
