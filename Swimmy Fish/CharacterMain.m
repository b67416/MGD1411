//
//  CharacterMain.m
//  Swimmy Fish
//
//  Created by Ryan Wahle on 10/29/14.
//  Copyright (c) 2014 Ryan Wahle. All rights reserved.
//

#import "CharacterMain.h"

@implementation CharacterMain

+ (id)initWithCharacterSprite {
    CharacterMain *characterMain = [CharacterMain spriteNodeWithImageNamed:@"mainCharacter"];
    
    characterMain.userInteractionEnabled = YES;
    
    return characterMain;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    NSLog(@"Fish Touched");
}


@end
