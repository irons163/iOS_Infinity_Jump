 //
//  Player.m
//  Try_GoDownLayer
//
//  Created by irons on 2015/9/17.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "Player.h"
#import "GameScene.h"

@implementation Player{
    int jumpCount;
    float groundY;
    bool isDoubleJumpingAble;
    bool isJumping;
}

-(void)jump{

    if(isJumping && !isDoubleJumpingAble){
        return;
    }else if(isDoubleJumpingAble && jumpCount<2){
        isDoubleJumpingAble = false;
    }else if(jumpCount>=2){
        return;
    }
    isJumping = true;
    jumpCount++;
    [self removeAllActions];
    
    SKAction* upAction = [SKAction moveByX:0 y:100 duration:1.0];
    upAction.timingMode = SKActionTimingEaseOut;

//    float targetY = self.position.y - groundY;
//    SKAction* downAction = [SKAction moveByX:0 y:-targetY duration: 0.5];
    SKAction* downAction = [SKAction moveToY:groundY duration: 1.0];
    downAction.timingMode = SKActionTimingEaseIn;
    // 3
    //        topNode.runAction(SKAction.sequence(
    //                                            [upAction, downAction, SKAction.removeFromParent()]))
    
    SKAction* upEnd = [SKAction runBlock:^{
        self.texture = [SKTexture textureWithImageNamed:@"sheep_jump3"];
//        isDoubleJumpingAble = true;
    }];
    
    SKAction* end = [SKAction runBlock:^{
//        jumpCount--;
        isDoubleJumpingAble = false;
        isJumping = false;
        jumpCount = 0;
    }];

    SKAction* jump = [SKAction sequence:@[upAction, upEnd, downAction, end]];
    [self runAction:jump];
    
    if(jumpCount>1){
        SKAction* rotation = [SKAction rotateToAngle:90 duration:1];
        [self runAction:rotation];
    }
        
    
    isDoubleJumpingAble = true;
}

//-(void)collision{
//    
//}

-(void)setGroundY:(float)groundY{
    self->groundY = groundY;
}

-(int)getJumpCount{
    return jumpCount;
}

-(void)resetJumpCount{
    isDoubleJumpingAble = false;
    isJumping = false;
    jumpCount = 0;
}

@end
