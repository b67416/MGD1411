//
//  CharacterMain.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 10/29/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "CharacterMain.h"

@implementation CharacterMain
{
    SKAction *actionRotate;
    SKAction *sfxRotate;
}

- (id)initWithCharacter {
    self = [super initWithImageNamed:@"mainCharacter"];
    
    if (self) {
        /* Enable user to touch sprite */
        
        self.userInteractionEnabled = YES;
    
        /* Preload actions and SFX */
        
        actionRotate = [SKAction rotateToAngle:M_PI*2 duration:0.5];
        sfxRotate = [SKAction playSoundFileNamed:@"fishWhack.mp3" waitForCompletion:YES];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    NSLog(@"Fish Touched");
    [self runAction:[SKAction group:@[actionRotate, sfxRotate]]];
}

@end
