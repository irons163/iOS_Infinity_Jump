//
//  Star.m
//  Try_Infinity_Jump
//
//  Created by irons on 2016/1/10.
//  Copyright (c) 2016年 irons. All rights reserved.
//

#import "Star.h"

@implementation Star{
//    bool isCarStartFromLeft;
    bool readyToJump;
}

+(instancetype)floorWithImageNamed:(NSString *)name withRangeWidth:(float)rangeWidth withDistance:(float)distance{
//    Star* star = [super floorWithImageNamed:name withRangeWidth:rangeWidth withDistance:distance];
    Star* floor = [Star spriteNodeWithImageNamed:name];
//    floor->isCarStartFromLeft = YES;
    floor->rangeWidth = rangeWidth;
//    CAR_DISTANCE = distance;
    
    floor->isCarStartFromLeft = YES;
    floor->readyToJump = YES;
    return floor;
}

-(void)move{
    if(self.type==0){
        self.position = CGPointMake(self.position.x + speedX, self.position.y);
    }
    else{
        
        self.position = CGPointMake(self.position.x + speedX, self.position.y);
        
        if(!readyToJump){
            return;
        }
        
        [self removeAllActions];
        
        SKAction* upAction = [SKAction moveByX:0 y:50 duration:0.5];
        upAction.timingMode = SKActionTimingEaseOut;
        
//        float targetY = self.position.y - groundY;
        SKAction* downAction = [SKAction moveByX:0 y:-50 duration: 0.5]; downAction.timingMode = SKActionTimingEaseIn;
        
        SKAction* upEnd = [SKAction runBlock:^{
            self.texture = [SKTexture textureWithImageNamed:@"sheep_jump3"];
//            isDoubleJumpingAble = true;
        }];
        
        SKAction* end = [SKAction runBlock:^{

        }];
        
        SKAction* jump = [SKAction sequence:@[upAction, upEnd, downAction, end]];
        [self runAction:jump completion:^{
            readyToJump = YES;
        }];
        
        readyToJump = NO;
    }
    
}

@end
