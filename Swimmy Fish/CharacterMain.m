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
    SKAction *actionFishWhack;
    SKAction *sfxFishWhack;
}

- (id)initWithCharacter {
    self = [super initWithImageNamed:@"mainCharacter"];
    
    if (self) {
        /* Enable user to touch sprite */
        
        self.userInteractionEnabled = YES;
        
        /* Setup the scaling */
        self.xScale = .25;
        self.yScale = .25;
    
        /* Preload actions and SFX */
        
        actionFishWhack = [SKAction sequence:@[[SKAction scaleXTo:-(self.xScale) duration:.25],
                                               [SKAction scaleXTo:self.xScale duration:.25]]];
                           
        sfxFishWhack = [SKAction playSoundFileNamed:@"fishWhack.mp3" waitForCompletion:YES];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Spin the fish sprite and play SFX */
    
    if (self.hasActions == NO) {
        [self runAction:[SKAction group:@[actionFishWhack, sfxFishWhack]]];
    }
}

@end
