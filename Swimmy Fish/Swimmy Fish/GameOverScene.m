//
//  GameOverScene.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 11/12/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"

@implementation GameOverScene

- (void)didMoveToView:(SKView *)view {
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithText:@"Game Over"];
    gameOverLabel.fontColor = [SKColor redColor];
    gameOverLabel.fontSize = 50;
    gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:gameOverLabel];
    
    SKLabelNode *retryLabel = [SKLabelNode labelNodeWithText:@"Touch anywhere to try again!"];
    retryLabel.position = CGPointMake(CGRectGetMidX(self.frame), gameOverLabel.position.y - 60);
    [self addChild:retryLabel];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view presentScene:[GameScene sceneWithSize:self.size] transition:[SKTransition doorsOpenHorizontalWithDuration:0.5]];
}

@end
